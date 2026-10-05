import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'accounts.dart';
import 'demo.dart';

/// Reports from this many different users hide a review or wall post.
const hideAfterReports = 2;

/// Flags public content. Users can't report their own content and each user
/// counts once per target. A review or wall post is hidden from public pages
/// once [hideAfterReports] different verified students reported it; places are only
/// recorded. Demo guests' reports are recorded but never hide anything, so
/// two one-tap guests can't empty the shared demo places.
Future<void> report(
  Session session,
  ReportKind kind,
  int targetId,
  ReportReason reason,
) async {
  final reporterId = requireAuthUserId(session);
  final student = await findStudent(session, reporterId);
  final shop = await findShopOf(session, reporterId);

  Claim? claim;
  switch (kind) {
    case ReportKind.review:
    case ReportKind.wallPost:
      claim = await Claim.db.findById(session, targetId);
      final public =
          claim != null &&
          (kind == ReportKind.review
              ? claim.rating != null
              : claim.status == ClaimStatus.approved && claim.shareOnWall);
      if (!public) throw treatError('not_found', 'Not found.');
      if (claim.studentId == student?.id || claim.shopId == shop?.id) {
        throw treatError('own_content', 'You can’t report your own page.');
      }
    case ReportKind.shop:
      final target = await Shop.db.findById(session, targetId);
      if (target == null) throw treatError('not_found', 'Not found.');
      if (target.id == shop?.id) {
        throw treatError('own_content', 'You can’t report your own page.');
      }
  }

  await session.db.transaction((tx) async {
    final existing = await Report.db.findFirstRow(
      session,
      where: (t) =>
          t.reporterId.equals(reporterId) &
          t.kind.equals(kind) &
          t.targetId.equals(targetId),
      transaction: tx,
    );
    if (existing != null) return;
    await Report.db.insertRow(
      session,
      Report(
        reporterId: reporterId,
        kind: kind,
        targetId: targetId,
        reason: reason,
      ),
      transaction: tx,
    );
    final target = claim;
    if (target == null) return;

    final reports = await Report.db.find(
      session,
      where: (t) => t.kind.equals(kind) & t.targetId.equals(targetId),
      transaction: tx,
    );
    // Only verified (.edu or card-checked), non-guest students count: sock
    // puppets must not be able to hide a place's bad reviews.
    final counted = await StudentProfile.db.count(
      session,
      where: (t) =>
          t.authUserId.inSet({for (final r in reports) r.reporterId}) &
          t.verification.equals(StudentVerification.verified) &
          t.university.notEquals(guestUniversity),
      transaction: tx,
    );
    if (counted < hideAfterReports) return;
    final review = kind == ReportKind.review;
    await Claim.db.updateRow(
      session,
      review
          ? target.copyWith(reviewHidden: true)
          : target.copyWith(wallHidden: true),
      columns: (t) => [review ? t.reviewHidden : t.wallHidden],
      transaction: tx,
    );
    session.log(
      'Hid ${kind.name} of claim $targetId after $counted reports',
      level: LogLevel.info,
    );
  });
}
