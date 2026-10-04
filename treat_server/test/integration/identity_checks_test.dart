import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:treat_server/src/ai/document_verifier.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/demo.dart';
import 'package:treat_server/src/services/identity_checks.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show jpeg;
import 'test_tools/serverpod_test_tools.dart';

class FakeDocumentVerifier implements DocumentVerifier {
  final answers = <Object>[];
  final seen = <DocumentContext>[];

  @override
  Future<DocumentVerdict> verify(DocumentContext context) async {
    seen.add(context);
    final next = answers.removeAt(0);
    if (next is Exception) throw next;
    return next as DocumentVerdict;
  }
}

void main() {
  late FakeDocumentVerifier fake;
  setUp(() {
    clock = () => DateTime.now().toUtc();
    fake = FakeDocumentVerifier();
    documentVerifierOverride = fake;
  });
  tearDown(() => documentVerifierOverride = null);

  test('the verdict parser only accepts the reasons of its kind', () {
    String body(Object? reason) =>
        '{"content":[{"type":"tool_use","input":{"approved":false,'
        '"reason":${reason == null ? 'null' : '"$reason"'}}}]}';
    expect(
      parseDocumentResponse(
        body('expired'),
        VerificationKind.studentCard,
      ).reason,
      'expired',
    );
    expect(
      parseDocumentResponse(
        body('expired'),
        VerificationKind.businessDocument,
      ).reason,
      'unreadable',
    );
    expect(
      parseDocumentResponse(
        '{"content":[{"type":"tool_use","input":{"approved":true}}]}',
        VerificationKind.businessDocument,
      ).approved,
      isTrue,
    );
  });

  withServerpod('Given a student without a .edu e-mail', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder ali;

    setUp(() async {
      ali = await signedInAs(sessionBuilder, 'ali@gmail.com');
      final me = await endpoints.profile.createStudent(
        ali,
        'Ali Yılmaz',
        'Anadolu University',
      );
      expect(me.student!.verification, StudentVerification.pending);
    });

    Future<IdentityCheck> send(
      TestSessionBuilder who, [
      List<int>? bytes,
    ]) async {
      final up = await endpoints.verification.upload(who);
      await sessionBuilder.build().storage.storeFile(
        storageId: proofStorage,
        path: up.path,
        byteData: ByteData.sublistView(Uint8List.fromList(bytes ?? jpeg)),
      );
      return endpoints.verification.submit(who, up.path);
    }

    Future<bool> photoExists(int checkId) async {
      final s = sessionBuilder.build();
      final c = await IdentityCheck.db.findById(s, checkId);
      return c!.imagePath != null &&
          await s.storage.fileExists(
            storageId: proofStorage,
            path: c.imagePath!,
          );
    }

    test('when the AI approves the card then the student is verified, can '
        'claim, and the photo is gone', () async {
      final check = await send(ali);
      expect(check.status, CheckStatus.pending);
      expect(await photoExists(check.id!), isTrue);

      fake.answers.add(const DocumentVerdict.approved());
      await runIdentityCheck(sessionBuilder.build(), check.id!);

      expect(fake.seen.single.name, 'Ali Yılmaz');
      expect(fake.seen.single.detail, 'Anadolu University');
      expect(fake.seen.single.kind, VerificationKind.studentCard);
      final latest = (await endpoints.verification.latest(ali))!;
      expect(latest.status, CheckStatus.approved);
      expect(
        (await endpoints.profile.getMe(ali)).student!.verification,
        StudentVerification.verified,
      );
      final stored = await IdentityCheck.db.findById(
        sessionBuilder.build(),
        check.id!,
      );
      expect(stored!.imagePath, isNull);

      final owner = await signedInAs(sessionBuilder, 'owner@place.com');
      await endpoints.profile.createShop(owner, shopInput());
      final offer = await endpoints.shopOffers.create(owner, offerInput());
      final claim = await endpoints.claim.create(ali, offer.id!);
      expect(claim.claim.status, ClaimStatus.active);
    });

    test('when the AI rejects the card then the reason is shown, the photo '
        'is gone and the student can try again', () async {
      final check = await send(ali);
      fake.answers.add(const DocumentVerdict.rejected('name_mismatch'));
      await runIdentityCheck(sessionBuilder.build(), check.id!);

      final latest = (await endpoints.verification.latest(ali))!;
      expect(latest.status, CheckStatus.rejected);
      expect(latest.reason, 'name_mismatch');
      expect(
        (await endpoints.profile.getMe(ali)).student!.verification,
        StudentVerification.rejected,
      );
      expect(await photoExists(check.id!), isFalse);

      final again = await send(ali);
      expect(again.status, CheckStatus.pending);
    });

    test(
      'when a check is pending then a second one is check_pending',
      () async {
        await send(ali);
        await expectLater(send(ali), throwsTreat('check_pending'));
      },
    );

    test('when three checks were sent today then too_many_checks', () async {
      for (var i = 0; i < maxChecksPerDay; i++) {
        final c = await send(ali);
        fake.answers.add(const DocumentVerdict.rejected('unreadable'));
        await runIdentityCheck(sessionBuilder.build(), c.id!);
      }
      await expectLater(send(ali), throwsTreat('too_many_checks'));
    });

    test('when the upload is not an image or has a foreign path then '
        'invalid_proof', () async {
      await expectLater(send(ali, [1, 2, 3, 4]), throwsTreat('invalid_proof'));
      await expectLater(
        endpoints.verification.submit(ali, 'verifications/other/1.img'),
        throwsTreat('invalid_proof'),
      );
    });

    test('when the AI keeps failing then the check ends as failed, without '
        'a verdict, and the photo is gone', () async {
      final check = await send(ali);
      for (var i = 0; i < 3; i++) {
        fake.answers.add(VerifierUnavailable('down'));
        await runIdentityCheck(sessionBuilder.build(), check.id!);
      }
      final latest = (await endpoints.verification.latest(ali))!;
      expect(latest.status, CheckStatus.failed);
      expect(latest.reason, verifyFailedReason);
      expect(latest.attempts, 3);
      expect(await photoExists(check.id!), isFalse);
      expect(
        (await endpoints.profile.getMe(ali)).student!.verification,
        StudentVerification.pending,
      );
    });

    test('when the student deletes the account with a pending check then '
        'the check and photo are gone', () async {
      final check = await send(ali);
      final path = (await IdentityCheck.db.findById(
        sessionBuilder.build(),
        check.id!,
      ))!.imagePath!;
      await endpoints.profile.deleteAccount(ali);
      final s = sessionBuilder.build();
      expect(await IdentityCheck.db.count(s), 0);
      expect(
        await s.storage.fileExists(storageId: proofStorage, path: path),
        isFalse,
      );
    });

    test(
      'when a .edu student asks for a check then already_verified',
      () async {
        final bea = await signedInAs(sessionBuilder, 'bea@ogr.anadolu.edu.tr');
        await endpoints.profile.createStudent(bea, 'Bea', 'AU');
        await expectLater(
          endpoints.verification.upload(bea),
          throwsTreat('already_verified'),
        );
      },
    );
  });

  withServerpod('Given a new business', (sessionBuilder, endpoints) {
    late TestSessionBuilder owner;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'owner@place.com');
      await endpoints.profile.createShop(owner, shopInput());
    });

    test('when the AI approves the document then the place gets the badge; '
        'renaming the place removes it', () async {
      final up = await endpoints.verification.upload(owner);
      await sessionBuilder.build().storage.storeFile(
        storageId: proofStorage,
        path: up.path,
        byteData: ByteData.sublistView(jpeg),
      );
      final check = await endpoints.verification.submit(owner, up.path);
      expect(check.kind, VerificationKind.businessDocument);

      fake.answers.add(const DocumentVerdict.approved());
      await runIdentityCheck(sessionBuilder.build(), check.id!);
      expect(fake.seen.single.name, 'Test Café');
      expect(fake.seen.single.detail, 'Street 1, Odunpazarı');
      expect((await endpoints.profile.getMe(owner)).shop!.verified, isTrue);

      // Saving the profile unchanged keeps it.
      var shop = await endpoints.profile.updateShop(owner, shopInput());
      expect(shop.verified, isTrue);
      shop = await endpoints.profile.updateShop(
        owner,
        shopInput(name: 'New Name'),
      );
      expect(shop.verified, isFalse);
    });

    test(
      'when the AI rejects the document then the place stays unverified',
      () async {
        final up = await endpoints.verification.upload(owner);
        await sessionBuilder.build().storage.storeFile(
          storageId: proofStorage,
          path: up.path,
          byteData: ByteData.sublistView(jpeg),
        );
        final check = await endpoints.verification.submit(owner, up.path);
        fake.answers.add(
          const DocumentVerdict.rejected('not_a_business_document'),
        );
        await runIdentityCheck(sessionBuilder.build(), check.id!);
        expect((await endpoints.profile.getMe(owner)).shop!.verified, isFalse);
        expect(
          (await endpoints.verification.latest(owner))!.reason,
          'not_a_business_document',
        );
      },
    );
  });

  withServerpod('Given demo mode', (sessionBuilder, endpoints) {
    setUp(() => demoOverride = true);
    tearDown(() => demoOverride = null);

    test(
      'when an unverified demo guest sends the sample card then the real '
      'check runs on it (here: a fake AI) and the photo is deleted',
      () async {
        final guest = await signedInAs(sessionBuilder, 'guest-1@demo.treat');
        await endpoints.profile.createStudent(
          guest,
          unverifiedGuestName,
          guestUniversity,
        );
        final check = await endpoints.verification.submitSample(
          guest,
          SampleCard.matching,
        );
        fake.answers.add(const DocumentVerdict.approved());
        await runIdentityCheck(sessionBuilder.build(), check.id!);
        expect(fake.seen.single.name, unverifiedGuestName);
        expect(fake.seen.single.detail, guestUniversity);
        expect(fake.seen.single.image.length, greaterThan(1000));
        expect(
          (await endpoints.profile.getMe(guest)).student!.verification,
          StudentVerification.verified,
        );
      },
    );

    test('when a real student asks for a sample then demo_only', () async {
      final real = await signedInAs(sessionBuilder, 'real@gmail.com');
      await endpoints.profile.createStudent(real, 'Real', 'AU');
      await expectLater(
        endpoints.verification.submitSample(real, SampleCard.matching),
        throwsTreat('demo_only'),
      );
    });

    test('when demo mode is off then demo_off', () async {
      demoOverride = false;
      final guest = await signedInAs(sessionBuilder, 'guest-2@demo.treat');
      await endpoints.profile.createStudent(guest, 'G', guestUniversity);
      await expectLater(
        endpoints.verification.submitSample(guest, SampleCard.matching),
        throwsTreat('demo_off'),
      );
    });
  });
}
