import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import 'accounts.dart';
import 'claims.dart';
import 'demo.dart';
import 'social.dart' show handedOver;

const maxReviewLength = 280;

/// The treat score of each place in [shopIds] (places without ratings get an
/// empty score). One query for all places.
Future<Map<int, ShopRating>> ratingsFor(
  Session session,
  Set<int> shopIds, {
  Transaction? transaction,
}) async {
  if (shopIds.isEmpty) return {};
  final rated = await Claim.db.find(
    session,
    where: (t) => t.shopId.inSet(shopIds) & t.rating.notEquals(null),
    transaction: transaction,
  );
  final byShop = <int, List<int>>{};
  for (final c in rated) {
    (byShop[c.shopId] ??= []).add(c.rating!);
  }
  return {for (final id in shopIds) id: scoreOf(byShop[id] ?? const [])};
}

ShopRating scoreOf(List<int> ratings) {
  final distribution = List.filled(5, 0);
  for (final r in ratings) {
    distribution[r - 1]++;
  }
  final count = ratings.length;
  final average = count == 0 ? 0.0 : ratings.reduce((a, b) => a + b) / count;
  return ShopRating(
    // One decimal, like every star rating people know.
    average: (average * 10).round() / 10,
    count: count,
    distribution: distribution,
  );
}

/// Newest rated visits of [shopId]. [forOwner] adds the private notes; the
/// public version hides demo guests' free text (nobody moderates it).
Future<List<Review>> reviewsFor(
  Session session,
  int shopId, {
  required bool forOwner,
  int limit = 20,
}) async {
  final claims = await Claim.db.find(
    session,
    where: (t) => t.shopId.equals(shopId) & t.rating.notEquals(null),
    orderBy: (t) => t.ratedAt.desc(),
    limit: limit,
    include: Claim.include(
      offer: Offer.include(),
      student: StudentProfile.include(),
    ),
  );
  return [
    for (final c in claims)
      Review(
        claimId: c.id!,
        studentId: c.studentId,
        studentName: c.student!.name,
        university: c.student!.university,
        rating: c.rating!,
        review: forOwner || !isGuest(c.student!) ? c.review : null,
        privateNote: forOwner ? c.privateNote : null,
        offerTitle: c.offer!.title,
        ratedAt: c.ratedAt ?? c.createdAt,
      ),
  ];
}

/// A student rates their visit: only once they were scanned in (the claim
/// was handed over), 1–5 stars, optional short public review and private
/// note. Can be changed later. The rating never affects the treat.
Future<ClaimView> rateVisit(
  Session session,
  int claimId,
  int stars, {
  String? review,
  String? privateNote,
}) async {
  if (stars < 1 || stars > 5) throw treatError('invalid_rating');
  final text = _clean(review);
  final note = _clean(privateNote);
  final student = await requireStudent(session);
  final claim = await Claim.db.findById(session, claimId);
  if (claim == null || claim.studentId != student.id) {
    throw treatError('claim_not_found', 'Claim not found.');
  }
  if (!handedOver.contains(claim.status)) {
    throw treatError(
      'not_visited',
      'You can rate the place after it scanned your code.',
    );
  }
  final updated = await Claim.db.updateRow(
    session,
    claim.copyWith(
      rating: stars,
      review: text,
      privateNote: note,
      ratedAt: clock(),
    ),
  );
  await notifyClaimChanged(session, updated);
  return claimViewOf(session, updated);
}

String? _clean(String? s) {
  final t = s?.trim();
  if (t == null || t.isEmpty) return null;
  if (t.length > maxReviewLength) throw treatError('note_too_long');
  return t;
}
