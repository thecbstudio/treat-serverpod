import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/offer_cards.dart';
import '../services/social.dart';

/// Public pages: a place's page with its wall, a student's profile, and the
/// latest shared posts. Never exposes emails or strikes.
class SocialEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<ShopPage> shopPage(Session session, int shopId) async {
    final shop = await Shop.db.findById(session, shopId);
    if (shop == null) throw treatError('not_found', 'Place not found.');
    final student = await findStudent(session, requireAuthUserId(session));
    final now = clock();
    final offers = await Offer.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shopId) &
          t.status.equals(OfferStatus.active) &
          (t.kind.equals(OfferKind.regular) | (t.endsAt > now)),
      orderByList: (t) => [t.kind.desc(), t.createdAt.desc()],
      include: Offer.include(shop: Shop.include()),
    );
    return ShopPage(
      shop: shop,
      offers: await buildOfferCards(
        session,
        offers,
        student: student,
        now: now,
      ),
      studentsTreated: await studentsTreated(session, shopId),
      wall: await wallPosts(session, shopId: shopId),
    );
  }

  Future<PublicStudent> student(Session session, int studentId) =>
      publicStudent(session, studentId);

  /// Latest shared posts across all places (Discover strip).
  Future<List<WallPost>> recentPosts(Session session) =>
      wallPosts(session, limit: 12);
}
