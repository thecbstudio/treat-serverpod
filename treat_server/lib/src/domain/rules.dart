/// TREAT business rules. Pure functions: same input → same output, no DB, no
/// clock reads. Endpoints load the rows and pass `now` in.
library;

import 'dart:math';

import '../generated/protocol.dart';

const claimTtl = Duration(hours: 2);
const maxStrikes = 3;
const claimCodeLength = 6;

/// No 0/O or 1/I — the code is read aloud and typed by shop staff.
const claimCodeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

final eduEmailRe = RegExp(
  r'@(?:[a-z0-9-]+\.)*edu(?:\.[a-z]{2})?$',
  caseSensitive: false,
);

/// Placeholder benchmark: average views of one approved post.
const avgViewsPerApprovedPost = 180;

/// Placeholder benchmark: marketing value (TRY) of one view.
const valuePerViewTl = 0.15;

/// A claimed drop item must be picked up within this time after the drop
/// closes (and never later than [claimTtl] after claiming).
const dropPickupGrace = Duration(minutes: 30);

const dropMinQuantity = 1;
const dropMaxQuantity = 50;
const dropMinMinutes = 10;
const dropMaxMinutes = 180;

/// Europe/Istanbul has been fixed at UTC+3 (no DST) since 2016.
const istanbulOffset = Duration(hours: 3);

Duration frequencyWindow(OfferFrequency f) => switch (f) {
  OfferFrequency.weekly => const Duration(days: 7),
  OfferFrequency.monthly => const Duration(days: 30),
};

bool isEduEmail(String email) => eduEmailRe.hasMatch(email.trim());

/// Wall-clock Istanbul time, stored in a UTC DateTime so its fields read as
/// local fields.
DateTime istanbulWallClock(DateTime instant) =>
    instant.toUtc().add(istanbulOffset);

int istanbulMinuteOfDay(DateTime instant) {
  final w = istanbulWallClock(instant);
  return w.hour * 60 + w.minute;
}

/// UTC instant of the most recent Istanbul midnight.
DateTime istanbulDayStart(DateTime instant) {
  final w = istanbulWallClock(instant);
  return DateTime.utc(w.year, w.month, w.day).subtract(istanbulOffset);
}

/// Monday-based Istanbul week number (weeks since an epoch Monday).
int istanbulWeekIndex(DateTime instant) {
  final w = istanbulWallClock(instant);
  final days = DateTime.utc(w.year, w.month, w.day)
      .difference(DateTime.utc(1970, 1, 5)) // a Monday
      .inDays;
  return (days / 7).floor();
}

String newClaimCode([Random? random]) {
  final r = random ?? Random.secure();
  return List.generate(
    claimCodeLength,
    (_) => claimCodeAlphabet[r.nextInt(claimCodeAlphabet.length)],
  ).join();
}

/// Consecutive Istanbul weeks with at least one approved treat. An empty
/// current week doesn't break the streak — counting starts from last week.
int computeStreakWeeks(Iterable<DateTime> approvedAt, DateTime now) {
  final weeks = approvedAt.map(istanbulWeekIndex).toSet();
  var cursor = istanbulWeekIndex(now);
  if (!weeks.contains(cursor)) cursor -= 1;
  var streak = 0;
  while (weeks.contains(cursor)) {
    streak += 1;
    cursor -= 1;
  }
  return streak;
}

List<BadgeId> computeBadges({
  required int treats,
  required int streakWeeks,
  required int categoriesTried,
  required bool verified,
}) => [
  if (treats >= 1) BadgeId.firstTreat,
  if (treats >= 10) BadgeId.tenTreats,
  if (treats >= 25) BadgeId.twentyfiveTreats,
  if (streakWeeks >= 4) BadgeId.streak4,
  if (categoriesTried >= 3) BadgeId.explorer3,
  if (verified) BadgeId.verifiedStudent,
];

int estimateReach(int approvedProofs) =>
    approvedProofs * avgViewsPerApprovedPost;

int estimateMarketingValueTl(int reach) => (reach * valuePerViewTl).round();

/// A claim still counts as `active` in the DB until the ExpireClaim future
/// call runs; rules treat it as expired as soon as its TTL has passed.
ClaimStatus effectiveStatus(Claim c, DateTime now) =>
    c.status == ClaimStatus.active && !now.isBefore(c.expiresAt)
    ? ClaimStatus.expired
    : c.status;

/// Every claim that isn't expired uses up a slot (rejected included — the
/// product was handed over).
bool consumesSlot(Claim c, DateTime now) =>
    effectiveStatus(c, now) != ClaimStatus.expired;

/// How many slots of [offerId] are used today (Istanbul) and in total.
({int today, int total}) usageOf(
  int offerId,
  Iterable<Claim> offerClaims,
  DateTime now,
) {
  final dayStart = istanbulDayStart(now);
  var today = 0;
  var total = 0;
  for (final c in offerClaims) {
    if (c.offerId != offerId || !consumesSlot(c, now)) continue;
    total += 1;
    if (!c.createdAt.isBefore(dayStart)) today += 1;
  }
  return (today: today, total: total);
}

