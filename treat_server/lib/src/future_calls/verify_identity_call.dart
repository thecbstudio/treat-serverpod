import 'package:serverpod/serverpod.dart';

import '../services/identity_checks.dart';

/// Runs the AI check of a student card or business document (then retries).
class VerifyIdentityCall extends FutureCall {
  Future<void> verify(Session session, int checkId) =>
      runIdentityCheck(session, checkId);
}
