import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/domain/rules.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/claims.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Answers from a queue; an exception entry simulates an API failure.
class FakeVerifier implements ProofVerifier {
  final answers = <Object>[];
  final seen = <ProofContext>[];

  @override
  Future<ProofVerdict> verify(ProofContext context) async {
    seen.add(context);
    final next = answers.removeAt(0);
    if (next is Exception) throw next;
    return next as ProofVerdict;
  }
}

/// A tiny valid JPEG header is enough for the magic-byte check.
final jpeg = Uint8List.fromList([0xFF, 0xD8, 0xFF, 0xE0, 0, 16, 0x4A, 0x46]);

void main() {
  final noon = DateTime.utc(2026, 7, 20, 12).subtract(istanbulOffset);
  late FakeVerifier fake;
  setUp(() {
    clock = () => noon;
    fake = FakeVerifier();
    proofVerifierOverride = fake;
  });

  group('parseResponse', () {
    test('then reads the forced tool call', () {
      const approved =
          '{"content":[{"type":"tool_use","name":"report_verdict",'
          '"input":{"approved":true,"reason":null}}]}';
      const rejected =
          '{"content":[{"type":"tool_use","name":"report_verdict",'
          '"input":{"approved":false,"reason":"no_mention"}}]}';
      expect(parseResponse(approved).approved, isTrue);
      expect(parseResponse(rejected).reason, RejectReason.noMention);
      expect(
        () => parseResponse('{"content":[]}'),
        throwsA(isA<VerifierUnavailable>()),
      );
    });

    test('then the prompt names the shop, handle and proof kind', () {
      final prompt = buildPrompt(
        ProofContext(
          image: jpeg,
          mediaType: 'image/jpeg',
          proofType: ProofType.googleReview,
          shopName: 'Kırlangıç Kahve',
          instagramHandle: 'kirlangickahve',
          offerTitle: 'Filter coffee',
        ),
      );
      expect(prompt, contains('Kırlangıç Kahve'));
      expect(prompt, contains('@kirlangickahve'));
      expect(prompt, contains('Google review'));
      // A review must not be an ad at all, so no disclosure is asked for.
      expect(prompt, isNot(contains('no_disclosure')));
    });

    test('then social posts must disclose the gift', () {
      final prompt = buildPrompt(
        ProofContext(
          image: jpeg,
          mediaType: 'image/jpeg',
          proofType: ProofType.igStory,
          shopName: 'Pixel',
          instagramHandle: 'pixel',
          offerTitle: 'Console hour',
        ),
      );
      expect(prompt, contains('#işbirliği'));
      expect(prompt, contains('no_disclosure'));
      const noDisclosure =
          '{"content":[{"type":"tool_use","name":"report_verdict",'
          '"input":{"approved":false,"reason":"no_disclosure"}}]}';
      expect(parseResponse(noDisclosure).reason, RejectReason.noDisclosure);
    });
  });

  withServerpod('Given a redeemed claim', (sessionBuilder, endpoints) {
    late TestSessionBuilder shop;
    late TestSessionBuilder student;
    late Claim claim;

    Future<String> upload() async {
      final up = await endpoints.claim.proofUpload(student, claim.id!);
      await sessionBuilder.build().storage.storeFile(
        storageId: proofStorage,
        path: up.path,
        byteData: ByteData.sublistView(jpeg),
      );
      return up.path;
    }

    Future<Claim> reload() async =>
        (await Claim.db.findById(sessionBuilder.build(), claim.id!))!;

    Future<StudentProfile> me() async =>
        (await endpoints.profile.getMe(student)).student!;

    setUp(() async {
      shop = await signedInAs(sessionBuilder, 'owner@cafe.com');
      await endpoints.profile.createShop(shop, shopInput());
      student = await signedInAs(sessionBuilder, 's@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(student, 'Selin', 'AU');
      final offer = await endpoints.shopOffers.create(shop, offerInput());
      claim = (await endpoints.claim.create(student, offer.id!)).claim;
      await endpoints.shop.redeem(shop, claim.code);
    });

    test('when an approved proof is verified then +1 treat, category, shop '
        'counter, and badge', () async {
      final path = await upload();
      final view = await endpoints.claim.submitProof(
        student,
        claim.id!,
        ProofType.igStory,
        path,
      );
      expect(view.claim.status, ClaimStatus.proofPending);

      fake.answers.add(const ProofVerdict.approved());
      await runProofVerification(sessionBuilder.build(), claim.id!);

      expect((await reload()).status, ClaimStatus.approved);
      final s = await me();
      expect(s.treats, 1);
      expect(s.categoriesTried, [OfferCategory.coffee]);
      expect(fake.seen.single.shopName, 'Test Café');
      expect(fake.seen.single.instagramHandle, 'testcafe');
      final dash = await endpoints.shop.dashboard(shop);
      expect(dash.shop.approvedProofs, 1);
      expect(dash.estimatedReach, avgViewsPerApprovedPost);
      expect(dash.topStudents.single.name, 'Selin');
      expect(
        (await endpoints.profile.getMe(student)).badges,
        contains(BadgeId.firstTreat),
      );
    });

    test('when the proof type is not accepted by the offer then rejected '
        'up front', () async {
      final path = await upload();
      await expectLater(
        endpoints.claim.submitProof(student, claim.id!, ProofType.tiktok, path),
        throwsTreat('proof_type_not_accepted'),
      );
    });

    test('when the path belongs to another claim then invalid_proof', () async {
      await expectLater(
        endpoints.claim.submitProof(
          student,
          claim.id!,
          ProofType.igStory,
          'proofs/999/x.img',
        ),
        throwsTreat('invalid_proof'),
      );
    });

    test('when rejected then one strike; a lost appeal adds none; a won '
        'appeal gives it back', () async {
      await endpoints.claim.submitProof(
        student,
        claim.id!,
        ProofType.igStory,
        await upload(),
      );
      fake.answers.add(const ProofVerdict.rejected(RejectReason.noMention));
      await runProofVerification(sessionBuilder.build(), claim.id!);
      var c = await reload();
      expect(c.status, ClaimStatus.rejected);
      expect(c.verdictReason, 'no_mention');
      expect((await me()).strikes, 1);

      // Appeal (the one allowed) and win it.
      await endpoints.claim.submitProof(
        student,
        claim.id!,
        ProofType.igStory,
        await upload(),
      );
      expect((await reload()).appealed, isTrue);
      fake.answers.add(const ProofVerdict.approved());
      await runProofVerification(sessionBuilder.build(), claim.id!);
      c = await reload();
      expect(c.status, ClaimStatus.approved);
      expect((await me()).strikes, 0);
      expect((await me()).treats, 1);
    });

    test(
      'when the appeal is lost then still one strike and no more appeals',
      () async {
        await endpoints.claim.submitProof(
          student,
          claim.id!,
          ProofType.igStory,
          await upload(),
        );
        fake.answers.add(const ProofVerdict.rejected(RejectReason.notAPost));
        await runProofVerification(sessionBuilder.build(), claim.id!);
        await endpoints.claim.submitProof(
          student,
          claim.id!,
          ProofType.igStory,
          await upload(),
        );
        fake.answers.add(const ProofVerdict.rejected(RejectReason.notAPost));
        await runProofVerification(sessionBuilder.build(), claim.id!);

        expect((await reload()).status, ClaimStatus.rejected);
        expect((await me()).strikes, 1);
        await expectLater(
          endpoints.claim.proofUpload(student, claim.id!),
          throwsTreat('proof_not_allowed'),
        );
      },
    );

    test('when the AI keeps failing then 3 attempts, back to redeemed, no '
        'strike', () async {
      await endpoints.claim.submitProof(
        student,
        claim.id!,
        ProofType.igStory,
        await upload(),
      );
      final session = sessionBuilder.build();
      for (var i = 0; i < maxVerifyAttempts; i++) {
        fake.answers.add(VerifierUnavailable('down'));
        await runProofVerification(session, claim.id!);
      }
      final c = await reload();
      expect(c.status, ClaimStatus.redeemed);
      expect(c.verdictReason, verifyFailedReason);
      expect((await me()).strikes, 0);
      // The student can send it again.
      await endpoints.claim.proofUpload(student, claim.id!);
    });

    test('when the student has no redeemed claim then no upload', () async {
      final session = sessionBuilder.build();
      await Claim.db.updateRow(
        session,
        (await reload()).copyWith(status: ClaimStatus.active),
      );
      await expectLater(
        endpoints.claim.proofUpload(student, claim.id!),
        throwsTreat('proof_not_allowed'),
      );
      expect(qrPayloadOf(claim), startsWith('treat:'));
    });

    test(
      'when listing the leaderboard then name + university, no email',
      () async {
        await endpoints.claim.submitProof(
          student,
          claim.id!,
          ProofType.igStory,
          await upload(),
        );
        fake.answers.add(const ProofVerdict.approved());
        await runProofVerification(sessionBuilder.build(), claim.id!);
        final top = await endpoints.leaderboard.top(student);
        expect(top.single.name, 'Selin');
        expect(top.single.isMe, isTrue);
        expect(top.single.toJson().toString(), isNot(contains('@')));
      },
    );
  });
}
