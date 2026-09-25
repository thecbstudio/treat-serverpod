import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../domain/clock.dart';
import '../generated/protocol.dart';

/// Demo data so Discover is never empty and the jury can log in.
///
/// Idempotent: rows are keyed by `seedKey` / email and never overwritten, so
/// running it on every boot is safe. Login accounts are only created when the
/// `demoAccountPassword` password is configured.
///
/// Accounts: student@demo.treat (verified student), `<slug>@demo.treat` (shops).
Future<void> seedDemoData(Session session, {String? demoPassword}) async {
  final now = clock();
  final shopIds = <String, int>{};

  for (final s in _shops) {
    final slug = s.$1;
    var shop = await Shop.db.findFirstRow(
      session,
      where: (t) => t.seedKey.equals(slug),
    );
    shop ??= await Shop.db.insertRow(
      session,
      Shop(
        seedKey: slug,
        name: s.$2,
        category: s.$3,
        district: s.$4,
        address: s.$5,
        bio: s.$6,
        instagramHandle: s.$7,
        verified: s.$8,
        createdAt: now,
      ),
    );
    if (demoPassword != null && shop.ownerId == null) {
      final ownerId = await _ensureAccount(
        session,
        '$slug@demo.treat',
        demoPassword,
      );
      final owned = await Shop.db.findFirstRow(
        session,
        where: (t) => t.ownerId.equals(ownerId),
      );
      if (owned == null) {
        shop = await Shop.db.updateRow(
          session,
          shop.copyWith(ownerId: ownerId),
        );
      }
    }
    shopIds[slug] = shop.id!;
  }

  for (final o in _offers) {
    final key = '${o.shop}:${o.key}';
    final exists = await Offer.db.findFirstRow(
      session,
      where: (t) => t.seedKey.equals(key),
    );
    if (exists != null) continue;
    final category = _shops.firstWhere((s) => s.$1 == o.shop).$3;
    await Offer.db.insertRow(
      session,
      Offer(
        shopId: shopIds[o.shop]!,
        seedKey: key,
        title: o.title,
        description: o.description,
        category: category,
        frequency: o.frequency,
        activeStartMin: o.startHour * 60,
        activeEndMin: o.endHour * 60,
        dailyCap: o.dailyCap,
        totalCap: o.totalCap,
        featured: o.featured,
        proofTypes: o.proofTypes,
        createdAt: now.subtract(Duration(days: o.ageDays)),
      ),
    );
  }

  if (demoPassword != null) {
    final authUserId = await _ensureAccount(
      session,
      'student@demo.treat',
      demoPassword,
    );
    final existing = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing == null) {
      await StudentProfile.db.insertRow(
        session,
        StudentProfile(
          authUserId: authUserId,
          name: 'Deniz Demo',
          email: 'student@demo.treat',
          university: 'Anadolu University',
          verification: StudentVerification.verified,
          categoriesTried: [],
          joinedAt: now,
        ),
      );
    }
  }
}

Future<UuidValue> _ensureAccount(
  Session session,
  String email,
  String password,
) async {
  final account = await EmailAccount.db.findFirstRow(
    session,
    where: (t) => t.email.equals(email),
  );
  if (account != null) return account.authUserId;

  return session.db.transaction((tx) async {
    final authUser = await AuthServices.instance.authUsers.create(
      session,
      transaction: tx,
    );
    await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: authUser.id,
      email: email,
      password: password,
      transaction: tx,
    );
    return authUser.id;
  });
}

