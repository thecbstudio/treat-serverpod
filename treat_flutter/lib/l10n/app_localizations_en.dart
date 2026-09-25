// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'treat';

  @override
  String get retry => 'Try again';

  @override
  String get loading => 'Loading…';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get back => 'Back';

  @override
  String get logout => 'Log out';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorNetwork =>
      'Couldn\'t reach the server. Check your connection and try again.';

  @override
  String get errorGeneric => 'Something went wrong — please try again.';

  @override
  String get welcomeTagline => 'The sweetest way to get treated.';

  @override
  String get welcomeIntro =>
      'Get free products and services from places around campus — in return, give them a shout-out on social media. Everybody wins.';

  @override
  String get welcomeHow1 => 'Browse open offers, grab one.';

  @override
  String get welcomeHow2 => 'Visit the place, have your QR scanned.';

  @override
  String get welcomeHow3 => 'Upload your post, get your treat approved.';

  @override
  String get welcomeLogin => 'Log in';

  @override
  String get welcomeRegister => 'Create account';

  @override
  String get welcomeForShops =>
      'Are you a business? Sign up the same way and pick “Business”.';

  @override
  String get welcomeDemoHint =>
      'Judging? Demo logins are in the project README.';

  @override
  String get authLoginTitle => 'Welcome back';

  @override
  String get authRegisterTitle => 'Create account';

  @override
  String get authEduHint =>
      'Students: sign up with your university email (.edu / .edu.tr) to get verified instantly.';

  @override
  String get onboardingTitle => 'One last thing';

  @override
  String get onboardingBody => 'How will you use treat?';

  @override
  String get onboardingStudent => 'I\'m a student';

  @override
  String get onboardingStudentHint => 'Claim free treats, post about them.';

  @override
  String get onboardingShop => 'I run a business';

  @override
  String get onboardingShopHint => 'Give treats, get local visibility.';

  @override
  String onboardingSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get studentFormTitle => 'Your student profile';

  @override
  String get fieldName => 'Full name';

  @override
  String get fieldUniversity => 'University';

  @override
  String get fieldUniversityHint => 'e.g. Anadolu University';

  @override
  String get eduDetected =>
      'University email — you\'ll be verified automatically.';

  @override
  String get nonEduNote =>
      'This isn\'t a university email, so your account stays unverified: you can browse offers but not claim them.';

  @override
  String get createProfile => 'Create profile';

  @override
  String get shopFormTitle => 'Your business';

  @override
  String get shopEditTitle => 'Business profile';

  @override
  String get fieldShopName => 'Business name';

  @override
  String get fieldCategory => 'Category';

  @override
  String get fieldDistrict => 'District';

  @override
  String get fieldAddress => 'Address';

  @override
  String get fieldBio => 'Short intro';

  @override
  String get fieldInstagram => 'Instagram handle';

  @override
  String get fieldInstagramHint =>
      'Used to check that posts really mention you.';

  @override
  String get fieldRequired => 'This field is required.';

  @override
  String get saved => 'Saved';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navProfile => 'Profile';

  @override
  String get navOffers => 'Offers';

  @override
  String get navBusiness => 'Business';

  @override
  String get discoverTitle => 'Discover';

  @override
  String get discoverSearch => 'Search places or offers…';

  @override
  String get discoverAll => 'All';

  @override
  String get discoverFeatured => 'Featured';

  @override
  String get discoverEmpty => 'No offers match that right now.';

  @override
  String get discoverEmptyHint => 'Try clearing the filters.';

  @override
  String leftToday(int n) {
    return '$n left today';
  }

  @override
  String get soldOutToday => 'done for today';

  @override
  String get freeTag => 'free';

  @override
  String get categoryCoffee => 'Coffee';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryDessert => 'Dessert';

  @override
  String get categoryBeauty => 'Beauty';

  @override
  String get categoryFitness => 'Fitness';

  @override
  String get categoryActivity => 'Activity';

  @override
  String get frequencyWeekly => 'Once a week';

  @override
  String get frequencyMonthly => 'Once a month';

  @override
  String get frequencyWeeklyLong =>
      'You can claim from this place once a week.';

  @override
  String get frequencyMonthlyLong =>
      'You can claim from this place once a month.';

  @override
  String get proofIgStory => 'Instagram story';

  @override
  String get proofIgPost => 'Instagram post';

  @override
  String get proofGoogleReview => 'Google review';

  @override
  String get proofTiktok => 'TikTok video';

  @override
  String get offerAboutShop => 'About the place';

  @override
  String get offerRules => 'Rules';

  @override
  String get offerHours => 'Active hours';

  @override
  String offerHoursValue(String start, String end) {
    return 'Every day $start–$end';
  }

  @override
  String get offerInReturn => 'In return, post one of';

  @override
  String get offerClaim => 'Claim treat';

  @override
  String get offerClaimHint =>
      'Your QR stays valid for 2 hours — claim it when you can actually go.';

  @override
  String get offerClaimSoon => 'Claiming opens in the next build.';

  @override
  String get offerVerifiedShop => 'Verified business';

  @override
  String offerDailyCap(int n) {
    return 'Up to $n a day';
  }

  @override
  String offerTotalCap(int n) {
    return '$n in total';
  }

  @override
  String get lockActiveClaim => 'You already have an active QR for this offer.';

  @override
  String lockFrequency(String date) {
    return 'You can claim from this place again on $date.';
  }

  @override
  String get lockDailyCap => 'Today\'s slots are gone — try again tomorrow.';

  @override
  String get lockTotalCap => 'This offer\'s quota is used up.';

  @override
  String lockOutsideHours(String time) {
    return 'Not active right now — opens at $time.';
  }

  @override
  String get lockOfferInactive => 'This offer is currently paused.';

  @override
  String get lockTooManyStrikes =>
      'Your account has too many strikes; claiming is disabled.';

  @override
  String get lockNotVerified =>
      'Only verified students can claim. Sign up with a university email.';

  @override
  String get lockShopView =>
      'You\'re signed in as a business — students claim offers.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileVerified => 'Verified student';

  @override
  String get profilePending => 'Not verified';

  @override
  String get profileTreats => 'Treats';

  @override
  String get profileStreak => 'Week streak';

  @override
  String get profileBadges => 'Badges';

  @override
  String get profileNoBadges =>
      'Your first approved treat earns your first badge.';

  @override
  String get profileStrikes => 'Strikes';

  @override
  String profileStrikesNote(int n, int max) {
    return '$n/$max — claiming is disabled at $max.';
  }

  @override
  String get profileNoStrikes => 'No strikes. Keep it up.';

  @override
  String profileMemberSince(String date) {
    return 'Member since $date';
  }

  @override
  String get badgeFirstTreat => 'First treat';

  @override
  String get badgeTenTreats => 'Club of 10';

  @override
  String get badgeTwentyfiveTreats => 'Regular';

  @override
  String get badgeStreak4 => 'Habit';

  @override
  String get badgeExplorer3 => 'Explorer';

  @override
  String get badgeVerifiedStudent => 'Enrolled';

  @override
  String get shopOffersTitle => 'Offers';

  @override
  String get shopNewOffer => 'New offer';

  @override
  String get shopOffersEmpty => 'No offers yet';

  @override
  String get shopOffersEmptyHint =>
      'Create your first offer; students see it in Discover right away.';

  @override
  String get shopOfferLive => 'Live';

  @override
  String get shopOfferPaused => 'Paused';

  @override
  String shopOfferClaimedTotal(int n) {
    return 'Claimed $n times';
  }

  @override
  String shopOfferClaimedToday(int n) {
    return '$n today';
  }

  @override
  String get shopPause => 'Pause';

  @override
  String get shopActivate => 'Activate';

  @override
  String get shopEdit => 'Edit';

  @override
  String get shopDelete => 'Delete';

  @override
  String get shopDeleteConfirm =>
      'Delete this offer? Students won\'t see it anymore.';

  @override
  String get formNewOffer => 'New offer';

  @override
  String get formEditOffer => 'Edit offer';

  @override
  String get formWhat => 'What are you giving?';

  @override
  String get formWhatHint => 'e.g. Medium filter coffee';

  @override
  String get formDesc => 'Description and conditions';

  @override
  String get formDescHint => 'What\'s included, what should they know?';

  @override
  String get formFrequency => 'How often can one student claim?';

  @override
  String get formHours => 'Active hours';

  @override
  String get formFrom => 'From';

  @override
  String get formTo => 'Until';

  @override
  String get formHoursError => 'The end time must be after the start time.';

  @override
  String get formDailyCap => 'Daily maximum';

  @override
  String get formTotalCap => 'Total quota';

  @override
  String get formCapHint => 'Leave empty = unlimited';

  @override
  String get formCapError => 'Enter a whole number of at least 1.';

  @override
  String get formProofTypes => 'What do you want in return?';

  @override
  String get formProofTypesHint =>
      'The student does one of these and uploads a screenshot. A Google review boosts you in local search.';

  @override
  String get formProofTypesError => 'Pick at least one.';

  @override
  String get formPublish => 'Publish';

  @override
  String get err_not_signed_in => 'Please sign in again.';

  @override
  String get err_role_already_set => 'This account already has a role.';

  @override
  String get err_not_a_shop => 'Only businesses can do this.';

  @override
  String get err_not_a_student => 'Only students can do this.';

  @override
  String get err_offer_not_found => 'This offer no longer exists.';

  @override
  String get err_offer_ended => 'This offer was deleted.';

  @override
  String get err_invalid_instagram =>
      'That doesn\'t look like an Instagram handle.';

  @override
  String get err_invalid_hours => 'The end time must be after the start time.';

  @override
  String get err_no_email => 'This account has no email address.';
}
