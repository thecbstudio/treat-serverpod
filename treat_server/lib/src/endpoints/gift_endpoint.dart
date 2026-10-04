import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/gifts.dart' as gifts;

/// "Treatleme": a student pays for a treat at a verified place (iyzico's
/// hosted payment page) and gives it to another verified student.
class GiftEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// `off`, `sandbox` or `live`: whether and how this server takes payments.
  Future<String> mode(Session session) async => gifts.paymentMode(session);

  /// Verified places a gift can go to.
  Future<List<Shop>> places(Session session) => gifts.giftableShops(session);

  /// Creates the gift and returns iyzico's payment page to open.
  Future<GiftCheckout> send(Session session, GiftInput input) =>
      gifts.startGift(session, input);

  Future<List<GiftView>> sent(Session session) => gifts.sentGifts(session);

  Future<List<GiftView>> received(Session session) =>
      gifts.receivedGifts(session);

  Future<GiftView> get(Session session, int giftId) =>
      gifts.giftFor(session, giftId);

  /// Sender: "I paid, where is my gift?" Asks iyzico and applies the result.
  Future<GiftView> confirm(Session session, int giftId) =>
      gifts.confirmGift(session, giftId);

  /// Sender: take the gift back (refund) while it isn't collected.
  Future<GiftView> cancel(Session session, int giftId) =>
      gifts.cancelGift(session, giftId);
}
