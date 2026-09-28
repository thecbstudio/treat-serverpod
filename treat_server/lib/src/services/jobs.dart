import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import 'claims.dart';
import 'proofs.dart';

/// Background work, with or without future calls.
///
/// Serverpod Cloud's Starter plan runs with future calls disabled. Then:
/// - expiry needs no job: rules already treat a claim past its TTL as expired
///   (and give its slot back), and redeem/watch report it that way;
/// - proof verification runs in-process on its own session instead, and
///   [resumePendingVerifications] picks up anything a restart interrupted.
bool futureCallsEnabled(Session session) =>
    session.serverpod.config.futureCallExecutionEnabled;

Future<void> scheduleExpiry(Session session, Claim claim) async {
  if (!futureCallsEnabled(session)) return;
  await session.serverpod.futureCalls
      .callAtTime(claim.expiresAt, identifier: expireCallId(claim.id!))
      .expireClaimCall
      .expire(claim.id!);
}

Future<void> cancelExpiry(Session session, int claimId) async {
  if (!futureCallsEnabled(session)) return;
  await session.serverpod.futureCalls.cancel(expireCallId(claimId));
}

Future<void> scheduleVerification(
  Session session,
  int claimId, {
  Duration delay = Duration.zero,
}) async {
  if (futureCallsEnabled(session)) {
    await session.serverpod.futureCalls
        .callWithDelay(delay, identifier: verifyCallId(claimId))
        .verifyProofCall
        .verify(claimId);
    return;
  }
  final pod = session.serverpod;
  unawaited(
    Future<void>.delayed(delay, () async {
      final background = await pod.createSession();
      try {
        await runProofVerification(background, claimId);
      } catch (e, st) {
        background.log(
          'In-process proof verification failed for claim $claimId',
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

/// On boot without future calls: restart verification of proofs that were
/// still pending when the server stopped.
Future<void> resumePendingVerifications(Session session) async {
  if (futureCallsEnabled(session)) return;
  final pending = await Claim.db.find(
    session,
    where: (t) => t.status.equals(ClaimStatus.proofPending),
  );
  for (final c in pending) {
    await scheduleVerification(session, c.id!);
  }
}
