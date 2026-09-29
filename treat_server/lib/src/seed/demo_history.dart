import 'dart:io';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../domain/clock.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import '../services/claims.dart';
import '../services/proofs.dart';

/// Demo history so the app looks lived-in for judges: students who already
/// collected treats over the past weeks, their shared posts (with the proof
/// screenshots from `seed_assets/proofs`) and thank-you notes.
///
/// Runs once: skipped when the first demo student already exists. All of it
/// is demo data and is described as such in the README.
Future<void> seedDemoHistory(Session session) async {
  final marker = await StudentProfile.db.findFirstRow(
    session,
    where: (t) => t.email.equals(_students.first.email),
  );
  if (marker != null) return;

  final now = clock();
  final offers = {
    for (final o in await Offer.db.find(
      session,
      where: (t) => t.seedKey.notEquals(null),
    ))
      o.seedKey!: o,
  };

  for (final s in _students) {
    final authUser = await AuthServices.instance.authUsers.create(session);
    var student = await StudentProfile.db.insertRow(
      session,
      StudentProfile(
        authUserId: authUser.id,
        name: s.name,
        email: s.email,
        university: s.university,
        verification: StudentVerification.verified,
        categoriesTried: [],
        joinedAt: now.subtract(const Duration(days: 45)),
      ),
    );
    for (final h in s.history) {
      final offer = offers[h.offerKey];
      if (offer == null) continue;
      student = await _addHistoryClaim(session, student, offer, h, now);
    }
  }
}

/// Gives the jury's demo student a little history (older than a week, so
/// every place can still be claimed today).
Future<void> seedJuryStudentHistory(
  Session session,
  StudentProfile student,
) async {
  final existing = await Claim.db.count(
    session,
    where: (t) => t.studentId.equals(student.id!),
  );
  if (existing > 0) return;
  final now = clock();
  final offers = {
    for (final o in await Offer.db.find(
      session,
      where: (t) => t.seedKey.notEquals(null),
    ))
      o.seedKey!: o,
  };
  var s = student;
  for (final h in const [
    _H(
      'kirlangic:filter',
      'kirlangic_0.jpg',
      9,
      'Perfect study spot, thank you!',
    ),
    _H('pixel:console', 'pixel_6.jpg', 16, 'We will be back on Friday'),
  ]) {
    final offer = offers[h.offerKey];
    if (offer != null) s = await _addHistoryClaim(session, s, offer, h, now);
  }
}

Future<StudentProfile> _addHistoryClaim(
  Session session,
  StudentProfile student,
  Offer offer,
  _H h,
  DateTime now,
) async {
  final createdAt = now.subtract(Duration(days: h.daysAgo, hours: 3));
  final approved = h.image != null;
  String? proofPath;
  if (approved) {
    proofPath = 'proofs/seed/${h.image}';
    final file = File('seed_assets/proofs/${h.image}');
    if (await file.exists() &&
        !await session.storage.fileExists(
          storageId: proofStorage,
          path: proofPath,
        )) {
      await session.storage.storeFile(
        storageId: proofStorage,
        path: proofPath,
        byteData: ByteData.sublistView(await file.readAsBytes()),
      );
    }
  }
  await Claim.db.insertRow(
    session,
    Claim(
      offerId: offer.id!,
      shopId: offer.shopId,
      studentId: student.id!,
      studentName: student.name,
      frequency: offer.frequency,
      code: newClaimCode(),
      status: approved ? ClaimStatus.approved : ClaimStatus.redeemed,
      createdAt: createdAt,
      expiresAt: createdAt.add(claimTtl),
      redeemedAt: createdAt.add(const Duration(minutes: 12)),
      proofType: approved ? offer.proofTypes.first : null,
      proofPath: proofPath,
      proofSubmittedAt: approved
          ? createdAt.add(const Duration(hours: 2))
          : null,
      decidedAt: approved
          ? createdAt.add(const Duration(hours: 2, minutes: 1))
          : null,
      shareOnWall: approved,
      thanksNote: h.thanks,
    ),
  );
  final shop = await Shop.db.findById(session, offer.shopId);
  await Shop.db.updateRow(
    session,
    shop!.copyWith(
      totalRedeems: shop.totalRedeems + 1,
      approvedProofs: shop.approvedProofs + (approved ? 1 : 0),
    ),
  );
  if (!approved) return student;
  return StudentProfile.db.updateRow(
    session,
    student.copyWith(
      treats: student.treats + 1,
      categoriesTried: {...student.categoriesTried, offer.category}.toList(),
    ),
  );
}

/// Stock of the always-on demo drop: enough for a busy judging hour.
const demoDropStock = 20;