// (slug, name, category, district, address, bio, instagram, verified)
const _shops = [
  (
    'kirlangic',
    'Kırlangıç Kahve',
    OfferCategory.coffee,
    'Odunpazarı',
    'Atatürk Bulvarı 42/A',
    'Third-wave coffee, beans roasted every week. Sockets and a quiet corner '
        'guaranteed for students who come to study.',
    'kirlangickahve',
    true,
  ),
  (
    'tostcu',
    'Tostçu Melih',
    OfferCategory.food,
    'Bademlik',
    'Üniversite Cad. 8',
    'The campus toastie spot since 1998. Plenty of cheese, ice-cold ayran.',
    'tostcumelih',
    true,
  ),
  (
    'duman',
    'Duman Waffle',
    OfferCategory.dessert,
    'Odunpazarı',
    'Hamamyolu Cad. 17',
    'The only place that bakes its waffles in a stone oven.',
    'dumanwaffle',
    true,
  ),
  (
    'form',
    'Form Stüdyo',
    OfferCategory.fitness,
    'Tepebaşı',
    'İsmet İnönü Cad. 55',
    'Reformer pilates and functional training.',
    'formstudyo',
    true,
  ),
  (
    'yirmi7',
    'Barber Yirmi7',
    OfferCategory.beauty,
    'Tepebaşı',
    'Çamlıca Mah. 27. Sok. 3',
    "Walk in any time, we won't keep you waiting.",
    'barberyirmi7',
    false,
  ),
  (
    'pixel',
    'Pixel Oyun Kafe',
    OfferCategory.activity,
    'Odunpazarı',
    'Kurtuluş Mah. 12/B',
    'PS5, Switch and a retro corner. Tournament nights on Fridays.',
    'pixeloyunkafe',
    true,
  ),
];

class _SeedOffer {
  const _SeedOffer({
    required this.shop,
    required this.key,
    required this.title,
    required this.description,
    required this.frequency,
    required this.startHour,
    required this.endHour,
    required this.dailyCap,
    this.totalCap,
    this.featured = false,
    this.proofTypes = const [ProofType.igStory],
    required this.ageDays,
  });

  final String shop;
  final String key;
  final String title;
  final String description;
  final OfferFrequency frequency;
  final int startHour;
  final int endHour;
  final int? dailyCap;
  final int? totalCap;
  final bool featured;
  final List<ProofType> proofTypes;
  final int ageDays;
}

const _offers = [
  _SeedOffer(
    shop: 'kirlangic',
    key: 'filter',
    title: 'Medium filter coffee',
    description:
        "A medium cup of today's brew. Tagging the place in your post is enough.",
    frequency: OfferFrequency.weekly,
    startHour: 9,
    endHour: 18,
    dailyCap: 5,
    featured: true,
    proofTypes: [ProofType.igStory, ProofType.igPost],
    ageDays: 21,
  ),
  _SeedOffer(
    shop: 'kirlangic',
    key: 'cortado',
    title: 'Cortado + cookie of the day',
    description: 'Afternoon break: a cortado and a cookie from the counter.',
    frequency: OfferFrequency.weekly,
    startHour: 14,
    endHour: 18,
    dailyCap: 3,
    proofTypes: [ProofType.igStory, ProofType.googleReview],
    ageDays: 4,
  ),
  _SeedOffer(
    shop: 'tostcu',
    key: 'toast',
    title: 'Cheese toastie + ayran',
    description:
        'Our classic: a toastie loaded with kaşar, with an ice-cold ayran.',
    frequency: OfferFrequency.weekly,
    startHour: 11,
    endHour: 17,
    dailyCap: 8,
    featured: true,
    ageDays: 30,
  ),
  _SeedOffer(
    shop: 'duman',
    key: 'waffle',
    title: 'Small waffle',
    description:
        'Small waffle with two sauces and three fruits of your choice.',
    frequency: OfferFrequency.weekly,
    startHour: 12,
    endHour: 22,
    dailyCap: 6,
    proofTypes: [ProofType.igStory, ProofType.tiktok],
    ageDays: 9,
  ),
  _SeedOffer(
    shop: 'form',
    key: 'pilates',
    title: 'Reformer pilates trial class',
    description: 'A 45-minute one-to-one intro class. Equipment provided.',
    frequency: OfferFrequency.monthly,
    startHour: 10,
    endHour: 20,
    dailyCap: 2,
    totalCap: 40,
    featured: true,
    proofTypes: [ProofType.igPost, ProofType.googleReview],
    ageDays: 14,
  ),
  _SeedOffer(
    shop: 'yirmi7',
    key: 'haircut',
    title: 'Haircut',
    description: 'Haircut, wash included.',
    frequency: OfferFrequency.monthly,
    startHour: 10,
    endHour: 19,
    dailyCap: 2,
    ageDays: 6,
  ),
  _SeedOffer(
    shop: 'pixel',
    key: 'console',
    title: '1 hour of console (PS5 / Switch)',
    description: 'One hour of console fun, solo or for two.',
    frequency: OfferFrequency.weekly,
    startHour: 13,
    endHour: 23,
    dailyCap: 4,
    ageDays: 11,
  ),
];
