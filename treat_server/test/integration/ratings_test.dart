import 'package:test/test.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/demo.dart';
import 'package:treat_server/src/services/ratings.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  setUp(() => clock = () => DateTime.now().toUtc());

  test('scoreOf rounds to one decimal and counts each star', () {
    final s = scoreOf([5, 4, 4, 2]);
    expect(s.average, 3.8);
    expect(s.count, 4);
    expect(s.distribution, [0, 1, 0, 2, 1]);
    expect(scoreOf([]).average, 0);
  });

  withServerpod('Given a place and a student with a claim', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder owner;
    late TestSessionBuilder ali;
    late Claim claim;
    late int shopId;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'owner@place.com');
      shopId = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!.id!;
      ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      final offer = await endpoints.shopOffers.create(owner, offerInput());
      claim = (await endpoints.claim.create(ali, offer.id!)).claim;
    });

    test('when the student rates before the place scanned the code then '
        'not_visited', () async {
      await expectLater(
        endpoints.claim.rate(ali, claim.id!, 5),
        throwsTreat('not_visited'),
      );
    });

    test('when the student rates after the scan then the score, public '
        'review and private note land in the right places', () async {
      await endpoints.shop.redeem(owner, claim.code);
      final view = await endpoints.claim.rate(
        ali,
        claim.id!,
        4,
        review: ' Great coffee ',
        privateNote: 'Music was a bit loud',
      );
      expect(view.claim.rating, 4);
      expect(view.claim.review, 'Great coffee');

      final panel = await endpoints.shop.dashboard(owner);
      expect(panel.rating.average, 4);
      expect(panel.rating.count, 1);
      expect(panel.reviews.single.privateNote, 'Music was a bit loud');

      final page = await endpoints.social.shopPage(ali, shopId);
      expect(page.rating.average, 4);
      expect(page.reviews.single.review, 'Great coffee');
      expect(page.reviews.single.privateNote, isNull);

      final cards = await endpoints.offer.listActive(ali);
      expect(cards.single.rating!.count, 1);
    });

    test('when the student changes the rating then the score follows and the '
        'claim is otherwise untouched', () async {
      await endpoints.shop.redeem(owner, claim.code);
      await endpoints.claim.rate(ali, claim.id!, 2);
      final view = await endpoints.claim.rate(ali, claim.id!, 5);
      expect(view.claim.status, ClaimStatus.redeemed);
      expect((await endpoints.shop.dashboard(owner)).rating.average, 5);
    });

    test('when the rating is out of range then invalid_rating', () async {
      await endpoints.shop.redeem(owner, claim.code);
      await expectLater(
        endpoints.claim.rate(ali, claim.id!, 6),
        throwsTreat('invalid_rating'),
      );
      await expectLater(
        endpoints.claim.rate(ali, claim.id!, 0),
        throwsTreat('invalid_rating'),
      );
    });

    test('when a demo guest writes a review then only the place sees the '
        'text', () async {
      await endpoints.shop.redeem(owner, claim.code);
      final s = sessionBuilder.build();
      final profile = (await StudentProfile.db.find(s)).single;
      await StudentProfile.db.updateRow(
        s,
        profile.copyWith(university: guestUniversity),
      );
      await endpoints.claim.rate(ali, claim.id!, 3, review: 'unmoderated');
      final page = await endpoints.social.shopPage(owner, shopId);
      expect(page.reviews.single.rating, 3);
      expect(page.reviews.single.review, isNull);
      final panel = await endpoints.shop.dashboard(owner);
      expect(panel.reviews.single.review, 'unmoderated');
    });
  });
}
