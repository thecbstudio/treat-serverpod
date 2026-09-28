import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/claims.dart';
import '../services/proofs.dart';

/// A student's claims: create, list, open, and watch one live.
class ClaimEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// How often [watch] re-reads the claim even without a message, so the
  /// screen stays correct across server instances and at expiry time.
  static Duration watchRecheck = const Duration(seconds: 5);

  Future<ClaimView> create(Session session, int offerId) =>
      createClaim(session, offerId);

  /// Where to upload the proof screenshot for [claimId].
  Future<ProofUpload> proofUpload(Session session, int claimId) =>
      startProofUpload(session, claimId);

  /// Submits the uploaded screenshot (first proof, or the one appeal after a
  /// rejection). Verification runs in the background; watch the claim.
  Future<ClaimView> submitProof(
    Session session,
    int claimId,
    ProofType proofType,
    String path, {
    // Nullable instead of `= false`: the generator turns a defaulted named
    // parameter into `required` on the client (FEEDBACK.md #8).
    bool? shareOnWall,
  }) => submitProofFor(
    session,
    claimId,
    proofType,
    path,
    shareOnWall: shareOnWall ?? false,
  );

  /// Demo accounts only: submits a ready-made story screenshot that tags the
  /// place ([good]) or tags nobody, through the same verification.
  Future<ClaimView> submitSampleProof(
    Session session,
    int claimId,
    bool good, {
    bool? shareOnWall,
  }) => submitSampleProofFor(
    session,
    claimId,
    good: good,
    shareOnWall: shareOnWall ?? false,
  );

  /// After approval: a short thank-you note to the place (shown on its page
  /// and in its panel) and whether the post may appear on its public wall.
  Future<ClaimView> thank(
    Session session,
    int claimId,
    String? note,
    bool shareOnWall,
  ) async {
    final claim = await _requireOwnClaim(session, claimId);
    if (claim.status != ClaimStatus.approved) {
      throw treatError(
        'not_approved',
        'You can thank the place after approval.',
      );
    }
    final text = note?.trim();
    if (text != null && text.length > 280) throw treatError('note_too_long');
    final updated = await Claim.db.updateRow(
      session,
      claim.copyWith(
        thanksNote: (text == null || text.isEmpty) ? null : text,
        shareOnWall: shareOnWall,
      ),
    );
    await notifyClaimChanged(session, updated);
    return claimViewOf(session, updated);
  }

  /// Newest first.
  Future<List<ClaimView>> listMine(Session session) async {
    final student = await requireStudent(session);
    final claims = await Claim.db.find(
      session,
      where: (t) => t.studentId.equals(student.id!),
      orderBy: (t) => t.createdAt.desc(),
      limit: 100,
      include: Claim.include(
        offer: Offer.include(shop: Shop.include()),
      ),
    );
    final now = clock();
    return [
      for (final c in claims)
        ClaimView(
          claim: presentable(c.copyWith(offer: null), now),
          offer: c.offer!.copyWith(shop: null),
          shop: c.offer!.shop!,
        ),
    ];
  }

  Future<ClaimView> get(Session session, int claimId) async =>
      claimViewOf(session, await _requireOwnClaim(session, claimId));

  /// Current state first, then every change (redeemed, expired, …).
  Stream<ClaimView> watch(Session session, int claimId) async* {
    final initial = await _requireOwnClaim(session, claimId);
    var last = await claimViewOf(session, initial);
    yield last;

    final wake = StreamController<void>();
    final messages = session.messages
        .createStream<Claim>(claimChannel(claimId))
        .listen((_) => wake.add(null), onError: (_) => wake.add(null));
    final timer = Timer.periodic(watchRecheck, (_) => wake.add(null));
    try {
      await for (final _ in wake.stream) {
        final claim = await Claim.db.findById(session, claimId);
        if (claim == null) return;
        final next = presentable(claim, clock());
        if (_sameState(next, last.claim)) continue;
        last = last.copyWith(claim: next);
        yield last;
      }
    } finally {
      timer.cancel();
      await messages.cancel();
      await wake.close();
    }
  }

  static bool _sameState(Claim a, Claim b) =>
      a.status == b.status &&
      a.redeemedAt == b.redeemedAt &&
      a.proofSubmittedAt == b.proofSubmittedAt &&
      a.verdictReason == b.verdictReason &&
      a.appealed == b.appealed &&
      a.thanksNote == b.thanksNote &&
      a.shareOnWall == b.shareOnWall;

  Future<Claim> _requireOwnClaim(Session session, int claimId) async {
    final student = await requireStudent(session);
    final claim = await Claim.db.findById(session, claimId);
    if (claim == null || claim.studentId != student.id) {
      throw treatError('claim_not_found', 'Claim not found.');
    }
    return claim;
  }
}
