import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/post_links.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show FakeVerifier, jpeg;
import 'test_tools/serverpod_test_tools.dart';

void main() {
  group('validPostUrl', () {
    test('then stories need no link', () {
      expect(validPostUrl(ProofType.igStory, null), isNull);
    });

    test('then permanent posts need one', () {
      expect(
        () => validPostUrl(ProofType.tiktok, ' '),
        throwsTreat('post_link_required'),
      );
    });

    test('then share links are accepted and tracking is dropped', () {
      expect(
        validPostUrl(
          ProofType.igPost,
          'https://www.instagram.com/reel/C1a2b3/?igsh=xyz',
        ),
        'https://www.instagram.com/reel/C1a2b3/',
      );
      expect(
        validPostUrl(ProofType.tiktok, 'https://vm.tiktok.com/ZMabc123/'),
        'https://vm.tiktok.com/ZMabc123/',
      );
    });

    test('then other sites, profiles and plain http are rejected', () {
      for (final (type, url) in [
        (ProofType.igPost, 'https://www.instagram.com/pixeloyunkafe/'),
        (ProofType.igPost, 'https://evil.example/p/abc'),
        (ProofType.tiktok, 'http://www.tiktok.com/@a/video/1'),
        (ProofType.tiktok, 'https://www.instagram.com/p/abc'),
      ]) {
        expect(
          () => validPostUrl(type, url),
          throwsTreat('invalid_post_link'),
          reason: url,
        );
      }
    });
  });

  late DateTime now;
  late FakeVerifier fake;
  setUp(() {
    now = DateTime.now().toUtc();
    clock = () => now;
    fake = FakeVerifier();
    proofVerifierOverride = fake;
  });
  tearDown(() {
    proofVerifierOverride = null;
    postStillUpOverride = null;
  });

  withServerpod('Given an approved TikTok', (sessionBuilder, endpoints) {
    late TestSessionBuilder owner;
    late TestSessionBuilder ali;
    late Claim claim;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'owner@place.com');
      await endpoints.profile.createShop(owner, shopInput());
      ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali', 'AU');
      final offer = await endpoints.shopOffers.create(
        owner,
        offerInput().copyWith(proofTypes: [ProofType.tiktok]),
      );
      claim = (await endpoints.claim.create(ali, offer.id!)).claim;
      await endpoints.shop.redeem(owner, claim.code);
      final up = await endpoints.claim.proofUpload(ali, claim.id!);
      await sessionBuilder.build().storage.storeFile(
        storageId: proofStorage,
        path: up.path,
        byteData: ByteData.sublistView(jpeg),
      );
      final view = await endpoints.claim.submitProof(
        ali,
        claim.id!,
        ProofType.tiktok,
        up.path,
        postUrl: 'https://www.tiktok.com/@ali/video/123?is_from_webapp=1',
      );
      expect(view.claim.postUrl, 'https://www.tiktok.com/@ali/video/123');
      fake.answers.add(const ProofVerdict.approved());
      await runProofVerification(sessionBuilder.build(), claim.id!);
    });

    Future<Claim> reload() async =>
        (await Claim.db.findById(sessionBuilder.build(), claim.id!))!;

    test('when it is not a week old yet then it is not checked', () async {
      var asked = 0;
      postStillUpOverride = (_) async {
        asked++;
        return false;
      };
      await checkPostsStillUp(sessionBuilder.build());
      expect(asked, 0);
      expect((await reload()).status, ClaimStatus.approved);
    });

    test('when it is still online a week later then it is marked checked '
        'and never asked again', () async {
      now = now.add(stillUpAfter + const Duration(hours: 1));
      var asked = 0;
      postStillUpOverride = (_) async {
        asked++;
        return true;
      };
      await checkPostsStillUp(sessionBuilder.build());
      await checkPostsStillUp(sessionBuilder.build());
      final c = await reload();
      expect(c.status, ClaimStatus.approved);
      expect(c.stillUpCheckedAt, isNotNull);
      expect(asked, 1);
    });

    test(
      'when it was deleted then the treat is taken back with a strike',
      () async {
        now = now.add(stillUpAfter + const Duration(hours: 1));
        postStillUpOverride = (_) async => false;
        expect(await checkPostsStillUp(sessionBuilder.build()), 1);
        final c = await reload();
        expect(c.status, ClaimStatus.rejected);
        expect(c.verdictReason, postRemovedReason);
        expect(c.appealed, isTrue);
        final s = await StudentProfile.db.findById(
          sessionBuilder.build(),
          c.studentId,
        );
        expect(s!.treats, 0);
        expect(s.strikes, 1);
      },
    );

    test('when TikTok cannot be reached then nothing changes and it is '
        'tried again later', () async {
      now = now.add(stillUpAfter + const Duration(hours: 1));
      postStillUpOverride = (_) async => null;
      await checkPostsStillUp(sessionBuilder.build());
      final c = await reload();
      expect(c.status, ClaimStatus.approved);
      expect(c.stillUpCheckedAt, isNull);
    });

    test('when the place reports it within a week then it is taken back '
        '(permanent posts get 7 days, not 48 hours)', () async {
      now = now.add(const Duration(days: 5));
      final view = await endpoints.shop.flagProof(owner, claim.id!);
      expect(view.claim.status, ClaimStatus.rejected);
    });
  });
}
