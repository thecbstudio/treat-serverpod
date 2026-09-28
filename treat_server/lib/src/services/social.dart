import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import 'proofs.dart';

/// Claims that handed a treat over (everything after the scan).
const handedOver = {
  ClaimStatus.redeemed,
  ClaimStatus.proofPending,
  ClaimStatus.approved,
  ClaimStatus.rejected,
};

/// Public wall: approved posts whose students opted in, newest first.
/// Filter by [shopId] or [studentId], or neither for the global feed.
Future<List<WallPost>> wallPosts(
  Session session, {
  int? shopId,
  int? studentId,
  int limit = 24,
}) async {
  final claims = await Claim.db.find(
    session,
    where: (t) {
      var w =
          t.status.equals(ClaimStatus.approved) & t.shareOnWall.equals(true);
      if (shopId != null) w = w & t.shopId.equals(shopId);
      if (studentId != null) w = w & t.studentId.equals(studentId);
      return w;
    },
    orderBy: (t) => t.decidedAt.desc(),
    limit: limit,
    include: Claim.include(
      offer: Offer.include(shop: Shop.include()),
      student: StudentProfile.include(),
    ),
  );
  final posts = <WallPost>[];
  for (final c in claims) {
    final path = c.proofPath;
    if (path == null) continue;
    final url = await session.storage.temporaryDownloadUrl(
      storageId: proofStorage,
      path: path,
    );
    posts.add(
      WallPost(
        claimId: c.id!,
        studentId: c.studentId,
        studentName: c.student!.name,
        university: c.student!.university,
        shopId: c.shopId,
        shopName: c.offer!.shop!.name,
        offerTitle: c.offer!.title,
        proofType: c.proofType ?? ProofType.igStory,
        thanksNote: c.thanksNote,
        approvedAt: c.decidedAt ?? c.createdAt,
        imageUrl: url.toString(),
      ),
    );
  }
  return posts;
}

/// Distinct students who received a treat from [shopId].
Future<int> studentsTreated(Session session, int shopId) async {
  final claims = await Claim.db.find(
    session,
    where: (t) => t.shopId.equals(shopId) & t.status.inSet(handedOver),
  );
  return claims.map((c) => c.studentId).toSet().length;
}

Future<PublicStudent> publicStudent(Session session, int studentId) async {
  final s = await StudentProfile.db.findById(session, studentId);
  if (s == null) throw TreatException(code: 'not_found', message: 'Not found.');
  final approved = await Claim.db.find(
    session,
    where: (t) =>
        t.studentId.equals(studentId) & t.status.equals(ClaimStatus.approved),
  );
  final streak = computeStreakWeeks(
    approved.map((c) => c.decidedAt ?? c.createdAt),
    clock(),
  );
  return PublicStudent(
    id: s.id!,
    name: s.name,
    university: s.university,
    treats: s.treats,
    streakWeeks: streak,
    badges: computeBadges(
      treats: s.treats,
      streakWeeks: streak,
      categoriesTried: s.categoriesTried.length,
      verified: s.verification == StudentVerification.verified,
    ),
    joinedAt: s.joinedAt,
    wall: await wallPosts(session, studentId: studentId, limit: 12),
  );
}
