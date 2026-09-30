import 'dart:async';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../ai/document_verifier.dart';
import '../ai/proof_verifier.dart';
import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import 'accounts.dart';
import 'jobs.dart' show futureCallsEnabled;
import 'proofs.dart' show proofStorage, maxProofBytes, verifyFailedReason;

/// Checks one user may start per Istanbul day (each costs an AI call).
const maxChecksPerDay = 3;
const _maxAttempts = 3;

/// Swappable for tests. Built from `anthropicApiKey` like the proof verifier.
DocumentVerifier? documentVerifierOverride;

DocumentVerifier _verifier(Session session) {
  final override = documentVerifierOverride;
  if (override != null) return override;
  final key = session.passwords['anthropicApiKey'];
  if (key == null || key.isEmpty) {
    throw VerifierUnavailable('anthropicApiKey is not configured');
  }
  return AnthropicDocumentVerifier(
    apiKey: key,
    model:
        session.passwords['anthropicModel'] ??
        AnthropicProofVerifier.defaultModel,
  );
}

String identityCallId(int checkId) => 'identity-check-$checkId';

/// The signed-in user's kind of check: students without a verified status
/// send a student card, businesses without the badge send a document.
Future<VerificationKind> _kindFor(Session session, UuidValue authUserId) async {
  final student = await findStudent(session, authUserId);
  if (student != null) {
    if (student.verification == StudentVerification.verified) {
      throw treatError('already_verified', 'You are already verified.');
    }
    return VerificationKind.studentCard;
  }
  final shop = await findShopOf(session, authUserId);
  if (shop != null) {
    if (shop.verified) {
      throw treatError('already_verified', 'Your place is already verified.');
    }
    return VerificationKind.businessDocument;
  }
  throw treatError('no_role', 'Finish setting up your account first.');
}

/// Newest check of the signed-in user (null if none yet).
Future<IdentityCheck?> latestCheck(Session session) =>
    IdentityCheck.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(requireAuthUserId(session)),
      orderBy: (t) => t.createdAt.desc(),
    );

/// Where the client uploads the photo. The server picks the path.
Future<ProofUpload> startCheckUpload(Session session) async {
  final authUserId = requireAuthUserId(session);
  await _kindFor(session, authUserId);
  final path =
      'verifications/${authUserId.uuid}/${clock().millisecondsSinceEpoch}.img';
  final description = await session.storage.createUploadDescription(
    storageId: proofStorage,
    path: path,
    options: const UploadOptions(maxFileSize: maxProofBytes),
  );
  return ProofUpload(path: path, uploadDescription: description);
}

/// Starts the AI check of an uploaded photo.
Future<IdentityCheck> submitCheck(Session session, String path) async {
  final authUserId = requireAuthUserId(session);
  final kind = await _kindFor(session, authUserId);
  if (!path.startsWith('verifications/${authUserId.uuid}/') ||
      path.contains('..')) {
    throw treatError('invalid_proof', 'Upload the photo again.');
  }
  final uploaded =
      await session.storage.verifyUpload(storageId: proofStorage, path: path) ||
      await session.storage.fileExists(storageId: proofStorage, path: path);
  if (!uploaded) throw treatError('invalid_proof', 'Upload the photo again.');
  final bytes = await session.storage.retrieveFile(
    storageId: proofStorage,
    path: path,
  );
  final data = Uint8List.sublistView(bytes);
  if (data.length > maxProofBytes || imageMediaType(data) == null) {
    await _deleteImage(session, path);
    throw treatError('invalid_proof', 'Use a JPEG, PNG or WebP photo.');
  }

  final check = await session.db.transaction((tx) async {
    // One at a time per user, and a few a day.
    final today = await IdentityCheck.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          (t.status.equals(CheckStatus.pending) |
              (t.createdAt >= istanbulDayStart(clock()))),
      transaction: tx,
      lockMode: LockMode.forUpdate,
    );
    if (today.any((c) => c.status == CheckStatus.pending)) {
      throw treatError('check_pending', 'Your last photo is still checked.');
    }
    if (today.length >= maxChecksPerDay) {
      throw treatError(
        'too_many_checks',
        'That was $maxChecksPerDay tries today. Try again tomorrow.',
      );
    }
    return IdentityCheck.db.insertRow(
      session,
      IdentityCheck(
        authUserId: authUserId,
        kind: kind,
        imagePath: path,
        status: CheckStatus.pending,
        createdAt: clock(),
      ),
      transaction: tx,
    );
  });
  await scheduleIdentityCheck(session, check.id!);
  return check;
}

