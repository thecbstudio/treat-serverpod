import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/offer_cards.dart';

/// A business managing its own offers.
class ShopOffersEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// All non-ended offers, newest first, with usage.
  Future<List<OfferCard>> listMine(Session session) async {
    final shop = await requireShop(session);
    final offers = await Offer.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) & t.status.notEquals(OfferStatus.ended),
      orderBy: (t) => t.createdAt.desc(),
      include: Offer.include(shop: Shop.include()),
    );
    return buildOfferCards(session, offers, now: clock());
  }

  Future<Offer> create(Session session, OfferInput input) async {
    final shop = await requireShop(session);
    _validate(input);
    return Offer.db.insertRow(
      session,
      Offer(
        shopId: shop.id!,
        title: input.title.trim(),
        description: input.description.trim(),
        category: shop.category,
        frequency: input.frequency,
        activeStartMin: input.activeStartMin,
        activeEndMin: input.activeEndMin,
        dailyCap: input.dailyCap,
        totalCap: input.totalCap,
        proofTypes: input.proofTypes.toSet().toList(),
        createdAt: clock(),
      ),
    );
  }

  Future<Offer> update(Session session, int offerId, OfferInput input) async {
    final offer = await _requireOwnOffer(session, offerId);
    _validate(input);
    return Offer.db.updateRow(
      session,
      offer.copyWith(
        title: input.title.trim(),
        description: input.description.trim(),
        frequency: input.frequency,
        activeStartMin: input.activeStartMin,
        activeEndMin: input.activeEndMin,
        dailyCap: input.dailyCap,
        totalCap: input.totalCap,
        proofTypes: input.proofTypes.toSet().toList(),
      ),
    );
  }

  /// active ⇄ paused, or ended (= deleted from the shop's point of view;
  /// the row stays because claims reference it).
  Future<Offer> setStatus(
    Session session,
    int offerId,
    OfferStatus status,
  ) async {
    final offer = await _requireOwnOffer(session, offerId);
    if (offer.status == OfferStatus.ended) {
      throw treatError('offer_ended', 'This offer was deleted.');
    }
    return Offer.db.updateRow(session, offer.copyWith(status: status));
  }

  Future<Offer> _requireOwnOffer(Session session, int offerId) async {
    final shop = await requireShop(session);
    final offer = await Offer.db.findById(session, offerId);
    if (offer == null || offer.shopId != shop.id) {
      throw treatError('offer_not_found', 'Offer not found.');
    }
    return offer;
  }

  void _validate(OfferInput input) {
    final error = validateOfferInput(input);
    if (error != null) throw treatError(error);
  }
}
