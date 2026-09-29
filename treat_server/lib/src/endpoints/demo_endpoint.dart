import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';
import '../services/accounts.dart';
import '../services/demo.dart';

/// One-tap demo sign-in for judges. Only works when the server runs in demo
/// mode (`demoAccountPassword` is set), so a real deployment can switch it off.
///
/// Every "try as a student" gets a fresh guest student: a shared account would
/// let one judge's claim (once a week per place) or strikes block the next.
/// The business side signs into the shared demo shop, which can serve many
/// students at once.
class DemoEndpoint extends Endpoint {
  /// Guard against someone scripting thousands of guest accounts.
  static const maxGuestsPerHour = 120;
  static const demoShopEmail = 'pixel@demo.treat';

  Future<bool> enabled(Session session) async => demoModeOn(session);

  Future<AuthSuccess> signInAsGuestStudent(Session session) async {
    requireDemoMode(session);
    final now = clock();
    final recent = await StudentProfile.db.count(
      session,
      where: (t) =>
          t.university.equals(guestUniversity) &
          (t.joinedAt > now.subtract(const Duration(hours: 1))),
    );
    if (recent >= maxGuestsPerHour) {
      throw treatError(
        'demo_busy',
        'Too many demo sign-ins right now. Try again in a few minutes.',
      );
    }
    final number = 1000 + Random.secure().nextInt(9000);
    final authUserId = await session.db.transaction((tx) async {
      final authUser = await AuthServices.instance.authUsers.create(
        session,
        transaction: tx,
      );
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUser.id,
          name: 'Guest $number',
          email: 'guest-$number@demo.treat',
          university: guestUniversity,
          verification: StudentVerification.verified,
          categoriesTried: [],
          joinedAt: now,
        ),
        transaction: tx,
      );
      return authUser.id;
    });
    return _issue(session, authUserId);
  }

  Future<AuthSuccess> signInAsDemoShop(Session session) async {
    requireDemoMode(session);
    final account = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.email.equals(demoShopEmail),
    );
    if (account == null) {
      throw treatError('demo_off', 'The demo business is not set up.');
    }
    return _issue(session, account.authUserId);
  }

  Future<AuthSuccess> _issue(Session session, UuidValue authUserId) async {
    final authUser = await AuthServices.instance.authUsers.get(
      session,
      authUserId: authUserId,
    );
    return AuthServices.instance.tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: 'demo',
      scopes: authUser.scopes,
    );
  }
}
