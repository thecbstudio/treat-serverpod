import 'dart:math';

import 'package:serverpod/serverpod.dart' show UuidValue;
import 'package:test/test.dart';
import 'package:treat_server/src/domain/rules.dart';
import 'package:treat_server/src/generated/protocol.dart';

/// Instant at Istanbul wall-clock [hour]:[minute] on Monday 20 July 2026.
DateTime istanbul(int hour, [int minute = 0]) =>
    DateTime.utc(2026, 7, 20, hour, minute).subtract(istanbulOffset);

StudentProfile makeStudent({
  StudentVerification verification = StudentVerification.verified,
  int strikes = 0,
}) => StudentProfile(
  id: 1,
  authUserId: UuidValue.fromString('550e8400-e29b-41d4-a716-446655440000'),
  name: 'Test Student',
  email: 't@ogr.example.edu.tr',
  university: 'Test University',
  verification: verification,
  strikes: strikes,
  categoriesTried: [],
);

Offer makeOffer({
  OfferStatus status = OfferStatus.active,
  OfferFrequency frequency = OfferFrequency.weekly,
  int? dailyCap,
  int? totalCap,
}) => Offer(
  id: 10,
  shopId: 100,
  title: 'Test offer',
  description: 'Description',
  category: OfferCategory.coffee,
  frequency: frequency,
  activeStartMin: 9 * 60,
  activeEndMin: 18 * 60,
  dailyCap: dailyCap,
  totalCap: totalCap,
  status: status,
  proofTypes: [ProofType.igStory],
);

Claim makeClaim({
  int id = 1,
  int offerId = 10,
  ClaimStatus status = ClaimStatus.approved,
  OfferFrequency frequency = OfferFrequency.weekly,
  required DateTime createdAt,
}) => Claim(
  id: id,
  offerId: offerId,
  shopId: 100,
  studentId: 1,
  studentName: 'Test Student',
  frequency: frequency,
  code: 'ABC234',
  status: status,
  createdAt: createdAt,
  expiresAt: createdAt.add(claimTtl),
);

Eligibility check({
  Offer? offer,
  StudentProfile? student,
  List<Claim> claims = const [],
  int claimedToday = 0,
  int claimedTotal = 0,
  required DateTime now,
}) => eligibilityOf(
  offer: offer,
  student: student,
  shopClaims: claims,
  claimedToday: claimedToday,
  claimedTotal: claimedTotal,
  now: now,
);

