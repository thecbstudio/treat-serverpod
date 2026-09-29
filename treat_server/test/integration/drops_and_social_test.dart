import 'dart:async';
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

    test('when a drop has ended then the panel no longer counts it as an '
        'active offer', () async {
      await endpoints.shopOffers.create(shop, offerInput());
      final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
      expect((await endpoints.shop.dashboard(shop)).activeOffers, 2);
      now = drop.endsAt!;
      expect((await endpoints.shop.dashboard(shop)).activeOffers, 1);
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

    test('when the place reports an approved post as removed then the treat '
        'is taken back, a strike is given and there is no appeal', () async {
      final claim = await approvedClaim(share: true);
      final view = await endpoints.shop.flagProof(shop, claim.id!);
      expect(view.claim.status, ClaimStatus.rejected);
      expect(view.claim.verdictReason, flaggedReason);
      expect(view.claim.appealed, isTrue);

      final s = sessionBuilder.build();
      final student = await StudentProfile.db.findById(s, claim.studentId);
      expect(student!.treats, 0);
      expect(student.strikes, 1);
      expect(
        (await Shop.db.findById(s, claim.shopId))!.approvedProofs,
        0,
      );
      expect(
        (await endpoints.social.shopPage(bea, claim.shopId)).wall,
        isEmpty,
      );
      await expectLater(
        endpoints.shop.flagProof(shop, claim.id!),
        throwsTreat('not_approved'),
      );
      await expectLater(
        endpoints.claim.proofUpload(ali, claim.id!),
        throwsTreat('proof_not_allowed'),
      );
    });

    test('when more than 48 hours passed then the post can no longer be '
        'reported', () async {
      final claim = await approvedClaim(share: false);
      now = now.add(flagWindow + const Duration(hours: 1));
      await expectLater(
        endpoints.shop.flagProof(shop, claim.id!),
        throwsTreat('flag_window_over'),
      );
    });

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

        // Wait for each update before the next action, so a slow initial
        // DB read under load can't reorder or merge the snapshots.
        final seen = <List<int>>[];
        Completer<void>? waiting;
        final sub = endpoints.offer.watchDrops(bea).listen((cards) {
          seen.add([for (final c in cards) c.claimedTotal]);
          waiting?.complete();
          waiting = null;
        });
        Future<void> nextUpdate(int count) async {
          if (seen.length >= count) return;
          await (waiting = Completer<void>()).future.timeout(
            const Duration(seconds: 10),
          );
        }

        await nextUpdate(1);
        final drop = await endpoints.shopOffers.startDrop(shop, dropInput());
        await nextUpdate(2);
        await endpoints.claim.create(ali, drop.id!);
        await nextUpdate(3);
        await sub.cancel();

        expect(seen, [
          <int>[],
          [0],
          [1],
        ]);
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
