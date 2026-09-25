import 'package:test/test.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/domain/rules.dart';
import 'package:treat_server/src/generated/protocol.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Istanbul 12:00 on a Monday — inside the offers' active hours.
  final noon = DateTime.utc(2026, 7, 20, 12).subtract(istanbulOffset);
  setUp(() => clock = () => noon);

  withServerpod('Given the profile endpoint', (sessionBuilder, endpoints) {
    test('when not signed in then getMe is rejected', () async {
      await expectLater(
        endpoints.profile.getMe(sessionBuilder),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test('when a new user calls getMe then role is null', () async {
      final user = await signedInAs(sessionBuilder, 'new@gmail.com');
      final me = await endpoints.profile.getMe(user);
      expect(me.role, isNull);
      expect(me.email, 'new@gmail.com');
    });

    test('when a .edu user becomes a student then verified', () async {
      final user = await signedInAs(sessionBuilder, 'a@ogr.anadolu.edu.tr');
      final me = await endpoints.profile.createStudent(user, ' Ayşe ', 'AU');
      expect(me.role, UserRole.student);
      expect(me.student!.name, 'Ayşe');
      expect(me.student!.verification, StudentVerification.verified);
      expect(me.badges, [BadgeId.verifiedStudent]);
    });

    test('when a non-edu user becomes a student then pending', () async {
      final user = await signedInAs(sessionBuilder, 'b@gmail.com');
      final me = await endpoints.profile.createStudent(user, 'Bora', 'AU');
      expect(me.student!.verification, StudentVerification.pending);
    });

    test('when a user already has a role then a second role fails', () async {
      final user = await signedInAs(sessionBuilder, 'c@gmail.com');
      await endpoints.profile.createStudent(user, 'Cem', 'AU');
      await expectLater(
        endpoints.profile.createShop(user, shopInput()),
        throwsTreat('role_already_set'),
      );
    });

    test('when creating a shop then the instagram "@" is stripped', () async {
      final user = await signedInAs(sessionBuilder, 'shop@gmail.com');
      final me = await endpoints.profile.createShop(user, shopInput());
      expect(me.role, UserRole.shop);
      expect(me.shop!.instagramHandle, 'testcafe');
    });
  });

  withServerpod('Given a shop and a student', (sessionBuilder, endpoints) {
    late TestSessionBuilder shop;
    late TestSessionBuilder otherShop;
    late TestSessionBuilder student;

    setUp(() async {
      shop = await signedInAs(sessionBuilder, 'owner@cafe.com');
      await endpoints.profile.createShop(shop, shopInput());
      otherShop = await signedInAs(sessionBuilder, 'owner@other.com');
      await endpoints.profile.createShop(otherShop, shopInput(name: 'Other'));
      student = await signedInAs(sessionBuilder, 's@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(student, 'Selin', 'AU');
    });

    test('when the shop creates an offer then it copies the shop category '
        'and dedupes proof types', () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      expect(offer.category, OfferCategory.coffee);
      expect(offer.proofTypes, [ProofType.igStory, ProofType.googleReview]);
      expect(offer.status, OfferStatus.active);
    });

    test('when a student tries to create an offer then not_a_shop', () async {
      await expectLater(
        endpoints.shopOffers.create(student, offerInput()),
        throwsTreat('not_a_shop'),
      );
    });

    test('when the input is invalid then the server rejects it', () async {
      await expectLater(
        endpoints.shopOffers.create(
          shop,
          offerInput(startMin: 600, endMin: 500),
        ),
        throwsTreat('invalid_hours'),
      );
    });

    test('when another shop edits the offer then offer_not_found', () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      await expectLater(
        endpoints.shopOffers.setStatus(
          otherShop,
          offer.id!,
          OfferStatus.paused,
        ),
        throwsTreat('offer_not_found'),
      );
    });

    test('when the student lists offers then eligibility is ok', () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      final cards = await endpoints.offer.listActive(student);
      final card = cards.singleWhere((c) => c.offer.id == offer.id);
      expect(card.shop.name, 'Test Café');
      expect(card.eligibility!.reason, EligibilityReason.ok);
    });

    test('when the offer is paused then it leaves Discover but stays in '
        "the shop's list", () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      await endpoints.shopOffers.setStatus(shop, offer.id!, OfferStatus.paused);
      final cards = await endpoints.offer.listActive(student);
      expect(cards.where((c) => c.offer.id == offer.id), isEmpty);
      final mine = await endpoints.shopOffers.listMine(shop);
      expect(mine.single.offer.status, OfferStatus.paused);
      expect(mine.single.eligibility, isNull);
    });

    test('when the offer is ended then get reports offer_not_found', () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      await endpoints.shopOffers.setStatus(shop, offer.id!, OfferStatus.ended);
      await expectLater(
        endpoints.offer.get(student, offer.id!),
        throwsTreat('offer_not_found'),
      );
      expect(await endpoints.shopOffers.listMine(shop), isEmpty);
    });

    test(
      'when outside active hours then the student sees outsideHours',
      () async {
        final offer = await endpoints.shopOffers.create(
          shop,
          offerInput(startMin: 14 * 60, endMin: 18 * 60),
        );
        final card = await endpoints.offer.get(student, offer.id!);
        expect(card.eligibility!.reason, EligibilityReason.outsideHours);
        expect(card.eligibility!.opensAtMin, 14 * 60);
      },
    );

    test('when claims fill the daily cap then dailyCap, and an expired '
        'claim gives its slot back', () async {
      final offer = await endpoints.shopOffers.create(
        shop,
        offerInput(dailyCap: 1),
      );
      final session = sessionBuilder.build();
      final other = await signedInAs(sessionBuilder, 'x@ogr.anadolu.edu.tr');
      final otherMe = await endpoints.profile.createStudent(other, 'X', 'AU');
      final claim = await Claim.db.insertRow(
        session,
        Claim(
          offerId: offer.id!,
          shopId: offer.shopId,
          studentId: otherMe.student!.id!,
          studentName: 'X',
          frequency: offer.frequency,
          code: 'ABC234',
          status: ClaimStatus.active,
          createdAt: noon.subtract(const Duration(minutes: 5)),
          expiresAt: noon.add(const Duration(minutes: 115)),
        ),
      );

      var card = await endpoints.offer.get(student, offer.id!);
      expect(card.claimedToday, 1);
      expect(card.eligibility!.reason, EligibilityReason.dailyCap);

      await Claim.db.updateRow(
        session,
        claim.copyWith(status: ClaimStatus.expired),
      );
      card = await endpoints.offer.get(student, offer.id!);
      expect(card.claimedToday, 0);
      expect(card.eligibility!.reason, EligibilityReason.ok);
    });
  });
}
