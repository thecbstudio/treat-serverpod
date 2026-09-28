import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:treat_server/src/ai/proof_verifier.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/proofs.dart';

import 'helpers.dart';
import 'proof_flow_test.dart' show FakeVerifier, jpeg;
import 'test_tools/serverpod_test_tools.dart';

/// Serverpod Cloud's Starter plan runs with future calls disabled. Proof
/// verification must still happen (in-process), and expiry is handled by the
/// rules without a job.
void main() {
  late FakeVerifier fake;
  setUp(() {
    fake = FakeVerifier();
    proofVerifierOverride = fake;
  });

  withServerpod(
    'Given future calls are disabled',
    (sessionBuilder, endpoints) {
      test(
        'when a proof is submitted then it is still verified in-process',
        () async {
          final shop = await signedInAs(sessionBuilder, 'sp-owner@cafe.com');
          await endpoints.profile.createShop(shop, shopInput());
          final student = await signedInAs(
            sessionBuilder,
            'sp@ogr.anadolu.edu.tr',
          );
          await endpoints.profile.createStudent(student, 'Sena', 'AU');
          final offer = await endpoints.shopOffers.create(shop, offerInput());
          final claim = (await endpoints.claim.create(
            student,
            offer.id!,
          )).claim;
          await endpoints.shop.redeem(shop, claim.code);

          final up = await endpoints.claim.proofUpload(student, claim.id!);
          await sessionBuilder.build().storage.storeFile(
            storageId: proofStorage,
            path: up.path,
            byteData: ByteData.sublistView(jpeg),
          );
          fake.answers.add(const ProofVerdict.approved());
          await endpoints.claim.submitProof(
            student,
            claim.id!,
            ProofType.igStory,
            up.path,
          );

          Claim? c;
          for (var i = 0; i < 50; i++) {
            c = await Claim.db.findById(sessionBuilder.build(), claim.id!);
            if (c!.status == ClaimStatus.approved) break;
            await Future<void>.delayed(const Duration(milliseconds: 100));
          }
          expect(c!.status, ClaimStatus.approved);
          expect(fake.seen, hasLength(1));
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
    configOverride: (config) =>
        config.copyWith(futureCallExecutionEnabled: false),
  );
}
