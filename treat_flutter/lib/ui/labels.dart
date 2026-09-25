import 'package:intl/intl.dart';
import 'package:treat_client/treat_client.dart';

import '../l10n/app_localizations.dart';

/// Istanbul is UTC+3 all year; all business times are shown in it.
const _istanbulOffset = Duration(hours: 3);

String hhmm(int minuteOfDay) =>
    '${(minuteOfDay ~/ 60).toString().padLeft(2, '0')}:'
    '${(minuteOfDay % 60).toString().padLeft(2, '0')}';

/// "Mon 27 Jul, 14:05" in Istanbul time.
String istanbulDateTime(DateTime instant) =>
    DateFormat('EEE d MMM, HH:mm').format(instant.toUtc().add(_istanbulOffset));

String istanbulDate(DateTime instant) =>
    DateFormat('d MMM yyyy').format(instant.toUtc().add(_istanbulOffset));

extension CategoryLabel on OfferCategory {
  String label(AppLocalizations l) => switch (this) {
    OfferCategory.coffee => l.categoryCoffee,
    OfferCategory.food => l.categoryFood,
    OfferCategory.dessert => l.categoryDessert,
    OfferCategory.beauty => l.categoryBeauty,
    OfferCategory.fitness => l.categoryFitness,
    OfferCategory.activity => l.categoryActivity,
  };

  String get imageAsset => 'assets/cat/$name.jpg';
}

extension FrequencyLabel on OfferFrequency {
  String label(AppLocalizations l) => switch (this) {
    OfferFrequency.weekly => l.frequencyWeekly,
    OfferFrequency.monthly => l.frequencyMonthly,
  };

  String longLabel(AppLocalizations l) => switch (this) {
    OfferFrequency.weekly => l.frequencyWeeklyLong,
    OfferFrequency.monthly => l.frequencyMonthlyLong,
  };
}

extension ProofLabel on ProofType {
  String label(AppLocalizations l) => switch (this) {
    ProofType.igStory => l.proofIgStory,
    ProofType.igPost => l.proofIgPost,
    ProofType.googleReview => l.proofGoogleReview,
    ProofType.tiktok => l.proofTiktok,
  };
}

extension BadgeLabel on BadgeId {
  String label(AppLocalizations l) => switch (this) {
    BadgeId.firstTreat => l.badgeFirstTreat,
    BadgeId.tenTreats => l.badgeTenTreats,
    BadgeId.twentyfiveTreats => l.badgeTwentyfiveTreats,
    BadgeId.streak4 => l.badgeStreak4,
    BadgeId.explorer3 => l.badgeExplorer3,
    BadgeId.verifiedStudent => l.badgeVerifiedStudent,
  };
}

/// Why the student can't claim, or null when they can.
String? lockMessage(Eligibility e, AppLocalizations l) => switch (e.reason) {
  EligibilityReason.ok => null,
  EligibilityReason.offerInactive => l.lockOfferInactive,
  EligibilityReason.notVerified => l.lockNotVerified,
  EligibilityReason.tooManyStrikes => l.lockTooManyStrikes,
  EligibilityReason.activeClaim => l.lockActiveClaim,
  EligibilityReason.frequency => l.lockFrequency(
    istanbulDateTime(e.availableAt!),
  ),
  EligibilityReason.outsideHours => l.lockOutsideHours(hhmm(e.opensAtMin!)),
  EligibilityReason.totalCap => l.lockTotalCap,
  EligibilityReason.dailyCap => l.lockDailyCap,
};

/// Maps any error to user-facing copy. Never shows raw exceptions.
String errorMessage(Object error, AppLocalizations l) {
  if (error is TreatException) {
    return switch (error.code) {
      'not_signed_in' => l.err_not_signed_in,
      'role_already_set' => l.err_role_already_set,
      'not_a_shop' => l.err_not_a_shop,
      'not_a_student' => l.err_not_a_student,
      'offer_not_found' => l.err_offer_not_found,
      'offer_ended' => l.err_offer_ended,
      'invalid_instagram' => l.err_invalid_instagram,
      'invalid_hours' => l.err_invalid_hours,
      'no_email' => l.err_no_email,
      _ => l.errorGeneric,
    };
  }
  final text = error.toString();
  if (text.contains('SocketException') ||
      text.contains('XMLHttpRequest') ||
      text.contains('ClientException') ||
      text.contains('Failed to fetch')) {
    return l.errorNetwork;
  }
  return l.errorGeneric;
}