void main() {
  test('Given the fixture date then it is a Monday in Istanbul', () {
    expect(istanbulWallClock(istanbul(12)).weekday, DateTime.monday);
  });

  group('computeBadges', () {
    test('when no condition holds then returns nothing', () {
      expect(
        computeBadges(
          treats: 0,
          streakWeeks: 0,
          categoriesTried: 0,
          verified: false,
        ),
        isEmpty,
      );
    });

    test('when 10 treats then returns the matching treat badges', () {
      final badges = computeBadges(
        treats: 10,
        streakWeeks: 0,
        categoriesTried: 0,
        verified: false,
      );
      expect(badges, containsAll([BadgeId.firstTreat, BadgeId.tenTreats]));
      expect(badges, isNot(contains(BadgeId.twentyfiveTreats)));
    });

    test('when every condition holds then returns all badges', () {
      expect(
        computeBadges(
          treats: 25,
          streakWeeks: 4,
          categoriesTried: 3,
          verified: true,
        ),
        unorderedEquals(BadgeId.values),
      );
    });
  });

  group('computeStreakWeeks', () {
    final now = istanbul(12);
    const week = Duration(days: 7);

    test('when no approved treats then 0', () {
      expect(computeStreakWeeks([], now), 0);
    });

    test('when one approval this week then 1', () {
      expect(computeStreakWeeks([now], now), 1);
    });

    test('when this week is empty but last week is not then streak holds', () {
      expect(computeStreakWeeks([now.subtract(week)], now), 1);
    });

    test('when three consecutive weeks then 3', () {
      expect(
        computeStreakWeeks([
          now,
          now.subtract(week),
          now.subtract(week * 2),
        ], now),
        3,
      );
    });

    test('when a week in between is empty then the streak stops there', () {
      expect(computeStreakWeeks([now, now.subtract(week * 2)], now), 1);
    });

    test('when the last approval is two weeks old then 0', () {
      expect(computeStreakWeeks([now.subtract(week * 2)], now), 0);
    });

    test(
      'when approved Sunday 23:30 Istanbul then it counts for that week',
      () {
        // Sunday 23:30 Istanbul = Sunday 20:30 UTC, still last week locally.
        final sundayNight = istanbul(12)
            .subtract(const Duration(days: 1))
            .add(const Duration(hours: 11, minutes: 30));
        expect(istanbulWallClock(sundayNight).weekday, DateTime.sunday);
        expect(computeStreakWeeks([sundayNight], now), 1);
        expect(istanbulWeekIndex(sundayNight), istanbulWeekIndex(now) - 1);
      },
    );
  });

  group('newClaimCode', () {
    test('then always 6 characters from the unambiguous alphabet', () {
      final random = Random(42);
      for (var i = 0; i < 500; i++) {
        final code = newClaimCode(random);
        expect(code, hasLength(6));
        expect(code, isNot(matches(RegExp('[01OI]'))));
        expect(code.split('').every(claimCodeAlphabet.contains), isTrue);
      }
    });
  });

  group('isEduEmail', () {
    test('then accepts .edu and .edu.tr, rejects others', () {
      expect(isEduEmail('a@ogr.anadolu.edu.tr'), isTrue);
      expect(isEduEmail('A@MIT.EDU'), isTrue);
      expect(isEduEmail('a@gmail.com'), isFalse);
      expect(isEduEmail('a@edu.example.com'), isFalse);
    });
  });

  group('usageOf', () {
    test('then counts non-expired claims today and in total', () {
      final now = istanbul(12);
      final claims = [
        makeClaim(id: 1, createdAt: istanbul(10)),
        makeClaim(
          id: 2,
          createdAt: istanbul(0, 30),
        ), // today, just after midnight
        makeClaim(
          id: 3,
          createdAt: istanbul(0).subtract(const Duration(minutes: 1)),
        ),
        makeClaim(id: 4, createdAt: istanbul(11), status: ClaimStatus.expired),
        // Still `active` in DB but past its TTL → counts as expired.
        makeClaim(id: 5, createdAt: istanbul(9), status: ClaimStatus.active),
        makeClaim(id: 6, offerId: 99, createdAt: istanbul(11)),
      ];
      expect(usageOf(10, claims, now), (today: 2, total: 3));
    });
  });

  group('eligibilityOf', () {
    final now = istanbul(12);

    test('when the offer is missing or paused then offerInactive', () {
      expect(
        check(student: makeStudent(), now: now).reason,
        EligibilityReason.offerInactive,
      );
      expect(
        check(
          offer: makeOffer(status: OfferStatus.paused),
          student: makeStudent(),
          now: now,
        ).reason,
        EligibilityReason.offerInactive,
      );
    });

    test('when the student is not verified then notVerified', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(verification: StudentVerification.pending),
          now: now,
        ).reason,
        EligibilityReason.notVerified,
      );
    });

    test('when the student has 3 strikes then tooManyStrikes', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(strikes: 3),
          now: now,
        ).reason,
        EligibilityReason.tooManyStrikes,
      );
    });

    test('when an active claim exists for the offer then activeClaim', () {
      final result = check(
        offer: makeOffer(),
        student: makeStudent(),
        claims: [
          makeClaim(id: 7, status: ClaimStatus.active, createdAt: istanbul(11)),
        ],
        now: now,
      );
      expect(result.reason, EligibilityReason.activeClaim);
      expect(result.claimId, 7);
    });

    test('when the active claim is past its TTL then it no longer blocks', () {
      final result = check(
        offer: makeOffer(),
        student: makeStudent(),
        claims: [
          makeClaim(status: ClaimStatus.active, createdAt: istanbul(9)),
        ],
        now: now,
      );
      expect(result.reason, EligibilityReason.ok);
    });

    test('when inside the weekly window then frequency with availableAt', () {
      final claimedAt = now.subtract(const Duration(days: 2));
      final result = check(
        offer: makeOffer(),
        student: makeStudent(),
        claims: [makeClaim(createdAt: claimedAt)],
        now: now,
      );
      expect(result.reason, EligibilityReason.frequency);
      expect(result.availableAt, claimedAt.add(const Duration(days: 7)));
    });

    test('when the weekly window has passed then ok', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(),
          claims: [makeClaim(createdAt: now.subtract(const Duration(days: 8)))],
          now: now,
        ).reason,
        EligibilityReason.ok,
      );
    });

    test('when a monthly claim exists then a weekly offer is not locked', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(),
          claims: [
            makeClaim(
              frequency: OfferFrequency.monthly,
              createdAt: now.subtract(const Duration(days: 2)),
            ),
          ],
          now: now,
        ).reason,
        EligibilityReason.ok,
      );
    });

    test('when the recent claim expired then it does not lock', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(),
          claims: [
            makeClaim(
              status: ClaimStatus.expired,
              createdAt: now.subtract(const Duration(hours: 1)),
            ),
          ],
          now: now,
        ).reason,
        EligibilityReason.ok,
      );
    });

    test('when outside active hours then outsideHours with opensAtMin', () {
      final result = check(
        offer: makeOffer(),
        student: makeStudent(),
        now: istanbul(22),
      );
      expect(result.reason, EligibilityReason.outsideHours);
      expect(result.opensAtMin, 9 * 60);
    });

    test('when exactly at end time then outsideHours', () {
      expect(
        check(
          offer: makeOffer(),
          student: makeStudent(),
          now: istanbul(18),
        ).reason,
        EligibilityReason.outsideHours,
      );
    });

    test('when the total cap is reached then totalCap', () {
      expect(
        check(
          offer: makeOffer(totalCap: 5),
          student: makeStudent(),
          claimedTotal: 5,
          now: now,
        ).reason,
        EligibilityReason.totalCap,
      );
    });

    test('when the daily cap is reached then dailyCap', () {
      expect(
        check(
          offer: makeOffer(dailyCap: 3),
          student: makeStudent(),
          claimedToday: 3,
          now: now,
        ).reason,
        EligibilityReason.dailyCap,
      );
    });

    test('when all conditions hold then ok', () {
      expect(
        check(offer: makeOffer(), student: makeStudent(), now: now).reason,
        EligibilityReason.ok,
      );
    });
  });

  group('validateOfferInput', () {
    OfferInput input({
      int start = 540,
      int end = 1080,
      List<ProofType> proofs = const [ProofType.igStory],
      int? dailyCap,
    }) => OfferInput(
      title: 'Coffee',
      description: 'A coffee',
      frequency: OfferFrequency.weekly,
      activeStartMin: start,
      activeEndMin: end,
      dailyCap: dailyCap,
      proofTypes: proofs,
    );

    test('then accepts a valid input', () {
      expect(validateOfferInput(input()), isNull);
    });

    test('then rejects bad hours, caps and missing proof types', () {
      expect(validateOfferInput(input(start: 600, end: 600)), 'invalid_hours');
      expect(validateOfferInput(input(dailyCap: 0)), 'invalid_cap');
      expect(validateOfferInput(input(proofs: [])), 'proof_types_required');
    });
  });
}
