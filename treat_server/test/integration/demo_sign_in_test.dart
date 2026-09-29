import 'dart:io';

import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/endpoints/demo_endpoint.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/demo.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show FakeVerifier;
import 'test_tools/serverpod_test_tools.dart';

void main() {
  tearDown(() => demoOverride = null);

  withServerpod('Given demo mode is off', (sessionBuilder, endpoints) {
    test('when someone asks for a demo sign-in then demo_off', () async {
      demoOverride = false;
      expect(await endpoints.demo.enabled(sessionBuilder), isFalse);
      await expectLater(
        endpoints.demo.signInAsGuestStudent(sessionBuilder),
        throwsTreat('demo_off'),
      );
      await expectLater(
        endpoints.demo.signInAsDemoShop(sessionBuilder),
        throwsTreat('demo_off'),
      );
    });
  });

  withServerpod('Given demo mode is on', (sessionBuilder, endpoints) {
    setUp(() {
      demoOverride = true;
      // Issuing tokens needs the auth services, which only `run()` sets up.
      // Fixed test-only keys: CI has no passwords.yaml.
      AuthServices.set(
        tokenManagerBuilders: [
          JwtConfig(
            algorithm: JwtAlgorithm.hmacSha512(
              SecretKey('test-only-jwt-signing-key-not-a-secret-0123456789'),
            ),
            refreshTokenHashPepper: 'test-only-refresh-pepper-0123456789',
          ),
        ],
      );
    });

    test('when two judges try as a student then each gets a fresh, verified '
        'guest', () async {
      final a = await endpoints.demo.signInAsGuestStudent(sessionBuilder);
      final b = await endpoints.demo.signInAsGuestStudent(sessionBuilder);
      expect(a.authUserId, isNot(b.authUserId));
      expect(a.token, isNotEmpty);

      final me = await endpoints.profile.getMe(
        sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            a.authUserId.uuid,
            {},
          ),
        ),
      );
      expect(me.role, UserRole.student);
      expect(me.student!.verification, StudentVerification.verified);
      expect(me.student!.university, DemoEndpoint.guestUniversity);
    });

    test('when the demo shop is not seeded then demo_off', () async {
      await expectLater(
        endpoints.demo.signInAsDemoShop(sessionBuilder),
        throwsTreat('demo_off'),
      );
    });

    test('when the demo shop exists then its owner is signed in', () async {
      final owner = await signedInAs(
        sessionBuilder,
        DemoEndpoint.demoShopEmail,
      );
      await endpoints.profile.createShop(owner, shopInput());
      final auth = await endpoints.demo.signInAsDemoShop(sessionBuilder);
      final ownerId = (await AuthUser.db.find(
        sessionBuilder.build(),
      )).single.id;
      expect(auth.authUserId, ownerId);
    });

    group('and a guest with a redeemed claim at a seeded place', () {
      late TestSessionBuilder guest;
      late TestSessionBuilder owner;
      late int claimId;
      late FakeVerifier fake;

      setUp(() async {
        fake = FakeVerifier();
        proofVerifierOverride = fake;
        final auth = await endpoints.demo.signInAsGuestStudent(sessionBuilder);
        guest = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            auth.authUserId.uuid,
            {},
          ),
        );
        owner = await signedInAs(sessionBuilder, 'owner@place.com');
        final shop = (await endpoints.profile.createShop(
          owner,
          shopInput(),
        )).shop!;
        await Shop.db.updateRow(
          sessionBuilder.build(),
          shop.copyWith(seedKey: 'pixel'),
        );
        final offer = await endpoints.shopOffers.create(owner, offerInput());
        final claim = (await endpoints.claim.create(guest, offer.id!)).claim;
        await endpoints.shop.redeem(owner, claim.code);
        claimId = claim.id!;
      });
      tearDown(() => proofVerifierOverride = null);

      test('when the good sample is sent then the place\'s story goes '
          'through the real verification path', () async {
        final view = await endpoints.claim.submitSampleProof(
          guest,
          claimId,
          true,
        );
        expect(view.claim.status, ClaimStatus.proofPending);
        expect(view.claim.proofType, ProofType.igStory);

        fake.answers.add(const ProofVerdict.approved());
        await runProofVerification(sessionBuilder.build(), claimId);
        final pixelStory = await File(
          'seed_assets/proofs/pixel_5.jpg',
        ).readAsBytes();
        expect(fake.seen.single.image, pixelStory);
        final after = await endpoints.claim.get(guest, claimId);
        expect(after.claim.status, ClaimStatus.approved);

        // Someone else's screenshot never goes on the public wall.
        final thanked = await endpoints.claim.thank(guest, claimId, 'Hi', true);
        expect(thanked.claim.shareOnWall, isFalse);
        final page = await endpoints.social.shopPage(guest, after.shop.id!);
        expect(page.wall, isEmpty);
      });

      test('when the bad sample is sent then Claude sees a story that tags '
          'nobody', () async {
        await endpoints.claim.submitSampleProof(guest, claimId, false);
        fake.answers.add(const ProofVerdict.rejected(RejectReason.noMention));
        await runProofVerification(sessionBuilder.build(), claimId);
        final after = await endpoints.claim.get(guest, claimId);
        expect(after.claim.status, ClaimStatus.rejected);
      });

      test('when a real student asks for a sample then demo_off', () async {
        final real = await signedInAs(sessionBuilder, 'r@ogr.anadolu.edu.tr');
        await endpoints.profile.createStudent(real, 'Real', 'AU');
        final offer = await endpoints.shopOffers.create(owner, offerInput());
        final claim = (await endpoints.claim.create(real, offer.id!)).claim;
        await endpoints.shop.redeem(owner, claim.code);
        await expectLater(
          endpoints.claim.submitSampleProof(real, claim.id!, true),
          throwsTreat('demo_off'),
        );
      });
    });
  });
}
