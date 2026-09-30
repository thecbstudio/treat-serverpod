import 'dart:typed_data';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/demo.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show FakeVerifier, jpeg;
import 'test_tools/serverpod_test_tools.dart';

void main() {
  late FakeVerifier fake;
  setUp(() {
    clock = () => DateTime.now().toUtc();
    fake = FakeVerifier();
    proofVerifierOverride = fake;
  });
  tearDown(() => demoOverride = null);

  withServerpod('Given a place and two students', (sessionBuilder, endpoints) {
    late TestSessionBuilder owner;
    late TestSessionBuilder ali;
    late TestSessionBuilder bea;
    late int shopId;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'owner@place.com');
      shopId = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!.id!;
      ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      bea = await signedInAs(sessionBuilder, 'bea@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(bea, 'Bea', 'AU');
    });

    /// Ali's approved, shared and rated visit, with its screenshot stored.
    Future<Claim> approvedVisit() async {
      final offer = await endpoints.shopOffers.create(owner, offerInput());
      final claim = (await endpoints.claim.create(ali, offer.id!)).claim;
      await endpoints.shop.redeem(owner, claim.code);
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
        shareOnWall: true,
      );
      fake.answers.add(const ProofVerdict.approved());
      await runProofVerification(sessionBuilder.build(), claim.id!);
      await endpoints.claim.rate(ali, claim.id!, 5, review: 'Lovely place');
      return (await Claim.db.findById(sessionBuilder.build(), claim.id!))!;
    }

    group('settings', () {
      test('when a student edits name and university then getMe has the new '
          'values', () async {
        final me = await endpoints.profile.updateStudent(
          ali,
          ' Ali Yılmaz ',
          'Anadolu University',
        );
        expect(me.student!.name, 'Ali Yılmaz');
        expect(me.student!.university, 'Anadolu University');
      });

      test('when the name is empty then invalid_name', () async {
        await expectLater(
          endpoints.profile.updateStudent(ali, '  ', 'AU'),
          throwsTreat('invalid_name'),
        );
      });

      test('when a business calls it then not_a_student', () async {
        await expectLater(
          endpoints.profile.updateStudent(owner, 'X', 'Y'),
          throwsTreat('not_a_student'),
        );
      });
    });

    group('account deletion', () {
      test('when a student deletes the account then the profile, claims, '
          'screenshot and login are gone and the place page no longer shows '
          'them', () async {
        final claim = await approvedVisit();
        final s = sessionBuilder.build();
        final student = (await StudentProfile.db.findById(
          s,
          claim.studentId,
        ))!;

        await endpoints.profile.deleteAccount(ali);

        expect(await StudentProfile.db.findById(s, student.id!), isNull);
        expect(await Claim.db.findById(s, claim.id!), isNull);
        expect(
          await s.storage.fileExists(
            storageId: proofStorage,
            path: claim.proofPath!,
          ),
          isFalse,
        );
        expect(await AuthUser.db.findById(s, student.authUserId), isNull);
        expect(
          await EmailAccount.db.findFirstRow(
            s,
            where: (t) => t.email.equals('ali@ogr.anadolu.edu.tr'),
          ),
          isNull,
        );
        final page = await endpoints.social.shopPage(bea, shopId);
        expect(page.wall, isEmpty);
        expect(page.reviews, isEmpty);
        expect(page.rating.count, 0);
      });

      test(
        'when a business deletes the account then the place, its offers '
        'and the claims there are gone, and students keep their account',
        () async {
          final claim = await approvedVisit();
          final s = sessionBuilder.build();
          final shop = (await Shop.db.findById(s, shopId))!;

          await endpoints.profile.deleteAccount(owner);

          expect(await Shop.db.findById(s, shopId), isNull);
          expect(await Offer.db.findById(s, claim.offerId), isNull);
          expect(await Claim.db.findById(s, claim.id!), isNull);
          expect(await AuthUser.db.findById(s, shop.ownerId!), isNull);
          expect(
            await s.storage.fileExists(
              storageId: proofStorage,
              path: claim.proofPath!,
            ),
            isFalse,
          );
          final me = await endpoints.profile.getMe(ali);
          expect(me.student!.treats, 1);
        },
      );

      test('when a user without a role deletes the account then the login is '
          'gone', () async {
        final nobody = await signedInAs(sessionBuilder, 'new@x.com');
        await endpoints.profile.deleteAccount(nobody);
        expect(
          await EmailAccount.db.findFirstRow(
            sessionBuilder.build(),
            where: (t) => t.email.equals('new@x.com'),
          ),
          isNull,
        );
      });

      test('when the reports a user sent exist then they go with the '
          'account', () async {
        final claim = await approvedVisit();
        await endpoints.social.report(
          bea,
          ReportKind.review,
          claim.id!,
          ReportReason.spam,
        );
        await endpoints.profile.deleteAccount(bea);
        expect(await Report.db.count(sessionBuilder.build()), 0);
      });
    });

    group('reports', () {
      test('when one user reports a review then it stays; when a second one '
          'does then it leaves public pages but its stars still count and the '
          'place still sees it', () async {
        final claim = await approvedVisit();
        await endpoints.social.report(
          bea,
          ReportKind.review,
          claim.id!,
          ReportReason.offensive,
        );
        // Reporting twice counts once.
        await endpoints.social.report(
          bea,
          ReportKind.review,
          claim.id!,
          ReportReason.offensive,
        );
        expect(
          (await endpoints.social.shopPage(bea, shopId)).reviews,
          hasLength(1),
        );

        final cem = await signedInAs(sessionBuilder, 'cem@ogr.anadolu.edu.tr');
        await endpoints.profile.createStudent(cem, 'Cem', 'AU');
        await endpoints.social.report(
          cem,
          ReportKind.review,
          claim.id!,
          ReportReason.fake,
        );

        final page = await endpoints.social.shopPage(bea, shopId);
        expect(page.reviews, isEmpty);
        expect(page.rating.count, 1);
        expect(page.wall, hasLength(1));
        final panel = await endpoints.shop.dashboard(owner);
        expect(panel.reviews.single.review, 'Lovely place');
      });

      test(
        'when two users report a wall post then it leaves the walls',
        () async {
          final claim = await approvedVisit();
          final cem = await signedInAs(
            sessionBuilder,
            'cem@ogr.anadolu.edu.tr',
          );
          await endpoints.profile.createStudent(cem, 'Cem', 'AU');
          for (final u in [bea, cem]) {
            await endpoints.social.report(
              u,
              ReportKind.wallPost,
              claim.id!,
              ReportReason.privacy,
            );
          }
          expect((await endpoints.social.shopPage(bea, shopId)).wall, isEmpty);
          expect(await endpoints.social.recentPosts(bea), isEmpty);
          expect(
            (await endpoints.social.shopPage(bea, shopId)).reviews,
            hasLength(1),
          );
        },
      );

      test('when users report their own review, post or place then '
          'own_content', () async {
        final claim = await approvedVisit();
        await expectLater(
          endpoints.social.report(
            ali,
            ReportKind.review,
            claim.id!,
            ReportReason.spam,
          ),
          throwsTreat('own_content'),
        );
        await expectLater(
          endpoints.social.report(
            owner,
            ReportKind.wallPost,
            claim.id!,
            ReportReason.spam,
          ),
          throwsTreat('own_content'),
        );
        await expectLater(
          endpoints.social.report(
            owner,
            ReportKind.shop,
            shopId,
            ReportReason.spam,
          ),
          throwsTreat('own_content'),
        );
      });

      test('when a claim has no public review then reporting it is '
          'not_found', () async {
        final offer = await endpoints.shopOffers.create(owner, offerInput());
        final claim = (await endpoints.claim.create(ali, offer.id!)).claim;
        await expectLater(
          endpoints.social.report(
            bea,
            ReportKind.review,
            claim.id!,
            ReportReason.spam,
          ),
          throwsTreat('not_found'),
        );
        await expectLater(
          endpoints.social.report(
            bea,
            ReportKind.wallPost,
            claim.id!,
            ReportReason.spam,
          ),
          throwsTreat('not_found'),
        );
      });

      test(
        'when a place is reported then it is recorded but stays up',
        () async {
          final cem = await signedInAs(
            sessionBuilder,
            'cem@ogr.anadolu.edu.tr',
          );
          await endpoints.profile.createStudent(cem, 'Cem', 'AU');
          for (final u in [ali, bea, cem]) {
            await endpoints.social.report(
              u,
              ReportKind.shop,
              shopId,
              ReportReason.fake,
            );
          }
          expect(await Report.db.count(sessionBuilder.build()), 3);
          expect(
            (await endpoints.social.shopPage(ali, shopId)).shop.id,
            shopId,
          );
        },
      );
    });
  });

  withServerpod('Given demo mode', (sessionBuilder, endpoints) {
    setUp(() => demoOverride = true);

    test('when the shared demo student edits or deletes the profile then '
        'demo_locked', () async {
      final jury = await signedInAs(sessionBuilder, 'student@demo.treat');
      await endpoints.profile.createStudent(jury, 'Demo Student', 'AU');
      await expectLater(
        endpoints.profile.updateStudent(jury, 'Renamed', 'AU'),
        throwsTreat('demo_locked'),
      );
      await expectLater(
        endpoints.profile.deleteAccount(jury),
        throwsTreat('demo_locked'),
      );
    });

    test('when a seeded place deletes its account then demo_locked', () async {
      final owner = await signedInAs(sessionBuilder, 'pixel@demo.treat');
      final shop = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!;
      await Shop.db.updateRow(
        sessionBuilder.build(),
        shop.copyWith(seedKey: 'pixel'),
      );
      await expectLater(
        endpoints.profile.deleteAccount(owner),
        throwsTreat('demo_locked'),
      );
    });

    test('when a guest renames then it works, changing the university is '
        'guest_university, and deleting works', () async {
      final guest = await signedInAs(sessionBuilder, 'guest-1@demo.treat');
      await endpoints.profile.createStudent(guest, 'Guest 1', guestUniversity);
      final me = await endpoints.profile.updateStudent(
        guest,
        'Judge',
        guestUniversity,
      );
      expect(me.student!.name, 'Judge');
      await expectLater(
        endpoints.profile.updateStudent(guest, 'Judge', 'Harvard'),
        throwsTreat('guest_university'),
      );
      await endpoints.profile.deleteAccount(guest);
      expect(await StudentProfile.db.count(sessionBuilder.build()), 0);
    });

    test('when two guests report a review then it stays up', () async {
      final owner = await signedInAs(sessionBuilder, 'owner@place.com');
      final shopId = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!.id!;
      final ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      final offer = await endpoints.shopOffers.create(owner, offerInput());
      final claim = (await endpoints.claim.create(ali, offer.id!)).claim;
      await endpoints.shop.redeem(owner, claim.code);
      await endpoints.claim.rate(ali, claim.id!, 4, review: 'Nice');

      for (final n in [1, 2]) {
        final guest = await signedInAs(sessionBuilder, 'guest-$n@demo.treat');
        await endpoints.profile.createStudent(
          guest,
          'Guest $n',
          guestUniversity,
        );
        await endpoints.social.report(
          guest,
          ReportKind.review,
          claim.id!,
          ReportReason.offensive,
        );
      }
      final page = await endpoints.social.shopPage(ali, shopId);
      expect(page.reviews.single.review, 'Nice');
    });
  });
}
