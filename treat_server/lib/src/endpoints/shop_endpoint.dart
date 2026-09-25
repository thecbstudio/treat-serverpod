import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/claims.dart';

/// Business-side actions at the counter.
class ShopEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// [input]: the scanned QR payload or the 6-character code.
  Future<RedeemResult> redeem(Session session, String input) =>
      redeemClaim(session, input);
}
