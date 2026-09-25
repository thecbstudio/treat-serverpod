import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/offer_cards.dart';

/// Browsing offers (Discover + offer detail). Students also get their
/// eligibility for each offer, computed on the server.
class OfferEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<OfferCard>> listActive(Session session) async {
    final student = await findStudent(session, requireAuthUserId(session));
    final offers = await Offer.db.find(
      session,
      where: (t) => t.status.equals(OfferStatus.active),
      orderByList: (t) => [t.featured.desc(), t.createdAt.desc()],
      include: Offer.include(shop: Shop.include()),
    );
    return buildOfferCards(session, offers, student: student, now: clock());
  }

  Future<OfferCard> get(Session session, int offerId) async {
    final student = await findStudent(session, requireAuthUserId(session));
    final offer = await Offer.db.findById(
      session,
      offerId,
      include: Offer.include(shop: Shop.include()),
    );
    if (offer == null || offer.status == OfferStatus.ended) {
      throw treatError('offer_not_found', 'This offer no longer exists.');
    }
    final cards = await buildOfferCards(
      session,
      [offer],
      student: student,
      now: clock(),
    );
    return cards.single;
  }
}
