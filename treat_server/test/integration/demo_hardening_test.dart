import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/seed/demo_history.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/demo.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  setUp(() {
    clock = () => DateTime.now().toUtc();
    demoOverride = true;
  });
  tearDown(() => demoOverride = null);

  withServerpod('Given the shared demo place in demo mode', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder owner;
    late Shop shop;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'pixel@place.com');
      final created = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!;
      shop = await Shop.db.updateRow(
        sessionBuilder.build(),
        created.copyWith(seedKey: 'pixel'),
      );
    });

    Future<Offer> seededOffer() async {
      final o = await endpoints.shopOffers.create(owner, offerInput());
      return Offer.db.updateRow(
        sessionBuilder.build(),
        o.copyWith(seedKey: 'pixel:console'),
      );
    }

    test('when a judge edits, pauses or deletes a seeded offer then '
        'demo_locked', () async {
      final offer = await seededOffer();
      await expectLater(
        endpoints.shopOffers.update(owner, offer.id!, offerInput()),
        throwsTreat('demo_locked'),
      );
      await expectLater(
        endpoints.shopOffers.setStatus(owner, offer.id!, OfferStatus.paused),
        throwsTreat('demo_locked'),
      );
      await expectLater(
        endpoints.shopOffers.setStatus(owner, offer.id!, OfferStatus.ended),
        throwsTreat('demo_locked'),
      );
    });

    test('when a judge edits the place profile then demo_locked', () async {
      await expectLater(
        endpoints.profile.updateShop(owner, shopInput(name: 'Renamed')),
        throwsTreat('demo_locked'),
      );
    });

    test('when a judge creates their own offer then they can edit and pause '
        'it', () async {
      final own = await endpoints.shopOffers.create(owner, offerInput());
      await endpoints.shopOffers.update(owner, own.id!, offerInput());
      final paused = await endpoints.shopOffers.setStatus(
        owner,
        own.id!,
        OfferStatus.paused,
      );
      expect(paused.status, OfferStatus.paused);
    });

    test('when judge-made offers are hours old then the clean-up ends them '
        'but keeps seeded ones', () async {
      final seeded = await seededOffer();
      final own = await endpoints.shopOffers.create(owner, offerInput());
      clock = () => DateTime.now().toUtc().add(judgeOfferLifetime * 2);
      await cleanUpJudgeOffers(sessionBuilder.build());
      final s = sessionBuilder.build();
      expect((await Offer.db.findById(s, own.id!))!.status, OfferStatus.ended);
      expect(
        (await Offer.db.findById(s, seeded.id!))!.status,
        OfferStatus.active,
      );
    });

    test('when the demo drop sells out then a fresh one opens', () async {
      final s = sessionBuilder.build();
      await ensureDemoDrop(s);
      var drops = await Offer.db.find(
        s,
        where: (t) => t.kind.equals(OfferKind.drop),
      );
      expect(drops.single.totalCap, demoDropStock);

      // Shrink the stock and take the last slot.
      await Offer.db.updateRow(s, drops.single.copyWith(totalCap: 1));
      final ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      await endpoints.claim.create(ali, drops.single.id!);

      await ensureDemoDrop(s);
      drops = await Offer.db.find(
        s,
        where: (t) => t.kind.equals(OfferKind.drop),
      );
      expect(drops, hasLength(2));
      expect(shop.id, drops.last.shopId);
    });

    test('when a judge ends the demo drop then the next one opens at '
        'once', () async {
      final s = sessionBuilder.build();
      await ensureDemoDrop(s);
      final drop = (await Offer.db.find(
        s,
        where: (t) => t.kind.equals(OfferKind.drop),
      )).single;
      await endpoints.shopOffers.setStatus(owner, drop.id!, OfferStatus.ended);
      final live = await Offer.db.find(
        s,
        where: (t) =>
            t.kind.equals(OfferKind.drop) & t.status.equals(OfferStatus.active),
      );
      expect(live, hasLength(1));
      expect(live.single.id, isNot(drop.id));
    });
  });

  withServerpod('Given a guest and a real student with treats', (
    sessionBuilder,
    endpoints,
  ) {
    test('then only the real student is on the leaderboard', () async {
      final s = sessionBuilder.build();
      final real = await signedInAs(sessionBuilder, 'r@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(real, 'Real', 'AU');
      final realProfile = (await StudentProfile.db.find(s)).single;
      await StudentProfile.db.updateRow(s, realProfile.copyWith(treats: 2));
      final guestUser = await AuthUser.db.insertRow(
        s,
        AuthUser(scopeNames: {}),
      );
      await StudentProfile.db.insertRow(
        s,
        StudentProfile(
          authUserId: guestUser.id!,
          name: 'Guest 1234',
          email: 'guest-1234@demo.treat',
          university: guestUniversity,
          verification: StudentVerification.verified,
          categoriesTried: [],
          treats: 5,
        ),
      );
      final board = await endpoints.leaderboard.top(real);
      expect(board.map((e) => e.name), ['Real']);
    });
  });
}
