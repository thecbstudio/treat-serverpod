import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../ai/proof_verifier.dart';
import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import 'accounts.dart';
import 'claims.dart';
import 'demo.dart';
import 'post_links.dart';
import 'jobs.dart';

const proofStorage = 'private';
const maxProofBytes = 5 * 1024 * 1024;
const maxVerifyAttempts = 3;

/// Set when verification failed for technical reasons (claim goes back to
/// `redeemed`, no strike, the student can simply send it again).
const verifyFailedReason = 'verify_failed';

String verifyCallId(int claimId) => 'verify-proof-$claimId';

/// Swappable for tests. Built lazily from `anthropicApiKey` /
/// `anthropicModel` in passwords.yaml.
ProofVerifier? proofVerifierOverride;

ProofVerifier _verifier(Session session) {
  final override = proofVerifierOverride;
  if (override != null) return override;
  final key = session.passwords['anthropicApiKey'];
  if (key == null || key.isEmpty) {
    throw VerifierUnavailable('anthropicApiKey is not configured');
  }
  return AnthropicProofVerifier(
    apiKey: key,
    model:
        session.passwords['anthropicModel'] ??
        AnthropicProofVerifier.defaultModel,
  );
}

Future<Claim> _ownClaim(
  Session session,
  int claimId, {
  Transaction? transaction,
  bool lock = false,
}) async {
  final student = await requireStudent(session, transaction: transaction);
  final claim = await Claim.db.findById(
    session,
    claimId,
    transaction: transaction,
    lockMode: lock ? LockMode.forUpdate : null,
  );
  if (claim == null || claim.studentId != student.id) {
    throw treatError('claim_not_found', 'Claim not found.');
  }
  return claim;
}

bool _canUpload(Claim c) =>
    c.status == ClaimStatus.redeemed ||
    (c.status == ClaimStatus.rejected && !c.appealed);

/// Where the client uploads the screenshot. The path is chosen here, never by
/// the client.
Future<ProofUpload> startProofUpload(Session session, int claimId) async {
  final claim = await _ownClaim(session, claimId);
  if (!_canUpload(claim)) {
    throw treatError(
      'proof_not_allowed',
      'This claim does not take a proof now.',
    );
  }
  final path = 'proofs/$claimId/${clock().millisecondsSinceEpoch}.img';
  final description = await session.storage.createUploadDescription(
    storageId: proofStorage,
    path: path,
    options: const UploadOptions(maxFileSize: maxProofBytes),
  );
  return ProofUpload(path: path, uploadDescription: description);
}

/// First proof (claim is `redeemed`) or the one appeal (claim is `rejected`).
Future<ClaimView> submitProofFor(
  Session session,
  int claimId,
  ProofType proofType,
  String path, {
  bool shareOnWall = false,
  String? postUrl,
}) async {
  if (!path.startsWith('proofs/$claimId/') || path.contains('..')) {
    throw treatError('invalid_proof', 'Upload the screenshot again.');
  }
  // verifyUpload is false for an already verified file, so also accept an
  // existing one (retry of the same submit).
  final uploaded =
      await session.storage.verifyUpload(storageId: proofStorage, path: path) ||
      await session.storage.fileExists(storageId: proofStorage, path: path);
  if (!uploaded) {
    throw treatError('invalid_proof', 'Upload the screenshot again.');
  }

  final bytes = await session.storage.retrieveFile(
    storageId: proofStorage,
    path: path,
  );
  final data = bytes.buffer.asUint8List(
    bytes.offsetInBytes,
    bytes.lengthInBytes,
  );
  if (data.length > maxProofBytes || imageMediaType(data) == null) {
    throw treatError('invalid_proof', 'Upload a JPEG, PNG or WebP screenshot.');
  }

  final claim = await session.db.transaction((tx) async {
    final claim = await _ownClaim(
      session,
      claimId,
      transaction: tx,
      lock: true,
    );
    if (!_canUpload(claim)) {
      throw treatError(
        'proof_not_allowed',
        'This claim does not take a proof now.',
      );
    }
    final offer = await Offer.db.findById(
      session,
      claim.offerId,
      transaction: tx,
    );
    if (!offer!.proofTypes.contains(proofType) ||
        !offerableProofTypes.contains(proofType)) {
      throw treatError(
        'proof_type_not_accepted',
        'Pick one of the listed posts.',
      );
    }
    final link = validPostUrl(proofType, postUrl);
    final isAppeal = claim.status == ClaimStatus.rejected;
    return Claim.db.updateRow(
      session,
      claim.copyWith(
        status: ClaimStatus.proofPending,
        proofType: proofType,
        proofPath: path,
        proofSubmittedAt: clock(),
        verdictReason: null,
        verifyAttempts: 0,
        appealed: claim.appealed || isAppeal,
        shareOnWall: shareOnWall,
        postUrl: link,
        stillUpCheckedAt: null,
      ),
      transaction: tx,
    );
  });

  await scheduleVerification(session, claimId);
  await notifyClaimChanged(session, claim);
  return claimViewOf(session, claim);
}