/// Whether [student] may claim [offer] right now.
///
/// [shopClaims]: all of the student's claims at the offer's shop.
/// [claimedToday] / [claimedTotal]: slot usage of the offer by everyone
/// (see [usageOf]).
Eligibility eligibilityOf({
  required Offer? offer,
  required StudentProfile? student,
  required Iterable<Claim> shopClaims,
  required int claimedToday,
  required int claimedTotal,
  required DateTime now,
}) {
  if (offer == null || offer.status != OfferStatus.active) {
    return Eligibility(reason: EligibilityReason.offerInactive);
  }
  final isDrop = offer.kind == OfferKind.drop;
  if (isDrop && !isDropLive(offer, now)) {
    return Eligibility(reason: EligibilityReason.dropEnded);
  }
  if (student == null || student.verification != StudentVerification.verified) {
    return Eligibility(reason: EligibilityReason.notVerified);
  }
  if (student.strikes >= maxStrikes) {
    return Eligibility(reason: EligibilityReason.tooManyStrikes);
  }

  for (final c in shopClaims) {
    if (c.offerId == offer.id &&
        effectiveStatus(c, now) == ClaimStatus.active) {
      return Eligibility(reason: EligibilityReason.activeClaim, claimId: c.id);
    }
  }

  if (isDrop) {
    // One item per student per drop; no weekly limit, no opening hours.
    if (shopClaims.any((c) => c.offerId == offer.id && consumesSlot(c, now))) {
      return Eligibility(reason: EligibilityReason.alreadyClaimed);
    }
    final stock = offer.totalCap;
    if (stock != null && claimedTotal >= stock) {
      return Eligibility(reason: EligibilityReason.totalCap);
    }
    return Eligibility(reason: EligibilityReason.ok);
  }

  DateTime? latest;
  for (final c in shopClaims) {
    if (c.fromDrop || c.frequency != offer.frequency || !consumesSlot(c, now)) {
      continue;
    }
    if (latest == null || c.createdAt.isAfter(latest)) latest = c.createdAt;
  }
  if (latest != null) {
    final availableAt = latest.add(frequencyWindow(offer.frequency));
    if (availableAt.isAfter(now)) {
      return Eligibility(
        reason: EligibilityReason.frequency,
        availableAt: availableAt,
      );
    }
  }

  final minute = istanbulMinuteOfDay(now);
  if (minute < offer.activeStartMin || minute >= offer.activeEndMin) {
    return Eligibility(
      reason: EligibilityReason.outsideHours,
      opensAtMin: offer.activeStartMin,
    );
  }

  final totalCap = offer.totalCap;
  if (totalCap != null && claimedTotal >= totalCap) {
    return Eligibility(reason: EligibilityReason.totalCap);
  }
  final dailyCap = offer.dailyCap;
  if (dailyCap != null && claimedToday >= dailyCap) {
    return Eligibility(reason: EligibilityReason.dailyCap);
  }

  return Eligibility(reason: EligibilityReason.ok);
}

bool isDropLive(Offer o, DateTime now) =>
    o.kind == OfferKind.drop &&
    o.status == OfferStatus.active &&
    o.endsAt != null &&
    now.isBefore(o.endsAt!);

/// When a new claim on [offer] made at [now] expires.
DateTime claimExpiry(Offer offer, DateTime now) {
  final regular = now.add(claimTtl);
  if (offer.kind != OfferKind.drop || offer.endsAt == null) return regular;
  final pickupBy = offer.endsAt!.add(dropPickupGrace);
  return pickupBy.isBefore(regular) ? pickupBy : regular;
}

/// Validates a shop's drop form. Returns a [TreatException] code or null.
String? validateDropInput(DropInput input) {
  if (input.title.trim().isEmpty || input.title.length > 80) {
    return 'invalid_title';
  }
  if (input.description.length > 500) return 'invalid_description';
  if (input.quantity < dropMinQuantity || input.quantity > dropMaxQuantity) {
    return 'invalid_quantity';
  }
  if (input.durationMinutes < dropMinMinutes ||
      input.durationMinutes > dropMaxMinutes) {
    return 'invalid_duration';
  }
  if (input.proofTypes.isEmpty) return 'proof_types_required';
  if (!input.proofTypes.every(offerableProofTypes.contains)) {
    return 'proof_type_not_offered';
  }
  return null;
}

/// Posts a place can ask for. Google reviews are deliberately not one of
/// them: Google forbids reviews in exchange for anything, so treat never
/// asks for one (places get a counter card for honest reviews instead).
const offerableProofTypes = {
  ProofType.igStory,
  ProofType.igPost,
  ProofType.tiktok,
};

/// Validates a shop's offer form. Returns a [TreatException] code or null.
String? validateOfferInput(OfferInput input) {
  if (input.title.trim().isEmpty || input.title.length > 80) {
    return 'invalid_title';
  }
  if (input.description.trim().isEmpty || input.description.length > 500) {
    return 'invalid_description';
  }
  if (input.activeStartMin < 0 ||
      input.activeEndMin > 24 * 60 ||
      input.activeStartMin >= input.activeEndMin) {
    return 'invalid_hours';
  }
  if ((input.dailyCap != null && input.dailyCap! < 1) ||
      (input.totalCap != null && input.totalCap! < 1)) {
    return 'invalid_cap';
  }
  if (input.proofTypes.isEmpty) return 'proof_types_required';
  if (!input.proofTypes.every(offerableProofTypes.contains)) {
    return 'proof_type_not_offered';
  }
  return null;
}
