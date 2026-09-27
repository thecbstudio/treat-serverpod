import 'package:serverpod/serverpod.dart';

import '../services/proofs.dart';

/// Runs the AI check for a submitted proof (right after submit, then retries).
class VerifyProofCall extends FutureCall {
  Future<void> verify(Session session, int claimId) =>
      runProofVerification(session, claimId);
}