/// Keeps one live drop with stock left at Pixel Oyun Kafe (the jury's
/// business login) so a drop can be tried at any time — also right after a
/// judge ended it or the last slot was taken. Called on boot, every minute,
/// and when a demo drop is ended.
Future<void> ensureDemoDrop(Session session) async {
  final pixel = await Shop.db.findFirstRow(
    session,
    where: (t) => t.seedKey.equals('pixel'),
  );
  if (pixel == null) return;
  final now = clock();
  final live = await Offer.db.find(
    session,
    where: (t) =>
        t.shopId.equals(pixel.id!) &
        t.kind.equals(OfferKind.drop) &
        t.status.equals(OfferStatus.active) &
        (t.endsAt > now.add(const Duration(minutes: 5))),
  );
  for (final drop in live) {
    final taken = await Claim.db.count(
      session,
      where: (t) =>
          t.offerId.equals(drop.id!) & t.status.notEquals(ClaimStatus.expired),
    );
    if (taken < (drop.totalCap ?? 0)) return;
  }
  const titles = [
    (
      'Free 30 minutes on the PS5',
      'Two consoles just freed up. Walk in, play.',
    ),
    (
      'Retro corner: 30 minutes free',
      'The SNES and the arcade cabinet are free.',
    ),
    (
      'Switch Mario Kart slot',
      'Race the staff — 30 minutes, controllers ready.',
    ),
  ];
  final pick = titles[now.hour % titles.length];
  final drop = await Offer.db.insertRow(
    session,
    Offer(
      shopId: pixel.id!,
      kind: OfferKind.drop,
      title: pick.$1,
      description: pick.$2,
      category: pixel.category,
      frequency: OfferFrequency.weekly,
      activeStartMin: 0,
      activeEndMin: 24 * 60,
      totalCap: demoDropStock,
      proofTypes: const [ProofType.igStory, ProofType.tiktok],
      featured: true,
      createdAt: now,
      endsAt: now.add(const Duration(minutes: 90)),
    ),
  );
  await notifyDropChanged(session, drop.id!);
}

class _H {
  const _H(this.offerKey, this.image, this.daysAgo, [this.thanks]);

  final String offerKey;

  /// Screenshot in seed_assets/proofs; null = redeemed, post not sent yet.
  final String? image;
  final int daysAgo;
  final String? thanks;
}

class _Student {
  const _Student(this.email, this.name, this.university, this.history);
  final String email;
  final String name;
  final String university;
  final List<_H> history;
}

const _anadolu = 'Anadolu University';
const _ogu = 'Eskişehir Osmangazi University';
const _estu = 'Eskişehir Technical University';

const _students = [
  _Student('deniz.yurt@students.demo.treat', 'Deniz Yurt', _anadolu, [
    _H(
      'kirlangic:filter',
      'kirlangic_0.jpg',
      2,
      'Best place to study before finals.',
    ),
    _H('pixel:console', 'pixel_6.jpg', 9, 'Retro corner forever'),
    _H('ferah:scoops', null, 1),
    _H('duman:waffle', null, 16),
    _H('tostcu:toast', null, 23),
  ]),
  _Student('ece.kaya@students.demo.treat', 'Ece Kaya', _ogu, [
    _H('kirlangic:cortado', 'kirlangic_1.jpg', 3, 'That cortado!'),
    _H('firin:simit', 'firin_7.jpg', 10, 'Still warm at 8 am, thank you'),
    _H('mavikitap:latte', null, 18),
  ]),
  _Student('mert.aslan@students.demo.treat', 'Mert Aslan', _estu, [
    _H('tostcu:toast', 'tostcu_2.jpg', 1, 'Kaşar was generous as promised'),
    _H('bowling:game', 'bowling_10.jpg', 8),
    _H('pixel:console', null, 15),
  ]),
  _Student('zeynep.ari@students.demo.treat', 'Zeynep Arı', _anadolu, [
    _H(
      'duman:waffle',
      'duman_3.jpg',
      4,
      'Stone-oven waffle is a different league',
    ),
    _H('ferah:scoops', 'ferah_9.jpg', 2, 'Pistachio. Every. Time.'),
    _H('firin:simit', null, 11),
    _H('kirlangic:filter', null, 25),
  ]),
  _Student('selin.oz@students.demo.treat', 'Selin Öz', _ogu, [
    _H('form:pilates', 'form_4.jpg', 6, 'Booked a second class right after'),
    _H('glow:manicure', 'glow_11.jpg', 2),
  ]),
  _Student('burak.tas@students.demo.treat', 'Burak Taş', _estu, [
    _H('pixel:console', 'pixel_5.jpg', 5, 'FIFA night was legendary'),
  ]),
  _Student('can.demir@students.demo.treat', 'Can Demir', _anadolu, [
    _H(
      'mavikitap:latte',
      'mavikitap_8.jpg',
      7,
      'Found a first edition on the shelf!',
    ),
    _H('kirlangic:filter', null, 14),
  ]),
  _Student('ayse.yildiz@students.demo.treat', 'Ayşe Yıldız', _ogu, [
    _H('tostcu:toast', null, 3),
  ]),
];

/// Demo mode: offers judges create on the shared seeded places are removed
/// after a few hours, so the next judge sees the places as seeded.
Future<void> cleanUpJudgeOffers(Session session) async {
  final seeded = await Shop.db.find(
    session,
    where: (t) => t.seedKey.notEquals(null),
  );
  if (seeded.isEmpty) return;
  final old = await Offer.db.find(
    session,
    where: (t) =>
        t.shopId.inSet({for (final s in seeded) s.id!}) &
        t.seedKey.equals(null) &
        t.kind.equals(OfferKind.regular) &
        t.status.notEquals(OfferStatus.ended) &
        (t.createdAt < clock().subtract(judgeOfferLifetime)),
  );
  for (final o in old) {
    await Offer.db.updateRow(session, o.copyWith(status: OfferStatus.ended));
  }
}

const judgeOfferLifetime = Duration(hours: 6);
