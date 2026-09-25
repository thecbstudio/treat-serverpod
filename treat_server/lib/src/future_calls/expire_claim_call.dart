import 'package:serverpod/serverpod.dart';

import '../services/claims.dart';

/// Scheduled at a claim's `expiresAt`. Marks it expired if it was never
/// redeemed and tells anyone watching. Idempotent.
class ExpireClaimCall extends FutureCall {
  Future<void> expire(Session session, int claimId) =>
      expireClaimIfDue(session, claimId);
}
