import 'package:serverpod/protocol.dart' show FutureCallEntry;
import 'package:test/test.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/domain/rules.dart';
import 'package:treat_server/src/endpoints/claim_endpoint.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/services/claims.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  // Istanbul 12:00 on a Monday.
  final noon = DateTime.utc(2026, 7, 20, 12).subtract(istanbulOffset);
  late DateTime now;
  setUp(() {
    now = noon;
    clock = () => now;
  });

  test('Given scan input then QR payloads and typed codes are parsed', () {
    expect(parseScan('treat:12:abc234'), (claimId: 12, code: 'ABC234'));
    expect(parseScan(' abc-234 '), (claimId: null, code: 'ABC234'));
    expect(() => parseScan('hello'), throwsTreat('not_found'));
  });

  withServerpod('Given a shop, an offer and a verified student', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder shop;
    late TestSessionBuilder otherShop;
    late TestSessionBuilder student;
    late Offer offer;

    setUp(() async {
      shop = await signedInAs(sessionBuilder, 'owner@cafe.com');
      await endpoints.profile.createShop(shop, shopInput());
      otherShop = await signedInAs(sessionBuilder, 'owner@other.com');
      await endpoints.profile.createShop(otherShop, shopInput(name: 'Other'));
      student = await signedInAs(sessionBuilder, 's@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(student, 'Selin', 'AU');
      offer = await endpoints.shopOffers.create(shop, offerInput(dailyCap: 5));
    });

    test('when the student claims then an active claim with a 2h TTL, a '
        'unique code and a scheduled expiry exist', () async {
      final view = await endpoints.claim.create(student, offer.id!);
      final claim = view.claim;
      expect(claim.status, ClaimStatus.active);
      expect(claim.code, matches(RegExp('^[$claimCodeAlphabet]{6}\$')));
      expect(claim.expiresAt, noon.add(claimTtl));
      expect(view.shop.name, 'Test Café');

      final scheduled = await FutureCallEntry.db.find(
        sessionBuilder.build(),
        where: (t) => t.identifier.equals(expireCallId(claim.id!)),
      );
      expect(scheduled, hasLength(1));
    });

    test(
      'when claiming the same offer twice then ineligible activeClaim',
      () async {
        await endpoints.claim.create(student, offer.id!);
        await expectLater(
          endpoints.claim.create(student, offer.id!),
          throwsA(
            isA<TreatException>()
                .having((e) => e.code, 'code', 'ineligible')
                .having((e) => e.message, 'reason', 'activeClaim'),
          ),
        );
      },
    );

    test('when a shop tries to claim then not_a_student', () async {
      await expectLater(
        endpoints.claim.create(shop, offer.id!),
        throwsTreat('not_a_student'),
      );
    });

    test('when the shop scans the QR then redeemed and counted once, and a '
        'second scan reports alreadyRedeemed', () async {
      final claim = (await endpoints.claim.create(student, offer.id!)).claim;

      final first = await endpoints.shop.redeem(shop, qrPayloadOf(claim));
      expect(first.alreadyRedeemed, isFalse);
      expect(first.view.claim.status, ClaimStatus.redeemed);
      expect(first.view.claim.studentName, 'Selin');

      final second = await endpoints.shop.redeem(shop, claim.code);
      expect(second.alreadyRedeemed, isTrue);

      final me = await endpoints.profile.getMe(shop);
      expect(me.shop!.totalRedeems, 1);

      final scheduled = await FutureCallEntry.db.find(
        sessionBuilder.build(),
        where: (t) => t.identifier.equals(expireCallId(claim.id!)),
      );
      expect(scheduled, isEmpty, reason: 'expiry cancelled after redeem');
    });

    test('when another shop scans the code then wrong_shop', () async {
      final claim = (await endpoints.claim.create(student, offer.id!)).claim;
      await expectLater(
        endpoints.shop.redeem(otherShop, claim.code),
        throwsTreat('wrong_shop'),
      );
      await expectLater(
        endpoints.shop.redeem(otherShop, qrPayloadOf(claim)),
        throwsTreat('wrong_shop'),
      );
    });

    test('when the code is unknown then not_found', () async {
      await expectLater(
        endpoints.shop.redeem(shop, 'ZZZZ22'),
        throwsTreat('not_found'),
      );
    });

    test(
      'when scanned after the TTL then expired, and the slot is free again',
      () async {
        final claim = (await endpoints.claim.create(student, offer.id!)).claim;
        now = noon.add(claimTtl + const Duration(minutes: 1));

        await expectLater(
          endpoints.shop.redeem(shop, claim.code),
          throwsTreat('expired'),
        );
        final stored = await Claim.db.findById(
          sessionBuilder.build(),
          claim.id!,
        );
        expect(stored!.status, ClaimStatus.expired);

        final card = await endpoints.offer.get(student, offer.id!);
        expect(card.claimedToday, 0);
        expect(card.eligibility!.reason, EligibilityReason.ok);
      },
    );

    test('when the ExpireClaim call runs after the TTL then the claim expires; '
        'before the TTL it stays active', () async {
      final claim = (await endpoints.claim.create(student, offer.id!)).claim;
      final session = sessionBuilder.build();

      await expireClaimIfDue(session, claim.id!);
      expect(
        (await Claim.db.findById(session, claim.id!))!.status,
        ClaimStatus.active,
      );

      now = claim.expiresAt;
      await expireClaimIfDue(session, claim.id!);
      expect(
        (await Claim.db.findById(session, claim.id!))!.status,
        ClaimStatus.expired,
      );
    });

    test(
      'when the student lists claims then newest first with offer + shop',
      () async {
        await endpoints.claim.create(student, offer.id!);
        final list = await endpoints.claim.listMine(student);
        expect(list.single.offer.title, 'Filter coffee');
        expect(list.single.shop.name, 'Test Café');
      },
    );

    test('when someone else opens the claim then claim_not_found', () async {
      final claim = (await endpoints.claim.create(student, offer.id!)).claim;
      final intruder = await signedInAs(sessionBuilder, 'x@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(intruder, 'X', 'AU');
      await expectLater(
        endpoints.claim.get(intruder, claim.id!),
        throwsTreat('claim_not_found'),
      );
    });
  });

  withServerpod(
    'Given a claim being watched',
    (sessionBuilder, endpoints) {
      test(
        'when the shop redeems it then the watcher gets the update live',
        () async {
          ClaimEndpoint.watchRecheck = const Duration(minutes: 1);
          final shop = await signedInAs(sessionBuilder, 'w-owner@cafe.com');
          await endpoints.profile.createShop(shop, shopInput());
          final student = await signedInAs(
            sessionBuilder,
            'w@ogr.anadolu.edu.tr',
          );
          await endpoints.profile.createStudent(student, 'Wren', 'AU');
          final offer = await endpoints.shopOffers.create(shop, offerInput());
          final claim = (await endpoints.claim.create(
            student,
            offer.id!,
          )).claim;

          final statuses = endpoints.claim
              .watch(student, claim.id!)
              .map((v) => v.claim.status)
              .take(2)
              .toList();
          await flushEventQueue();

          await endpoints.shop.redeem(shop, claim.code);
          expect(await statuses, [ClaimStatus.active, ClaimStatus.redeemed]);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
