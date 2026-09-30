import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'accounts.dart';
import 'demo.dart';
import 'proofs.dart';

/// Deletes the signed-in user for good: their screenshots in storage, their
/// student profile (claims, ratings and reviews go with it) or their place
/// (offers and the claims made there go with it), their reports, and the
/// login itself. Counters on other rows (a place's total redeems) stay, as
/// they hold no personal data.
Future<void> deleteAccount(Session session) async {
  final authUserId = requireAuthUserId(session);
  final student = await findStudent(session, authUserId);
  final shop = await findShopOf(session, authUserId);

  if (student != null) requireNotDemoStudent(session, student);
  if (shop != null) requireNotDemoLocked(session, shop: shop);

  final checkImages = [
    for (final c in await IdentityCheck.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    ))
      ?c.imagePath,
  ];
  final claims = [
    if (student != null)
      ...await Claim.db.find(
        session,
        where: (t) => t.studentId.equals(student.id!),
      ),
    if (shop != null)
      ...await Claim.db.find(session, where: (t) => t.shopId.equals(shop.id!)),
  ];

  await session.db.transaction((tx) async {
    // Claims cascade from the student profile / the place.
    if (student != null) {
      await StudentProfile.db.deleteRow(session, student, transaction: tx);
    }
    if (shop != null) await Shop.db.deleteRow(session, shop, transaction: tx);
    // Email login, refresh tokens and reports cascade from the auth user
    // (what `AuthServices.instance.authUsers.delete` does, minus the global).
    await AuthUser.db.deleteWhere(
      session,
      where: (t) => t.id.equals(authUserId),
      transaction: tx,
    );
  });

  // Files last: a failed transaction must not leave claims without images.
  for (final path in [...claims.map((c) => c.proofPath), ...checkImages]) {
    if (path == null) continue;
    try {
      await session.storage.deleteFile(storageId: proofStorage, path: path);
    } catch (e) {
      session.log(
        'Could not delete proof $path of a deleted account',
        level: LogLevel.warning,
        exception: e,
      );
    }
  }
  await session.messages.authenticationRevoked(
    authUserId.uuid,
    RevokedAuthenticationUser(),
  );
}
