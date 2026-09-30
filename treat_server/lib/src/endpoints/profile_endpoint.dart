import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import '../services/account_deletion.dart' as deletion;
import '../services/accounts.dart';
import '../services/demo.dart';
import '../services/google_review.dart';

/// The signed-in user's own profile and onboarding (role choice).
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Me> getMe(Session session) async {
    final authUserId = requireAuthUserId(session);
    final email = await emailOf(session, authUserId) ?? '';

    final student = await findStudent(session, authUserId);
    if (student != null) {
      final approved = await Claim.db.find(
        session,
        where: (t) =>
            t.studentId.equals(student.id!) &
            t.status.equals(ClaimStatus.approved),
      );
      final streak = computeStreakWeeks(
        approved.map((c) => c.decidedAt ?? c.createdAt),
        clock(),
      );
      return Me(
        email: email,
        role: UserRole.student,
        student: student,
        streakWeeks: streak,
        badges: computeBadges(
          treats: student.treats,
          streakWeeks: streak,
          categoriesTried: student.categoriesTried.length,
          verified: student.verification == StudentVerification.verified,
        ),
      );
    }

    final shop = await findShopOf(session, authUserId);
    return Me(
      email: email,
      role: shop == null ? null : UserRole.shop,
      shop: shop,
      badges: [],
      streakWeeks: 0,
    );
  }

  Future<Me> createStudent(
    Session session,
    String name,
    String university,
  ) async {
    final authUserId = requireAuthUserId(session);
    (name, university) = _validStudent(name, university);
    final email = await emailOf(session, authUserId);
    if (email == null) throw treatError('no_email');

    await session.db.transaction((tx) async {
      await _requireNoRole(session, authUserId, tx);
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          name: name,
          email: email,
          university: university,
          verification: isEduEmail(email)
              ? StudentVerification.verified
              : StudentVerification.pending,
          categoriesTried: [],
          joinedAt: clock(),
        ),
        transaction: tx,
      );
    });
    return getMe(session);
  }

  /// Settings: the student's name and university. Demo guests keep their
  /// university (it keeps them off public lists).
  Future<Me> updateStudent(
    Session session,
    String name,
    String university,
  ) async {
    final student = await requireStudent(session);
    requireNotDemoStudent(session, student);
    (name, university) = _validStudent(name, university);
    if (isGuest(student) && university != guestUniversity) {
      throw treatError(
        'guest_university',
        'Demo guests stay at $guestUniversity. Sign up to use your own.',
      );
    }
    await StudentProfile.db.updateRow(
      session,
      student.copyWith(name: name, university: university),
      columns: (t) => [t.name, t.university],
    );
    return getMe(session);
  }

  /// Deletes the account and everything personal in it, for good.
  Future<void> deleteAccount(Session session) =>
      deletion.deleteAccount(session);

  Future<Me> createShop(Session session, ShopInput input) async {
    final authUserId = requireAuthUserId(session);
    final clean = _validShopInput(input);
    await session.db.transaction((tx) async {
      await _requireNoRole(session, authUserId, tx);
      await Shop.db.insertRow(
        session,
        Shop(
          ownerId: authUserId,
          name: clean.name,
          category: clean.category,
          district: clean.district,
          address: clean.address,
          bio: clean.bio,
          instagramHandle: clean.instagramHandle,
          createdAt: clock(),
        ),
        transaction: tx,
      );
    });
    return getMe(session);
  }

  Future<Shop> updateShop(Session session, ShopInput input) async {
    final shop = await requireShop(session);
    requireNotDemoLocked(session, shop: shop);
    final clean = _validShopInput(input);
    // Category is fixed once offers exist: offers copy it.
    return Shop.db.updateRow(
      session,
      shop.copyWith(
        name: clean.name,
        // The badge was given for the old name: check the document again.
        verified: shop.verified && clean.name == shop.name,
        district: clean.district,
        address: clean.address,
        bio: clean.bio,
        instagramHandle: clean.instagramHandle,
      ),
    );
  }

  /// The place's Google review link for its printable counter card (null
  /// removes it). Google links only, so this stays open on the shared demo
  /// place too.
  Future<Shop> setGoogleReviewUrl(Session session, String? url) async {
    final shop = await requireShop(session);
    return Shop.db.updateRow(
      session,
      shop.copyWith(googleReviewUrl: validGoogleReviewUrl(url)),
    );
  }

  Future<void> _requireNoRole(
    Session session,
    UuidValue authUserId,
    Transaction tx,
  ) async {
    if (await findStudent(session, authUserId, transaction: tx) != null ||
        await findShopOf(session, authUserId, transaction: tx) != null) {
      throw treatError('role_already_set', 'This account already has a role.');
    }
  }

  (String, String) _validStudent(String name, String university) {
    name = name.trim();
    university = university.trim();
    if (name.isEmpty || name.length > 60) throw treatError('invalid_name');
    if (university.isEmpty || university.length > 80) {
      throw treatError('invalid_university');
    }
    return (name, university);
  }

  ShopInput _validShopInput(ShopInput input) {
    String req(String v, String code, int max) {
      final t = v.trim();
      if (t.isEmpty || t.length > max) throw treatError(code);
      return t;
    }

    var ig = input.instagramHandle?.trim().replaceFirst(RegExp('^@'), '');
    if (ig != null && ig.isEmpty) ig = null;
    if (ig != null && !RegExp(r'^[A-Za-z0-9._]{1,30}$').hasMatch(ig)) {
      throw treatError('invalid_instagram');
    }
    return ShopInput(
      name: req(input.name, 'invalid_name', 60),
      category: input.category,
      district: req(input.district, 'invalid_district', 60),
      address: req(input.address, 'invalid_address', 120),
      bio: input.bio.trim().length > 300
          ? throw treatError('invalid_bio')
          : input.bio.trim(),
      instagramHandle: ig,
    );
  }
}