/// Demo students only: stores a ready-made story screenshot (one that tags the
/// place, or one that tags nobody) and submits it through the normal path, so
/// judges can see Claude approve and reject without posting anything.
Future<ClaimView> submitSampleProofFor(
  Session session,
  int claimId,
  SampleProof kind,
) async {
  requireDemoMode(session);
  final student = await requireStudent(session);
  if (!isDemoStudent(student)) {
    throw treatError('demo_off', 'Samples are for demo accounts only.');
  }
  final claim = await _ownClaim(session, claimId);
  if (!_canUpload(claim)) {
    throw treatError(
      'proof_not_allowed',
      'This claim does not take a proof now.',
    );
  }
  final offer = await Offer.db.findById(session, claim.offerId);
  final shop = await Shop.db.findById(session, claim.shopId);
  final bytes = !offer!.proofTypes.contains(ProofType.igStory)
      ? null
      : await sampleProofBytes(shop!, kind);
  if (bytes == null) {
    throw treatError('no_sample', 'No sample screenshot for this offer.');
  }
  final path =
      'proofs/$claimId$sampleProofMarker${clock().millisecondsSinceEpoch}.img';
  await session.storage.storeFile(
    storageId: proofStorage,
    path: path,
    byteData: ByteData.sublistView(Uint8List.fromList(bytes)),
  );
  // Someone else's screenshot: verified for real, never shown on a wall.
  return submitProofFor(session, claimId, ProofType.igStory, path);
}