Future<void> scheduleIdentityCheck(
  Session session,
  int checkId, {
  Duration delay = Duration.zero,
}) async {
  if (futureCallsEnabled(session)) {
    await session.serverpod.futureCalls
        .callWithDelay(delay, identifier: identityCallId(checkId))
        .verifyIdentityCall
        .verify(checkId);
    return;
  }
  final pod = session.serverpod;
  unawaited(
    Future<void>.delayed(delay, () async {
      final background = await pod.createSession();
      try {
        await runIdentityCheck(background, checkId);
      } catch (e, st) {
        background.log(
          'In-process identity check $checkId failed',
          level: LogLevel.error,
          exception: e,
          stackTrace: st,
        );
      } finally {
        await background.close();
      }
    }),
  );
}

/// On boot without future calls: restart checks a restart interrupted.
Future<void> resumePendingIdentityChecks(Session session) async {
  if (futureCallsEnabled(session)) return;
  final pending = await IdentityCheck.db.find(
    session,
    where: (t) => t.status.equals(CheckStatus.pending),
  );
  for (final c in pending) {
    await scheduleIdentityCheck(session, c.id!);
  }
}

/// Asks the AI, applies the verdict (student verified / place gets the
/// badge; a rejected student stays unable to claim), then deletes the photo.
/// Technical failures retry with backoff, then end as `failed`.
Future<void> runIdentityCheck(Session session, int checkId) async {
  final check = await IdentityCheck.db.findById(session, checkId);
  if (check == null ||
      check.status != CheckStatus.pending ||
      check.imagePath == null) {
    return;
  }
  final student = await findStudent(session, check.authUserId);
  final shop = student == null
      ? await findShopOf(session, check.authUserId)
      : null;
  if (student == null && shop == null) return;

  DocumentVerdict verdict;
  try {
    final bytes = await session.storage.retrieveFile(
      storageId: proofStorage,
      path: check.imagePath!,
    );
    final data = Uint8List.sublistView(bytes);
    final mediaType = imageMediaType(data);
    final today = istanbulWallClock(clock()).toIso8601String().substring(0, 10);
    verdict = mediaType == null
        ? const DocumentVerdict.rejected('unreadable')
        : await _verifier(session).verify(
            DocumentContext(
              image: data,
              mediaType: mediaType,
              kind: check.kind,
              name: student?.name ?? shop!.name,
              detail:
                  student?.university ??
                  '${shop!.address}, '
                      '${shop.district}',
              today: today,
            ),
          );
  } catch (e, st) {
    session.log(
      'Identity check $checkId failed',
      level: LogLevel.warning,
      exception: e,
      stackTrace: st,
    );
    final attempts = check.attempts + 1;
    if (attempts < _maxAttempts) {
      await IdentityCheck.db.updateRow(
        session,
        check.copyWith(attempts: attempts),
      );
      await scheduleIdentityCheck(
        session,
        checkId,
        delay: Duration(seconds: 20 * attempts),
      );
      return;
    }
    await _decide(
      session,
      check.copyWith(attempts: attempts),
      CheckStatus.failed,
      verifyFailedReason,
    );
    return;
  }

  await _decide(
    session,
    check,
    verdict.approved ? CheckStatus.approved : CheckStatus.rejected,
    verdict.reason,
    student: student,
    shop: shop,
  );
}

Future<void> _decide(
  Session session,
  IdentityCheck check,
  CheckStatus status,
  String? reason, {
  StudentProfile? student,
  Shop? shop,
}) async {
  final path = check.imagePath;
  await session.db.transaction((tx) async {
    await IdentityCheck.db.updateRow(
      session,
      check.copyWith(
        status: status,
        reason: reason,
        decidedAt: clock(),
        imagePath: null,
      ),
      transaction: tx,
    );
    if (status == CheckStatus.failed) return;
    final approved = status == CheckStatus.approved;
    if (student != null) {
      await StudentProfile.db.updateRow(
        session,
        student.copyWith(
          verification: approved
              ? StudentVerification.verified
              : StudentVerification.rejected,
        ),
        columns: (t) => [t.verification],
        transaction: tx,
      );
    } else if (shop != null && approved) {
      await Shop.db.updateRow(
        session,
        shop.copyWith(verified: true),
        columns: (t) => [t.verified],
        transaction: tx,
      );
    }
  });
  // The photo is only needed for the check.
  if (path != null) await _deleteImage(session, path);
}

Future<void> _deleteImage(Session session, String path) async {
  try {
    await session.storage.deleteFile(storageId: proofStorage, path: path);
  } catch (e) {
    session.log(
      'Could not delete verification photo $path',
      level: LogLevel.warning,
      exception: e,
    );
  }
}
