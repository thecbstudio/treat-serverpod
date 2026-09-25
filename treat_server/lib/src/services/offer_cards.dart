import 'package:serverpod/serverpod.dart';

import '../domain/rules.dart';
import '../generated/protocol.dart';

/// Builds [OfferCard]s: usage from the claims table, eligibility for
/// [student] when given. [offers] must include their shop.
Future<List<OfferCard>> buildOfferCards(
  Session session,
  List<Offer> offers, {
  StudentProfile? student,
  required DateTime now,
  Transaction? transaction,
}) async {
  if (offers.isEmpty) return [];
  final offerIds = offers.map((o) => o.id!).toSet();

  // Slot usage: every claim not marked expired. The TTL check in `usageOf`
  // drops the ones whose expiry hasn't been written yet.
  final usageClaims = await Claim.db.find(
    session,
    where: (t) =>
        t.offerId.inSet(offerIds) & t.status.notEquals(ClaimStatus.expired),
    transaction: transaction,
  );
  final byOffer = <int, List<Claim>>{};
  for (final c in usageClaims) {
    (byOffer[c.offerId] ??= []).add(c);
  }

  final myClaimsByShop = <int, List<Claim>>{};
  if (student != null) {
    final shopIds = offers.map((o) => o.shopId).toSet();
    final mine = await Claim.db.find(
      session,
      where: (t) => t.studentId.equals(student.id!) & t.shopId.inSet(shopIds),
      transaction: transaction,
    );
    for (final c in mine) {
      (myClaimsByShop[c.shopId] ??= []).add(c);
    }
  }

  return [
    for (final offer in offers)
      _card(
        offer,
        usageOf(offer.id!, byOffer[offer.id] ?? const [], now),
        student,
        myClaimsByShop[offer.shopId] ?? const [],
        now,
      ),
  ];
}

OfferCard _card(
  Offer offer,
  ({int today, int total}) usage,
  StudentProfile? student,
  List<Claim> shopClaims,
  DateTime now,
) => OfferCard(
  offer: offer.copyWith(shop: null),
  shop: offer.shop!,
  claimedToday: usage.today,
  claimedTotal: usage.total,
  eligibility: student == null
      ? null
      : eligibilityOf(
          offer: offer,
          student: student,
          shopClaims: shopClaims,
          claimedToday: usage.today,
          claimedTotal: usage.total,
          now: now,
        ),
);