/// Run by the VerifyProof future call. Asks the AI, then applies the verdict:
/// approve → +1 treat (and gives back the strike if this was a won appeal);
/// reject → one strike per claim at most. Technical failures retry with
/// backoff; after [maxVerifyAttempts] the claim returns to `redeemed` with no
/// strike so the student can resend.
Future<void> runProofVerification(Session session, int claimId) async {
  final claim = await Claim.db.findById(
    session,
    claimId,
    include: Claim.include(offer: Offer.include(shop: Shop.include())),
  );
  if (claim == null ||
      claim.status != ClaimStatus.proofPending ||
      claim.proofPath == null) {
    return;
  }

  ProofVerdict verdict;
  try {
    final bytes = await session.storage.retrieveFile(
      storageId: proofStorage,
      path: claim.proofPath!,
    );
    final data = bytes.buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
    final mediaType = imageMediaType(data);
    verdict = mediaType == null
        ? const ProofVerdict.rejected(RejectReason.unreadable)
        : await _verifier(session).verify(
            ProofContext(
              image: data,
              mediaType: mediaType,
              proofType: claim.proofType ?? ProofType.igStory,
              shopName: claim.offer!.shop!.name,
              instagramHandle: claim.offer!.shop!.instagramHandle,
              offerTitle: claim.offer!.title,
            ),
          );
  } catch (e, st) {
    session.log(
      'Proof verification failed for claim $claimId',
      level: LogLevel.warning,
      exception: e,
      stackTrace: st,
    );
    await _retryOrGiveUp(session, claimId);
    return;
  }

  final updated = await session.db.transaction((tx) async {
    final c = await Claim.db.findById(
      session,
      claimId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (c == null || c.status != ClaimStatus.proofPending) return null;
    final student = await StudentProfile.db.findById(
      session,
      c.studentId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    final now = clock();

    if (verdict.approved) {
      final category = claim.offer!.category;
      await StudentProfile.db.updateRow(
        session,
        student!.copyWith(
          treats: student.treats + 1,
          categoriesTried: {...student.categoriesTried, category}.toList(),
          // A won appeal gives back the strike of the first rejection.
          strikes: c.strikeGiven ? student.strikes - 1 : student.strikes,
        ),
        transaction: tx,
      );
      final shop = await Shop.db.findById(
        session,
        c.shopId,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      await Shop.db.updateRow(
        session,
        shop!.copyWith(approvedProofs: shop.approvedProofs + 1),
        transaction: tx,
      );
      return Claim.db.updateRow(
        session,
        c.copyWith(
          status: ClaimStatus.approved,
          decidedAt: now,
          verdictReason: null,
          strikeGiven: false,
        ),
        transaction: tx,
      );
    }

    // Rejected: at most one strike per claim (a lost appeal adds none).
    if (!c.strikeGiven) {
      await StudentProfile.db.updateRow(
        session,
        student!.copyWith(strikes: student.strikes + 1),
        transaction: tx,
      );
    }
    return Claim.db.updateRow(
      session,
      c.copyWith(
        status: ClaimStatus.rejected,
        decidedAt: now,
        verdictReason: verdict.reason!.key,
        strikeGiven: true,
      ),
      transaction: tx,
    );
  });
  if (updated != null) await notifyClaimChanged(session, updated);
}

/// Verdict reason when the place reported an approved post as taken down.
const flaggedReason = 'flagged_by_place';

/// Verdict reason when the TikTok was no longer online at the 7-day check.
const postRemovedReason = 'post_removed';

/// How long after approval a place can report a story as taken down;
/// permanent posts (feed post, Reel, TikTok) get [stillUpAfter].
const flagWindow = Duration(hours: 48);

Duration flagWindowFor(ProofType? type) =>
    permanentProofTypes.contains(type) ? stillUpAfter : flagWindow;

/// The place reports that an approved post was deleted (the "post it,
/// screenshot it, delete it" trick no screenshot check can catch). Once per
/// claim, within [flagWindowFor]: the treat is taken back, the student gets
/// the claim's strike, and there is no appeal — a second screenshot can't
/// prove the post is still up.
Future<ClaimView> flagApprovedProof(Session session, int claimId) async {
  final shop = await requireShop(session);
  final updated = await session.db.transaction((tx) async {
    final c = await Claim.db.findById(
      session,
      claimId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (c == null || c.shopId != shop.id) {
      throw treatError('claim_not_found', 'Claim not found.');
    }
    if (c.status != ClaimStatus.approved) {
      throw treatError('not_approved', 'Only approved posts can be reported.');
    }
    final decided = c.decidedAt ?? c.createdAt;
    if (clock().difference(decided) > flagWindowFor(c.proofType)) {
      throw treatError(
        'flag_window_over',
        'This post can no longer be reported.',
      );
    }
    final student = await StudentProfile.db.findById(session, c.studentId);
    // Demo: the shared place can't rewrite seeded students' history.
    if (!isGuest(student!)) requireNotDemoLocked(session, shop: shop);
    return _revokeApproval(session, tx, c, flaggedReason);
  });
  await notifyClaimChanged(session, updated);
  return claimViewOf(session, updated);
}

/// Re-checks TikToks approved [stillUpAfter] ago: still online → marked
/// checked; gone → treat taken back like a place report; unknown (network,
/// TikTok hiccup) → tried again next run. Returns how many were taken back.
Future<int> checkPostsStillUp(Session session) async {
  final stillUp = postStillUpOverride ?? tiktokStillUp;
  var removed = 0;
  for (final due in await tiktoksDueForCheck(session)) {
    final up = await stillUp(due.postUrl!);
    if (up == null) continue;
    final updated = await session.db.transaction((tx) async {
      final c = await Claim.db.findById(
        session,
        due.id!,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (c == null ||
          c.status != ClaimStatus.approved ||
          c.stillUpCheckedAt != null) {
        return null;
      }
      if (up) {
        return Claim.db.updateRow(
          session,
          c.copyWith(stillUpCheckedAt: clock()),
          transaction: tx,
        );
      }
      return _revokeApproval(session, tx, c, postRemovedReason);
    });
    if (updated == null) continue;
    if (!up) {
      removed++;
      await notifyClaimChanged(session, updated);
    }
  }
  return removed;
}

/// Takes an approved treat back: -1 treat, the claim's strike, the place's
/// approved count down, off the wall, no appeal.
Future<Claim> _revokeApproval(
  Session session,
  Transaction tx,
  Claim c,
  String reason,
) async {
  final student = await StudentProfile.db.findById(
    session,
    c.studentId,
    lockMode: LockMode.forUpdate,
    transaction: tx,
  );
  await StudentProfile.db.updateRow(
    session,
    student!.copyWith(
      treats: student.treats > 0 ? student.treats - 1 : 0,
      strikes: c.strikeGiven ? student.strikes : student.strikes + 1,
    ),
    transaction: tx,
  );
  final shop = await Shop.db.findById(
    session,
    c.shopId,
    lockMode: LockMode.forUpdate,
    transaction: tx,
  );
  await Shop.db.updateRow(
    session,
    shop!.copyWith(
      approvedProofs: shop.approvedProofs > 0 ? shop.approvedProofs - 1 : 0,
    ),
    transaction: tx,
  );
  return Claim.db.updateRow(
    session,
    c.copyWith(
      status: ClaimStatus.rejected,
      decidedAt: clock(),
      verdictReason: reason,
      strikeGiven: true,
      appealed: true, // no appeal after a removal
      shareOnWall: false,
      stillUpCheckedAt: clock(),
    ),
    transaction: tx,
  );
}

Future<void> _retryOrGiveUp(Session session, int claimId) async {
  final result = await session.db.transaction((tx) async {
    final c = await Claim.db.findById(
      session,
      claimId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (c == null || c.status != ClaimStatus.proofPending) return null;
    final attempts = c.verifyAttempts + 1;
    if (attempts < maxVerifyAttempts) {
      return (
        claim: await Claim.db.updateRow(
          session,
          c.copyWith(verifyAttempts: attempts),
          transaction: tx,
        ),
        retry: true,
      );
    }
    // Give up without a strike. An appeal stays unused if the AI never
    // answered it.
    return (
      claim: await Claim.db.updateRow(
        session,
        c.copyWith(
          status: c.strikeGiven ? ClaimStatus.rejected : ClaimStatus.redeemed,
          appealed: c.strikeGiven ? false : c.appealed,
          verifyAttempts: attempts,
          verdictReason: verifyFailedReason,
        ),
        transaction: tx,
      ),
      retry: false,
    );
  });
  if (result == null) return;
  if (result.retry) {
    // 20 s, then 60 s.
    final delay = Duration(seconds: result.claim.verifyAttempts == 1 ? 20 : 60);
    await scheduleVerification(session, claimId, delay: delay);
  } else {
    await notifyClaimChanged(session, result.claim);
  }
}

/// Shop ROI numbers (see rules.dart for the benchmark constants).
({int reach, int valueTl}) roiOf(Shop shop) {
  final reach = estimateReach(shop.approvedProofs);
  return (reach: reach, valueTl: estimateMarketingValueTl(reach));
}
