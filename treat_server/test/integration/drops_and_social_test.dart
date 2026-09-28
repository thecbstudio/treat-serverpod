import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/domain/rules.dart';
import 'package:treat_server/src/endpoints/offer_endpoint.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show FakeVerifier, jpeg;
import 'test_tools/serverpod_test_tools.dart';

DropInput dropInput({int quantity = 2, int minutes = 30}) => DropInput(
  title: 'Last croissants',
  description: 'Fresh from this morning',
  quantity: quantity,
  durationMinutes: minutes,
  proofTypes: [ProofType.igStory],
);

void main() {
  // 21:30 Istanbul: outside the test offers' hours on purpose.
  final evening = DateTime.utc(2026, 7, 20, 21, 30).subtract(istanbulOffset);
  late DateTime now;
  late FakeVerifier fake;
  setUp(() {
    now = evening;
    clock = () => now;
    fake = FakeVerifier();
    proofVerifierOverride = fake;
  });

  withServerpod('Given a shop and two students', (sessionBuilder, endpoints) {
    late TestSessionBuilder shop;
    late TestSessionBuilder ali;
    late TestSessionBuilder bea;

    setUp(() async {
      shop = await signedInAs(sessionBuilder, 'd-owner@cafe.com');
      await endpoints.profile.createShop(shop, shopInput());
      ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      bea = await signedInAs(sessionBuilder, 'bea@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(bea, 'Bea', 'AU');
    });

    Future<Claim> approvedClaim({required bool share}) async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      final claim = (await endpoints.claim.create(ali, offer.id!)).claim;
      await endpoints.shop.redeem(shop, claim.code);
      final up = await endpoints.claim.proofUpload(ali, claim.id!);
      await sessionBuilder.build().storage.storeFile(
        storageId: proofStorage,
        path: up.path,
        byteData: ByteData.sublistView(jpeg),
      );
      await endpoints.claim.submitProof(
        ali,
        claim.id!,
        ProofType.igStory,
        up.path,
        shareOnWall: share,
      );
      fake.answers.add(const ProofVerdict.approved());
      await runProofVerification(sessionBuilder.build(), claim.id!);
      return claim;
    }

    test('when a drop starts then it has stock, an end time and is not in '
        'the regular list', () async {
      final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
      expect(drop.kind, OfferKind.drop);
      expect(drop.totalCap, 2);
      expect(drop.endsAt, evening.add(const Duration(minutes: 30)));
      final regular = await endpoints.offer.listActive(ali);
      expect(regular.where((c) => c.offer.id == drop.id), isEmpty);
    });

    test('when students claim then stock runs out, and the claim expires at '
        'the pickup deadline', () async {
      final drop = await endpoints.shopOffers.startDrop(
        shop,
        dropInput(quantity: 1),
      );
      final view = await endpoints.claim.create(ali, drop.id!);
      expect(view.claim.fromDrop, isTrue);
      expect(view.claim.expiresAt, drop.endsAt!.add(dropPickupGrace));
      await expectLater(
        endpoints.claim.create(bea, drop.id!),
        throwsA(
          isA<TreatException>().having((e) => e.message, 'reason', 'totalCap'),
        ),
      );
    });

    test(
      'when the student already claimed the drop then alreadyClaimed',
      () async {
        final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
        final claim = (await endpoints.claim.create(ali, drop.id!)).claim;
        await endpoints.shop.redeem(shop, claim.code);
        final card = await endpoints.offer.get(ali, drop.id!);
        expect(card.eligibility!.reason, EligibilityReason.alreadyClaimed);
      },
    );

    test('when the drop window has passed then dropEnded', () async {
      final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
      now = drop.endsAt!;
      final card = await endpoints.offer.get(ali, drop.id!);
      expect(card.eligibility!.reason, EligibilityReason.dropEnded);
    });

    test(
      'when a drop is edited like an offer then drop_not_editable',
      () async {
        final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
        await expectLater(
          endpoints.shopOffers.update(shop, drop.id!, offerInput()),
          throwsTreat('drop_not_editable'),
        );
      },
    );

    test('when an approved post is shared then it shows on the shop page, '
        'the student profile and the feed, with the thank-you note', () async {
      final claim = await approvedClaim(share: true);
      await endpoints.claim.thank(ali, claim.id!, ' Great coffee! ', true);

      final page = await endpoints.social.shopPage(bea, claim.shopId);
      expect(page.studentsTreated, 1);
      expect(page.wall.single.studentName, 'Ali');
      expect(page.wall.single.thanksNote, 'Great coffee!');
      expect(page.wall.single.imageUrl, isNotEmpty);

      final profile = await endpoints.social.student(
        bea,
        page.wall.single.studentId,
      );
      expect(profile.treats, 1);
      expect(profile.wall, hasLength(1));
      expect(profile.toJson().toString(), isNot(contains('@')));

      expect(await endpoints.social.recentPosts(bea), hasLength(1));
    });

    test(
      'when the student did not opt in then the post stays private',
      () async {
        final claim = await approvedClaim(share: false);
        final page = await endpoints.social.shopPage(bea, claim.shopId);
        expect(page.wall, isEmpty);
        expect(page.studentsTreated, 1);
      },
    );

    test('when thanking before approval then not_approved', () async {
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      final claim = (await endpoints.claim.create(ali, offer.id!)).claim;
      await expectLater(
        endpoints.claim.thank(ali, claim.id!, 'hi', true),
        throwsTreat('not_approved'),
      );
    });
  });

  withServerpod(
    'Given students watching live drops',
    (sessionBuilder, endpoints) {
      test('when a shop starts a drop and someone claims then watchers see '
          'the drop and its stock change live', () async {
        OfferEndpoint.dropsRecheck = const Duration(minutes: 5);
        final shop = await signedInAs(sessionBuilder, 'w-owner@drop.com');
        await endpoints.profile.createShop(shop, shopInput());
        final ali = await signedInAs(
          sessionBuilder,
          'w-ali@ogr.anadolu.edu.tr',
        );
        await endpoints.profile.createStudent(ali, 'Ali', 'AU');
        final bea = await signedInAs(
          sessionBuilder,
          'w-bea@ogr.anadolu.edu.tr',
        );
        await endpoints.profile.createStudent(bea, 'Bea', 'AU');

        final updates = endpoints.offer
            .watchDrops(bea)
            .map((cards) => [for (final c in cards) c.claimedTotal])
            .take(3)
            .toList();
        await flushEventQueue();

        final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
        await flushEventQueue();
        await endpoints.claim.create(ali, drop.id!);

        expect(await updates, [
          <int>[],
          [0],
          [1],
        ]);
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
