import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/claims.dart';
import '../services/proofs.dart';

/// Business-side actions at the counter and the live panel.
class ShopEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// [input]: the scanned QR payload or the 6-character code.
  Future<RedeemResult> redeem(Session session, String input) =>
      redeemClaim(session, input);

  Future<ShopDashboard> dashboard(Session session) async {
    final shop = await requireShop(session);
    final now = clock();
    final activeOffers = await Offer.db.count(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) & t.status.equals(OfferStatus.active),
    );
    final claimsThisWeek = await Claim.db.count(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) &
          (t.createdAt > now.subtract(const Duration(days: 7))),
    );
    final recent = await Claim.db.find(
      session,
      where: (t) => t.shopId.equals(shop.id!),
      orderBy: (t) => t.createdAt.desc(),
      limit: 20,
      include: Claim.include(offer: Offer.include()),
    );
    final approved = await Claim.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) & t.status.equals(ClaimStatus.approved),
      include: Claim.include(student: StudentProfile.include()),
    );
    final counts = <int, ({StudentProfile s, int n})>{};
    for (final c in approved) {
      final prev = counts[c.studentId];
      counts[c.studentId] = (s: c.student!, n: (prev?.n ?? 0) + 1);
    }
    final top = counts.values.toList()..sort((a, b) => b.n.compareTo(a.n));
    final roi = roiOf(shop);

    return ShopDashboard(
      shop: shop,
      activeOffers: activeOffers,
      claimsThisWeek: claimsThisWeek,
      estimatedReach: roi.reach,
      estimatedValueTl: roi.valueTl,
      recent: [
        for (final c in recent)
          ClaimView(
            claim: presentable(c.copyWith(offer: null), now),
            offer: c.offer!,
            shop: shop,
          ),
      ],
      topStudents: [
        for (final t in top.take(5))
          TopStudent(name: t.s.name, university: t.s.university, approved: t.n),
      ],
    );
  }

  /// Every change to this shop's claims (new claim, redeem, proof, verdict),
  /// as it happens.
  Stream<ClaimView> watchFeed(Session session) async* {
    final shop = await requireShop(session);
    await for (final claim in session.messages.createStream<Claim>(
      shopChannel(shop.id!),
    )) {
      yield await claimViewOf(session, claim);
    }
  }

  /// Short-lived link to a claim's proof screenshot, for this shop only.
  Future<ProofLink> proofLink(Session session, int claimId) async {
    final shop = await requireShop(session);
    final claim = await Claim.db.findById(session, claimId);
    if (claim == null || claim.shopId != shop.id || claim.proofPath == null) {
      throw treatError('claim_not_found', 'Claim not found.');
    }
    final url = await session.storage.temporaryDownloadUrl(
      storageId: proofStorage,
      path: claim.proofPath!,
    );
    return ProofLink(claimId: claimId, url: url.toString());
  }
}
