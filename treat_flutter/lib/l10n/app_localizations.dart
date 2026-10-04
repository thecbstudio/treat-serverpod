import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'treat'**
  String get appName;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the server. Check your connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong — please try again.'**
  String get errorGeneric;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'The sweetest way to get treated.'**
  String get welcomeTagline;

  /// No description provided for @welcomeIntro.
  ///
  /// In en, this message translates to:
  /// **'Get free products and services from places around campus — in return, give them a shout-out on social media. Everybody wins.'**
  String get welcomeIntro;

  /// No description provided for @welcomeHow1.
  ///
  /// In en, this message translates to:
  /// **'Browse open offers, grab one.'**
  String get welcomeHow1;

  /// No description provided for @welcomeHow2.
  ///
  /// In en, this message translates to:
  /// **'Visit the place, have your QR scanned.'**
  String get welcomeHow2;

  /// No description provided for @welcomeHow3.
  ///
  /// In en, this message translates to:
  /// **'Upload your post, get your treat approved.'**
  String get welcomeHow3;

  /// No description provided for @welcomeLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get welcomeLogin;

  /// No description provided for @welcomeRegister.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get welcomeRegister;

  /// No description provided for @welcomeForShops.
  ///
  /// In en, this message translates to:
  /// **'Are you a business? Sign up the same way and pick “Business”.'**
  String get welcomeForShops;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authLoginTitle;

  /// No description provided for @authRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authRegisterTitle;

  /// No description provided for @authEduHint.
  ///
  /// In en, this message translates to:
  /// **'Students: sign up with your university email (.edu / .edu.tr) to get verified instantly.'**
  String get authEduHint;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'One last thing'**
  String get onboardingTitle;

  /// No description provided for @onboardingBody.
  ///
  /// In en, this message translates to:
  /// **'How will you use treat?'**
  String get onboardingBody;

  /// No description provided for @onboardingStudent.
  ///
  /// In en, this message translates to:
  /// **'I\'m a student'**
  String get onboardingStudent;

  /// No description provided for @onboardingStudentHint.
  ///
  /// In en, this message translates to:
  /// **'Claim free treats, post about them.'**
  String get onboardingStudentHint;

  /// No description provided for @onboardingShop.
  ///
  /// In en, this message translates to:
  /// **'I run a business'**
  String get onboardingShop;

  /// No description provided for @onboardingShopHint.
  ///
  /// In en, this message translates to:
  /// **'Give treats, get local visibility.'**
  String get onboardingShopHint;

  /// No description provided for @onboardingSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String onboardingSignedInAs(String email);

  /// No description provided for @studentFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Your student profile'**
  String get studentFormTitle;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fieldName;

  /// No description provided for @fieldUniversity.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get fieldUniversity;

  /// No description provided for @fieldUniversityHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Anadolu University'**
  String get fieldUniversityHint;

  /// No description provided for @eduDetected.
  ///
  /// In en, this message translates to:
  /// **'University email — you\'ll be verified automatically.'**
  String get eduDetected;

  /// No description provided for @nonEduNote.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t a university email: you can browse offers now, and claim them once you\'ve verified with a photo of your student card.'**
  String get nonEduNote;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create profile'**
  String get createProfile;

  /// No description provided for @shopFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Your business'**
  String get shopFormTitle;

  /// No description provided for @shopEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Business profile'**
  String get shopEditTitle;

  /// No description provided for @fieldShopName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get fieldShopName;

  /// No description provided for @fieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get fieldCategory;

  /// No description provided for @fieldDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get fieldDistrict;

  /// No description provided for @fieldAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get fieldAddress;

  /// No description provided for @fieldBio.
  ///
  /// In en, this message translates to:
  /// **'Short intro'**
  String get fieldBio;

  /// No description provided for @fieldInstagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram handle'**
  String get fieldInstagram;

  /// No description provided for @fieldInstagramHint.
  ///
  /// In en, this message translates to:
  /// **'Used to check that posts really mention you.'**
  String get fieldInstagramHint;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required.'**
  String get fieldRequired;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get navOffers;

  /// No description provided for @navBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get navBusiness;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// No description provided for @discoverSearch.
  ///
  /// In en, this message translates to:
  /// **'Search places or offers…'**
  String get discoverSearch;

  /// No description provided for @discoverAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get discoverAll;

  /// No description provided for @discoverFeatured.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get discoverFeatured;

  /// No description provided for @discoverEmpty.
  ///
  /// In en, this message translates to:
  /// **'No offers match that right now.'**
  String get discoverEmpty;

  /// No description provided for @discoverEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Try clearing the filters.'**
  String get discoverEmptyHint;

  /// No description provided for @leftToday.
  ///
  /// In en, this message translates to:
  /// **'{n} left today'**
  String leftToday(int n);

  /// No description provided for @soldOutToday.
  ///
  /// In en, this message translates to:
  /// **'done for today'**
  String get soldOutToday;

  /// No description provided for @freeTag.
  ///
  /// In en, this message translates to:
  /// **'free'**
  String get freeTag;

  /// No description provided for @categoryCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get categoryCoffee;

  /// No description provided for @categoryFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get categoryFood;

  /// No description provided for @categoryDessert.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get categoryDessert;

  /// No description provided for @categoryBeauty.
  ///
  /// In en, this message translates to:
  /// **'Beauty'**
  String get categoryBeauty;

  /// No description provided for @categoryFitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get categoryFitness;

  /// No description provided for @categoryActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get categoryActivity;

  /// No description provided for @frequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Once a week'**
  String get frequencyWeekly;

  /// No description provided for @frequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Once a month'**
  String get frequencyMonthly;

  /// No description provided for @frequencyWeeklyLong.
  ///
  /// In en, this message translates to:
  /// **'You can claim from this place once a week.'**
  String get frequencyWeeklyLong;

  /// No description provided for @frequencyMonthlyLong.
  ///
  /// In en, this message translates to:
  /// **'You can claim from this place once a month.'**
  String get frequencyMonthlyLong;

  /// No description provided for @proofIgStory.
  ///
  /// In en, this message translates to:
  /// **'Instagram story'**
  String get proofIgStory;

  /// No description provided for @proofIgPost.
  ///
  /// In en, this message translates to:
  /// **'Instagram post'**
  String get proofIgPost;

  /// No description provided for @proofGoogleReview.
  ///
  /// In en, this message translates to:
  /// **'Google review'**
  String get proofGoogleReview;

  /// No description provided for @proofTiktok.
  ///
  /// In en, this message translates to:
  /// **'TikTok video'**
  String get proofTiktok;

  /// No description provided for @offerAboutShop.
  ///
  /// In en, this message translates to:
  /// **'About the place'**
  String get offerAboutShop;

  /// No description provided for @offerRules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get offerRules;

  /// No description provided for @offerHours.
  ///
  /// In en, this message translates to:
  /// **'Active hours'**
  String get offerHours;

  /// No description provided for @offerHoursValue.
  ///
  /// In en, this message translates to:
  /// **'Every day {start}–{end}'**
  String offerHoursValue(String start, String end);

  /// No description provided for @offerInReturn.
  ///
  /// In en, this message translates to:
  /// **'In return, post one of'**
  String get offerInReturn;

  /// No description provided for @offerClaim.
  ///
  /// In en, this message translates to:
  /// **'Claim treat'**
  String get offerClaim;

  /// No description provided for @offerClaimHint.
  ///
  /// In en, this message translates to:
  /// **'Your QR stays valid for 2 hours — claim it when you can actually go.'**
  String get offerClaimHint;

  /// No description provided for @offerClaimSoon.
  ///
  /// In en, this message translates to:
  /// **'Claiming opens in the next build.'**
  String get offerClaimSoon;

  /// No description provided for @offerVerifiedShop.
  ///
  /// In en, this message translates to:
  /// **'Verified business'**
  String get offerVerifiedShop;

  /// No description provided for @offerDailyCap.
  ///
  /// In en, this message translates to:
  /// **'Up to {n} a day'**
  String offerDailyCap(int n);

  /// No description provided for @offerTotalCap.
  ///
  /// In en, this message translates to:
  /// **'{n} in total'**
  String offerTotalCap(int n);

  /// No description provided for @lockActiveClaim.
  ///
  /// In en, this message translates to:
  /// **'You already have an active QR for this offer.'**
  String get lockActiveClaim;

  /// No description provided for @lockFrequency.
  ///
  /// In en, this message translates to:
  /// **'You can claim from this place again on {date}.'**
  String lockFrequency(String date);

  /// No description provided for @lockDailyCap.
  ///
  /// In en, this message translates to:
  /// **'Today\'s slots are gone — try again tomorrow.'**
  String get lockDailyCap;

  /// No description provided for @lockTotalCap.
  ///
  /// In en, this message translates to:
  /// **'This offer\'s quota is used up.'**
  String get lockTotalCap;

  /// No description provided for @lockOutsideHours.
  ///
  /// In en, this message translates to:
  /// **'Not active right now — opens at {time}.'**
  String lockOutsideHours(String time);

  /// No description provided for @lockOfferInactive.
  ///
  /// In en, this message translates to:
  /// **'This offer is currently paused.'**
  String get lockOfferInactive;

  /// No description provided for @lockTooManyStrikes.
  ///
  /// In en, this message translates to:
  /// **'Your account has too many strikes; claiming is disabled.'**
  String get lockTooManyStrikes;

  /// No description provided for @lockNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Only verified students can claim. Verify with a photo of your student card — it takes a minute.'**
  String get lockNotVerified;

  /// No description provided for @lockShopView.
  ///
  /// In en, this message translates to:
  /// **'You\'re signed in as a business — students claim offers.'**
  String get lockShopView;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified student'**
  String get profileVerified;

  /// No description provided for @profilePending.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get profilePending;

  /// No description provided for @profileTreats.
  ///
  /// In en, this message translates to:
  /// **'Treats'**
  String get profileTreats;

  /// No description provided for @profileStreak.
  ///
  /// In en, this message translates to:
  /// **'Week streak'**
  String get profileStreak;

  /// No description provided for @profileBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get profileBadges;

  /// No description provided for @profileNoBadges.
  ///
  /// In en, this message translates to:
  /// **'Your first approved treat earns your first badge.'**
  String get profileNoBadges;

  /// No description provided for @profileStrikes.
  ///
  /// In en, this message translates to:
  /// **'Strikes'**
  String get profileStrikes;

  /// No description provided for @profileStrikesNote.
  ///
  /// In en, this message translates to:
  /// **'{n}/{max} — claiming is disabled at {max}.'**
  String profileStrikesNote(int n, int max);

  /// No description provided for @profileNoStrikes.
  ///
  /// In en, this message translates to:
  /// **'No strikes. Keep it up.'**
  String get profileNoStrikes;

  /// No description provided for @profileMemberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since {date}'**
  String profileMemberSince(String date);

  /// No description provided for @badgeFirstTreat.
  ///
  /// In en, this message translates to:
  /// **'First treat'**
  String get badgeFirstTreat;

  /// No description provided for @badgeTenTreats.
  ///
  /// In en, this message translates to:
  /// **'Club of 10'**
  String get badgeTenTreats;

  /// No description provided for @badgeTwentyfiveTreats.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get badgeTwentyfiveTreats;

  /// No description provided for @badgeStreak4.
  ///
  /// In en, this message translates to:
  /// **'Habit'**
  String get badgeStreak4;

  /// No description provided for @badgeExplorer3.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get badgeExplorer3;

  /// No description provided for @badgeVerifiedStudent.
  ///
  /// In en, this message translates to:
  /// **'Enrolled'**
  String get badgeVerifiedStudent;

  /// No description provided for @shopOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get shopOffersTitle;

  /// No description provided for @shopNewOffer.
  ///
  /// In en, this message translates to:
  /// **'New offer'**
  String get shopNewOffer;

  /// No description provided for @shopOffersEmpty.
  ///
  /// In en, this message translates to:
  /// **'No offers yet'**
  String get shopOffersEmpty;

  /// No description provided for @shopOffersEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Create your first offer; students see it in Discover right away.'**
  String get shopOffersEmptyHint;

  /// No description provided for @shopOfferLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get shopOfferLive;

  /// No description provided for @shopOfferPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get shopOfferPaused;

  /// No description provided for @shopOfferClaimedTotal.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{Claimed once} other{Claimed {n} times}}'**
  String shopOfferClaimedTotal(int n);

  /// No description provided for @shopOfferClaimedToday.
  ///
  /// In en, this message translates to:
  /// **'{n} today'**
  String shopOfferClaimedToday(int n);

  /// No description provided for @shopPause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get shopPause;

  /// No description provided for @shopActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get shopActivate;

  /// No description provided for @shopEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get shopEdit;

  /// No description provided for @shopDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get shopDelete;

  /// No description provided for @shopDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this offer? Students won\'t see it anymore.'**
  String get shopDeleteConfirm;

  /// No description provided for @formNewOffer.
  ///
  /// In en, this message translates to:
  /// **'New offer'**
  String get formNewOffer;

  /// No description provided for @formEditOffer.
  ///
  /// In en, this message translates to:
  /// **'Edit offer'**
  String get formEditOffer;

  /// No description provided for @formWhat.
  ///
  /// In en, this message translates to:
  /// **'What are you giving?'**
  String get formWhat;

  /// No description provided for @formWhatHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Medium filter coffee'**
  String get formWhatHint;

  /// No description provided for @formDesc.
  ///
  /// In en, this message translates to:
  /// **'Description and conditions'**
  String get formDesc;

  /// No description provided for @formDescHint.
  ///
  /// In en, this message translates to:
  /// **'What\'s included, what should they know?'**
  String get formDescHint;

  /// No description provided for @formFrequency.
  ///
  /// In en, this message translates to:
  /// **'How often can one student claim?'**
  String get formFrequency;

  /// No description provided for @formHours.
  ///
  /// In en, this message translates to:
  /// **'Active hours'**
  String get formHours;

  /// No description provided for @formFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get formFrom;

  /// No description provided for @formTo.
  ///
  /// In en, this message translates to:
  /// **'Until'**
  String get formTo;

  /// No description provided for @formHoursError.
  ///
  /// In en, this message translates to:
  /// **'The end time must be after the start time.'**
  String get formHoursError;

  /// No description provided for @formDailyCap.
  ///
  /// In en, this message translates to:
  /// **'Daily maximum'**
  String get formDailyCap;

  /// No description provided for @formTotalCap.
  ///
  /// In en, this message translates to:
  /// **'Total quota'**
  String get formTotalCap;

  /// No description provided for @formCapHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty = unlimited'**
  String get formCapHint;

  /// No description provided for @formCapError.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number of at least 1.'**
  String get formCapError;

  /// No description provided for @formProofTypes.
  ///
  /// In en, this message translates to:
  /// **'What do you want in return?'**
  String get formProofTypes;

  /// No description provided for @formProofTypesHint.
  ///
  /// In en, this message translates to:
  /// **'The student does one of these and uploads a screenshot. A Google review boosts you in local search.'**
  String get formProofTypesHint;

  /// No description provided for @formProofTypesError.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one.'**
  String get formProofTypesError;

  /// No description provided for @formPublish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get formPublish;

  /// No description provided for @err_not_signed_in.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again.'**
  String get err_not_signed_in;

  /// No description provided for @err_role_already_set.
  ///
  /// In en, this message translates to:
  /// **'This account already has a role.'**
  String get err_role_already_set;

  /// No description provided for @err_not_a_shop.
  ///
  /// In en, this message translates to:
  /// **'Only businesses can do this.'**
  String get err_not_a_shop;

  /// No description provided for @err_not_a_student.
  ///
  /// In en, this message translates to:
  /// **'Only students can do this.'**
  String get err_not_a_student;

  /// No description provided for @err_offer_not_found.
  ///
  /// In en, this message translates to:
  /// **'This offer no longer exists.'**
  String get err_offer_not_found;

  /// No description provided for @err_offer_ended.
  ///
  /// In en, this message translates to:
  /// **'This offer was deleted.'**
  String get err_offer_ended;

  /// No description provided for @err_invalid_instagram.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like an Instagram handle.'**
  String get err_invalid_instagram;

  /// No description provided for @err_invalid_hours.
  ///
  /// In en, this message translates to:
  /// **'The end time must be after the start time.'**
  String get err_invalid_hours;

  /// No description provided for @err_no_email.
  ///
  /// In en, this message translates to:
  /// **'This account has no email address.'**
  String get err_no_email;

  /// No description provided for @navMyTreats.
  ///
  /// In en, this message translates to:
  /// **'My treats'**
  String get navMyTreats;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @offerGoToQr.
  ///
  /// In en, this message translates to:
  /// **'Go to your QR'**
  String get offerGoToQr;

  /// No description provided for @lockFrequencyGeneric.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already claimed from this place recently.'**
  String get lockFrequencyGeneric;

  /// No description provided for @claimTitle.
  ///
  /// In en, this message translates to:
  /// **'Your QR code'**
  String get claimTitle;

  /// No description provided for @claimShowThis.
  ///
  /// In en, this message translates to:
  /// **'Show this screen at the counter — once scanned, your treat counts as used.'**
  String get claimShowThis;

  /// No description provided for @claimManualCode.
  ///
  /// In en, this message translates to:
  /// **'Backup code if scanning fails'**
  String get claimManualCode;

  /// No description provided for @claimExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Time left'**
  String get claimExpiresIn;

  /// No description provided for @claimExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get claimExpired;

  /// No description provided for @claimExpiredBody.
  ///
  /// In en, this message translates to:
  /// **'This QR is no longer valid. No worries — claim again if the offer allows.'**
  String get claimExpiredBody;

  /// No description provided for @claimRedeemed.
  ///
  /// In en, this message translates to:
  /// **'Redeemed'**
  String get claimRedeemed;

  /// No description provided for @claimRedeemedAt.
  ///
  /// In en, this message translates to:
  /// **'Redeemed at {time}'**
  String claimRedeemedAt(String time);

  /// No description provided for @claimNextStep.
  ///
  /// In en, this message translates to:
  /// **'Next step: your post'**
  String get claimNextStep;

  /// No description provided for @claimProofExplain.
  ///
  /// In en, this message translates to:
  /// **'Share one of the posts below tagging the place, then upload a screenshot here. Once approved, it counts toward your treats.'**
  String get claimProofExplain;

  /// No description provided for @claimProofSoon.
  ///
  /// In en, this message translates to:
  /// **'Proof upload arrives in the next build.'**
  String get claimProofSoon;

  /// No description provided for @claimLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get claimLive;

  /// No description provided for @claimReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Reconnecting…'**
  String get claimReconnecting;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'QR active'**
  String get statusActive;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusRedeemed.
  ///
  /// In en, this message translates to:
  /// **'Awaiting post'**
  String get statusRedeemed;

  /// No description provided for @statusProofPending.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get statusProofPending;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// No description provided for @claimsTitle.
  ///
  /// In en, this message translates to:
  /// **'My treats'**
  String get claimsTitle;

  /// No description provided for @claimsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t claimed any treats yet.'**
  String get claimsEmpty;

  /// No description provided for @claimsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Head to Discover and grab your first one — a badge is waiting.'**
  String get claimsEmptyHint;

  /// No description provided for @claimsGoDiscover.
  ///
  /// In en, this message translates to:
  /// **'See offers'**
  String get claimsGoDiscover;

  /// No description provided for @claimsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get claimsActive;

  /// No description provided for @claimsPast.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get claimsPast;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanTitle;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Point the camera at the student\'s QR, or type the 6-character code.'**
  String get scanHint;

  /// No description provided for @scanCameraStart.
  ///
  /// In en, this message translates to:
  /// **'Start camera'**
  String get scanCameraStart;

  /// No description provided for @scanCameraStop.
  ///
  /// In en, this message translates to:
  /// **'Stop camera'**
  String get scanCameraStop;

  /// No description provided for @scanCameraFail.
  ///
  /// In en, this message translates to:
  /// **'Camera scanning isn\'t available here — enter the code instead.'**
  String get scanCameraFail;

  /// No description provided for @scanManualLabel.
  ///
  /// In en, this message translates to:
  /// **'6-character code'**
  String get scanManualLabel;

  /// No description provided for @scanCheck.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get scanCheck;

  /// No description provided for @scanSuccess.
  ///
  /// In en, this message translates to:
  /// **'Valid — treat redeemed'**
  String get scanSuccess;

  /// No description provided for @scanAlready.
  ///
  /// In en, this message translates to:
  /// **'Already redeemed — counted once'**
  String get scanAlready;

  /// No description provided for @scanNext.
  ///
  /// In en, this message translates to:
  /// **'Scan next'**
  String get scanNext;

  /// No description provided for @err_not_found.
  ///
  /// In en, this message translates to:
  /// **'No such code.'**
  String get err_not_found;

  /// No description provided for @err_expired.
  ///
  /// In en, this message translates to:
  /// **'This code has expired.'**
  String get err_expired;

  /// No description provided for @err_wrong_shop.
  ///
  /// In en, this message translates to:
  /// **'This code belongs to another business\'s offer.'**
  String get err_wrong_shop;

  /// No description provided for @err_claim_not_found.
  ///
  /// In en, this message translates to:
  /// **'This claim doesn\'t exist.'**
  String get err_claim_not_found;

  /// No description provided for @navLeaderboard.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get navLeaderboard;

  /// No description provided for @navPanel.
  ///
  /// In en, this message translates to:
  /// **'Panel'**
  String get navPanel;

  /// No description provided for @proofPickOne.
  ///
  /// In en, this message translates to:
  /// **'Which one did you post?'**
  String get proofPickOne;

  /// No description provided for @proofTodoIgStory.
  ///
  /// In en, this message translates to:
  /// **'Share an Instagram story that tags the place and says it was a gift (#işbirliği), then upload a screenshot.'**
  String get proofTodoIgStory;

  /// No description provided for @proofTodoIgPost.
  ///
  /// In en, this message translates to:
  /// **'Share an Instagram post that tags the place and says it was a gift (#işbirliği), then upload a screenshot.'**
  String get proofTodoIgPost;

  /// No description provided for @proofTodoGoogleReview.
  ///
  /// In en, this message translates to:
  /// **'Leave the business a Google review, then upload a screenshot.'**
  String get proofTodoGoogleReview;

  /// No description provided for @proofTodoTiktok.
  ///
  /// In en, this message translates to:
  /// **'Post a TikTok that mentions the place and says it was a gift (#işbirliği), then upload a screenshot.'**
  String get proofTodoTiktok;

  /// No description provided for @proofChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose screenshot'**
  String get proofChoose;

  /// No description provided for @proofChange.
  ///
  /// In en, this message translates to:
  /// **'Change image'**
  String get proofChange;

  /// No description provided for @proofSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit proof'**
  String get proofSubmit;

  /// No description provided for @proofUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading…'**
  String get proofUploading;

  /// No description provided for @proofVerifyFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t check your screenshot this time — nothing counted against you. Please send it again.'**
  String get proofVerifyFailed;

  /// No description provided for @claimProofPending.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get claimProofPending;

  /// No description provided for @claimProofPendingBody.
  ///
  /// In en, this message translates to:
  /// **'Our AI is checking your post. It usually takes a few seconds — the result appears here by itself.'**
  String get claimProofPendingBody;

  /// No description provided for @claimApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get claimApproved;

  /// No description provided for @claimApprovedBody.
  ///
  /// In en, this message translates to:
  /// **'Your post was approved and your treat count went up. Enjoy!'**
  String get claimApprovedBody;

  /// No description provided for @claimRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get claimRejected;

  /// No description provided for @claimRejectedBody.
  ///
  /// In en, this message translates to:
  /// **'The post didn\'t meet the requirements. One strike was added to your account ({strikes}/{max}).'**
  String claimRejectedBody(int strikes, int max);

  /// No description provided for @rejectNoMention.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t find the business tag or name in the post.'**
  String get rejectNoMention;

  /// No description provided for @rejectFlagged.
  ///
  /// In en, this message translates to:
  /// **'The place reported that this post was taken down, so the treat was taken back. Reported posts can\'t be appealed — keep your posts up.'**
  String get rejectFlagged;

  /// No description provided for @rejectNoDisclosure.
  ///
  /// In en, this message translates to:
  /// **'The place is tagged, but the post doesn\'t say it was a gift. Add #işbirliği (or #reklam) — Turkey\'s ad rules require it for free products — and appeal with the new screenshot.'**
  String get rejectNoDisclosure;

  /// No description provided for @rejectNotAPost.
  ///
  /// In en, this message translates to:
  /// **'The image doesn\'t look like that kind of post.'**
  String get rejectNotAPost;

  /// No description provided for @rejectUnreadable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read the image — try a clearer screenshot.'**
  String get rejectUnreadable;

  /// No description provided for @appealExplain.
  ///
  /// In en, this message translates to:
  /// **'If your post genuinely qualifies, you can appeal once with the same or a clearer screenshot. If the appeal is approved, the strike is removed.'**
  String get appealExplain;

  /// No description provided for @appealTitle.
  ///
  /// In en, this message translates to:
  /// **'Appeal'**
  String get appealTitle;

  /// No description provided for @appealSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send appeal'**
  String get appealSubmit;

  /// No description provided for @appealUsed.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already used your appeal for this claim.'**
  String get appealUsed;

  /// No description provided for @leaderboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboardTitle;

  /// No description provided for @leaderboardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Top treat collectors'**
  String get leaderboardSubtitle;

  /// No description provided for @leaderboardEmpty.
  ///
  /// In en, this message translates to:
  /// **'No approved treats yet — be the first on the board.'**
  String get leaderboardEmpty;

  /// No description provided for @leaderboardYou.
  ///
  /// In en, this message translates to:
  /// **'you'**
  String get leaderboardYou;

  /// No description provided for @leaderboardTreats.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 treat} other{{n} treats}}'**
  String leaderboardTreats(int n);

  /// No description provided for @dashTitle.
  ///
  /// In en, this message translates to:
  /// **'Panel'**
  String get dashTitle;

  /// No description provided for @dashTotalRedeems.
  ///
  /// In en, this message translates to:
  /// **'Total redeems'**
  String get dashTotalRedeems;

  /// No description provided for @dashApprovedProofs.
  ///
  /// In en, this message translates to:
  /// **'Approved posts'**
  String get dashApprovedProofs;

  /// No description provided for @dashActiveOffers.
  ///
  /// In en, this message translates to:
  /// **'Active offers'**
  String get dashActiveOffers;

  /// No description provided for @dashWeekClaims.
  ///
  /// In en, this message translates to:
  /// **'Claims this week'**
  String get dashWeekClaims;

  /// No description provided for @dashEstReach.
  ///
  /// In en, this message translates to:
  /// **'Estimated reach'**
  String get dashEstReach;

  /// No description provided for @dashEstReachNote.
  ///
  /// In en, this message translates to:
  /// **'approved posts × ~180 avg. views'**
  String get dashEstReachNote;

  /// No description provided for @dashEstValue.
  ///
  /// In en, this message translates to:
  /// **'Estimated marketing value'**
  String get dashEstValue;

  /// No description provided for @dashEstValueNote.
  ///
  /// In en, this message translates to:
  /// **'rough benchmark: ₺0.15 per view'**
  String get dashEstValueNote;

  /// No description provided for @flagHint.
  ///
  /// In en, this message translates to:
  /// **'Post taken down after approval? You can report it once, within 48 hours.'**
  String get flagHint;

  /// No description provided for @flagAction.
  ///
  /// In en, this message translates to:
  /// **'Report removed post'**
  String get flagAction;

  /// No description provided for @flagConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Report this post as removed?'**
  String get flagConfirmTitle;

  /// No description provided for @flagConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'{name} loses this treat and gets a strike. Reports can\'t be undone or appealed — only report posts that are really gone.'**
  String flagConfirmBody(String name);

  /// No description provided for @flagDone.
  ///
  /// In en, this message translates to:
  /// **'Reported. The treat was taken back.'**
  String get flagDone;

  /// No description provided for @dashCompliance.
  ///
  /// In en, this message translates to:
  /// **'Every approved post tags you and carries an ad disclosure (#işbirliği), as Turkey\'s influencer-ad guidelines require for gifted products.'**
  String get dashCompliance;

  /// No description provided for @proofCopyTags.
  ///
  /// In en, this message translates to:
  /// **'Copy “{tags}”'**
  String proofCopyTags(String tags);

  /// No description provided for @proofCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied — paste it into your post'**
  String get proofCopied;

  /// No description provided for @dashLive.
  ///
  /// In en, this message translates to:
  /// **'Live activity'**
  String get dashLive;

  /// No description provided for @dashTopStudents.
  ///
  /// In en, this message translates to:
  /// **'Most active students'**
  String get dashTopStudents;

  /// No description provided for @dashEmpty.
  ///
  /// In en, this message translates to:
  /// **'No activity yet — create an offer and students will show up here.'**
  String get dashEmpty;

  /// No description provided for @dashApprovedCount.
  ///
  /// In en, this message translates to:
  /// **'{n} approved'**
  String dashApprovedCount(int n);

  /// No description provided for @dashViewProof.
  ///
  /// In en, this message translates to:
  /// **'View post'**
  String get dashViewProof;

  /// No description provided for @err_proof_not_allowed.
  ///
  /// In en, this message translates to:
  /// **'This claim doesn\'t take a screenshot right now.'**
  String get err_proof_not_allowed;

  /// No description provided for @err_proof_type_not_accepted.
  ///
  /// In en, this message translates to:
  /// **'Pick one of the posts this place asks for.'**
  String get err_proof_type_not_accepted;

  /// No description provided for @err_invalid_proof.
  ///
  /// In en, this message translates to:
  /// **'Upload a JPEG, PNG or WebP screenshot (max 5 MB).'**
  String get err_invalid_proof;

  /// No description provided for @claimTitleTreat.
  ///
  /// In en, this message translates to:
  /// **'Your treat'**
  String get claimTitleTreat;

  /// No description provided for @welcomeWho.
  ///
  /// In en, this message translates to:
  /// **'Who are you?'**
  String get welcomeWho;

  /// No description provided for @welcomeStudentCta.
  ///
  /// In en, this message translates to:
  /// **'I\'m a student'**
  String get welcomeStudentCta;

  /// No description provided for @welcomeStudentHint.
  ///
  /// In en, this message translates to:
  /// **'Claim free treats around campus, post about them.'**
  String get welcomeStudentHint;

  /// No description provided for @welcomeShopCta.
  ///
  /// In en, this message translates to:
  /// **'I run a business'**
  String get welcomeShopCta;

  /// No description provided for @welcomeShopHint.
  ///
  /// In en, this message translates to:
  /// **'Give small treats, get real local reach from students.'**
  String get welcomeShopHint;

  /// No description provided for @welcomeHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get welcomeHaveAccount;

  /// No description provided for @authShopRegisterTitle.
  ///
  /// In en, this message translates to:
  /// **'Business sign-up'**
  String get authShopRegisterTitle;

  /// No description provided for @authShopHint.
  ///
  /// In en, this message translates to:
  /// **'Create your login first — next you\'ll add your business details.'**
  String get authShopHint;

  /// No description provided for @dropsTitle.
  ///
  /// In en, this message translates to:
  /// **'Live drops'**
  String get dropsTitle;

  /// No description provided for @dropsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last-minute treats — first come, first served.'**
  String get dropsSubtitle;

  /// No description provided for @dropBadge.
  ///
  /// In en, this message translates to:
  /// **'DROP'**
  String get dropBadge;

  /// No description provided for @dropLive.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get dropLive;

  /// No description provided for @dropLeft.
  ///
  /// In en, this message translates to:
  /// **'{n} of {total} left'**
  String dropLeft(int n, int total);

  /// No description provided for @dropSoldOut.
  ///
  /// In en, this message translates to:
  /// **'All gone'**
  String get dropSoldOut;

  /// No description provided for @dropEndsIn.
  ///
  /// In en, this message translates to:
  /// **'ends in {time}'**
  String dropEndsIn(String time);

  /// No description provided for @dropEnded.
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get dropEnded;

  /// No description provided for @dropClaimedOf.
  ///
  /// In en, this message translates to:
  /// **'{n} of {total} claimed'**
  String dropClaimedOf(int n, int total);

  /// No description provided for @dropRules.
  ///
  /// In en, this message translates to:
  /// **'One per student. Pick it up within 30 minutes after the drop ends.'**
  String get dropRules;

  /// No description provided for @dropClaimHint.
  ///
  /// In en, this message translates to:
  /// **'Pick it up by {time} — after that your code stops working.'**
  String dropClaimHint(String time);

  /// No description provided for @lockShortPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get lockShortPaused;

  /// No description provided for @lockShortVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify to claim'**
  String get lockShortVerify;

  /// No description provided for @lockShortActive.
  ///
  /// In en, this message translates to:
  /// **'Claim open'**
  String get lockShortActive;

  /// No description provided for @lockShortUsed.
  ///
  /// In en, this message translates to:
  /// **'Already used'**
  String get lockShortUsed;

  /// No description provided for @lockShortOpens.
  ///
  /// In en, this message translates to:
  /// **'Opens {time}'**
  String lockShortOpens(String time);

  /// No description provided for @lockDropEnded.
  ///
  /// In en, this message translates to:
  /// **'This drop has ended.'**
  String get lockDropEnded;

  /// No description provided for @lockAlreadyClaimed.
  ///
  /// In en, this message translates to:
  /// **'You already got one from this drop.'**
  String get lockAlreadyClaimed;

  /// No description provided for @shopDropsSection.
  ///
  /// In en, this message translates to:
  /// **'Drops'**
  String get shopDropsSection;

  /// No description provided for @shopRegularSection.
  ///
  /// In en, this message translates to:
  /// **'Regular offers'**
  String get shopRegularSection;

  /// No description provided for @shopStartDropCta.
  ///
  /// In en, this message translates to:
  /// **'Got leftovers? Start a drop'**
  String get shopStartDropCta;

  /// No description provided for @shopStartDropHint.
  ///
  /// In en, this message translates to:
  /// **'Surplus pastries, the last seats, an empty hour — students nearby see it live.'**
  String get shopStartDropHint;

  /// No description provided for @dropFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a drop'**
  String get dropFormTitle;

  /// No description provided for @dropFormWhat.
  ///
  /// In en, this message translates to:
  /// **'What\'s up for grabs?'**
  String get dropFormWhat;

  /// No description provided for @dropFormWhatHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 6 croissants from this morning'**
  String get dropFormWhatHint;

  /// No description provided for @dropFormDesc.
  ///
  /// In en, this message translates to:
  /// **'Details (optional)'**
  String get dropFormDesc;

  /// No description provided for @dropFormQuantity.
  ///
  /// In en, this message translates to:
  /// **'How many?'**
  String get dropFormQuantity;

  /// No description provided for @dropFormDuration.
  ///
  /// In en, this message translates to:
  /// **'Open for'**
  String get dropFormDuration;

  /// No description provided for @dropFormMinutes.
  ///
  /// In en, this message translates to:
  /// **'{n} min'**
  String dropFormMinutes(int n);

  /// No description provided for @dropFormStart.
  ///
  /// In en, this message translates to:
  /// **'Start drop'**
  String get dropFormStart;

  /// No description provided for @shopDropEnd.
  ///
  /// In en, this message translates to:
  /// **'End drop'**
  String get shopDropEnd;

  /// No description provided for @shopDropEndConfirm.
  ///
  /// In en, this message translates to:
  /// **'End this drop now? Students who already claimed can still pick up.'**
  String get shopDropEndConfirm;

  /// No description provided for @wallTitle.
  ///
  /// In en, this message translates to:
  /// **'Posts from students'**
  String get wallTitle;

  /// No description provided for @studentWallTitle.
  ///
  /// In en, this message translates to:
  /// **'Posts'**
  String get studentWallTitle;

  /// No description provided for @wallEmpty.
  ///
  /// In en, this message translates to:
  /// **'No shared posts yet.'**
  String get wallEmpty;

  /// No description provided for @wallFreshTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh on the wall'**
  String get wallFreshTitle;

  /// No description provided for @placeTreated.
  ///
  /// In en, this message translates to:
  /// **'Treated {n, plural, =1{1 student} other{{n} students}}'**
  String placeTreated(int n);

  /// No description provided for @placeView.
  ///
  /// In en, this message translates to:
  /// **'View place'**
  String get placeView;

  /// No description provided for @placeOffers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get placeOffers;

  /// No description provided for @placeNoOffers.
  ///
  /// In en, this message translates to:
  /// **'No open offers right now.'**
  String get placeNoOffers;

  /// No description provided for @studentProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get studentProfileTitle;

  /// No description provided for @proofShareOnWall.
  ///
  /// In en, this message translates to:
  /// **'Show my post on {shop}\'s page'**
  String proofShareOnWall(String shop);

  /// No description provided for @proofShareHint.
  ///
  /// In en, this message translates to:
  /// **'Only after approval. You can change this later.'**
  String get proofShareHint;

  /// No description provided for @thanksTitle.
  ///
  /// In en, this message translates to:
  /// **'Say thanks'**
  String get thanksTitle;

  /// No description provided for @thanksHint.
  ///
  /// In en, this message translates to:
  /// **'A short note to {shop} (optional)'**
  String thanksHint(String shop);

  /// No description provided for @thanksSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get thanksSend;

  /// No description provided for @thanksUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get thanksUpdate;

  /// No description provided for @thanksSent.
  ///
  /// In en, this message translates to:
  /// **'Thanks sent'**
  String get thanksSent;

  /// No description provided for @thanksYourNote.
  ///
  /// In en, this message translates to:
  /// **'Your note'**
  String get thanksYourNote;

  /// No description provided for @err_invalid_quantity.
  ///
  /// In en, this message translates to:
  /// **'Pick between 1 and 50.'**
  String get err_invalid_quantity;

  /// No description provided for @err_invalid_duration.
  ///
  /// In en, this message translates to:
  /// **'Pick between 10 and 180 minutes.'**
  String get err_invalid_duration;

  /// No description provided for @err_drop_not_editable.
  ///
  /// In en, this message translates to:
  /// **'Drops can\'t be edited — end it and start a new one.'**
  String get err_drop_not_editable;

  /// No description provided for @err_not_approved.
  ///
  /// In en, this message translates to:
  /// **'You can thank the place after your post is approved.'**
  String get err_not_approved;

  /// No description provided for @err_note_too_long.
  ///
  /// In en, this message translates to:
  /// **'Keep it under 280 characters.'**
  String get err_note_too_long;

  /// No description provided for @err_demo_off.
  ///
  /// In en, this message translates to:
  /// **'Demo sign-in is turned off on this server.'**
  String get err_demo_off;

  /// No description provided for @err_flag_window_over.
  ///
  /// In en, this message translates to:
  /// **'Posts can only be reported within 48 hours of approval.'**
  String get err_flag_window_over;

  /// No description provided for @err_demo_locked.
  ///
  /// In en, this message translates to:
  /// **'This demo account is shared by everyone trying the app, so parts of it are read-only. Create your own offer or start a drop — or try it as a one-tap guest.'**
  String get err_demo_locked;

  /// No description provided for @err_demo_busy.
  ///
  /// In en, this message translates to:
  /// **'Lots of people are trying the demo right now. Try again in a few minutes.'**
  String get err_demo_busy;

  /// No description provided for @err_no_sample.
  ///
  /// In en, this message translates to:
  /// **'There\'s no sample screenshot for this offer. Upload your own.'**
  String get err_no_sample;

  /// No description provided for @demoTitle.
  ///
  /// In en, this message translates to:
  /// **'Judging? Try it in one tap'**
  String get demoTitle;

  /// No description provided for @demoHint.
  ///
  /// In en, this message translates to:
  /// **'Open the student here and the business in a second window — watch both update live.'**
  String get demoHint;

  /// No description provided for @demoStudent.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get demoStudent;

  /// No description provided for @demoShop.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get demoShop;

  /// No description provided for @proofSampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo: no post handy?'**
  String get proofSampleTitle;

  /// No description provided for @proofSampleHint.
  ///
  /// In en, this message translates to:
  /// **'Send a ready-made story screenshot. Claude checks it for real — try a failing one first, then appeal with the good one.'**
  String get proofSampleHint;

  /// No description provided for @proofSampleGood.
  ///
  /// In en, this message translates to:
  /// **'Tags {shop} + #işbirliği'**
  String proofSampleGood(String shop);

  /// No description provided for @proofSampleUndisclosed.
  ///
  /// In en, this message translates to:
  /// **'Tags the place, no #işbirliği'**
  String get proofSampleUndisclosed;

  /// No description provided for @proofSampleBad.
  ///
  /// In en, this message translates to:
  /// **'Tags nobody'**
  String get proofSampleBad;

  /// No description provided for @rateTitle.
  ///
  /// In en, this message translates to:
  /// **'How was {shop}?'**
  String rateTitle(String shop);

  /// No description provided for @rateDone.
  ///
  /// In en, this message translates to:
  /// **'Thanks for rating your visit'**
  String get rateDone;

  /// No description provided for @rateEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get rateEdit;

  /// No description provided for @rateReviewHint.
  ///
  /// In en, this message translates to:
  /// **'A few words for other students (optional, public)'**
  String get rateReviewHint;

  /// No description provided for @ratePrivateHint.
  ///
  /// In en, this message translates to:
  /// **'A note only {shop} sees (optional)'**
  String ratePrivateHint(String shop);

  /// No description provided for @rateDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Be honest — your rating doesn\'t affect your treat. It shows on the place page as a verified visit with a free treat.'**
  String get rateDisclaimer;

  /// No description provided for @rateSave.
  ///
  /// In en, this message translates to:
  /// **'Save rating'**
  String get rateSave;

  /// No description provided for @rateThanks.
  ///
  /// In en, this message translates to:
  /// **'Rating saved'**
  String get rateThanks;

  /// No description provided for @reviewVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified visit · free treat'**
  String get reviewVerified;

  /// No description provided for @reviewsTitle.
  ///
  /// In en, this message translates to:
  /// **'What students say'**
  String get reviewsTitle;

  /// No description provided for @reviewsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No ratings yet — students rate a place after it scans their code.'**
  String get reviewsEmpty;

  /// No description provided for @reviewCount.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 verified rating} other{{n} verified ratings}}'**
  String reviewCount(int n);

  /// No description provided for @dashRatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your treat score'**
  String get dashRatingTitle;

  /// No description provided for @dashPrivateNote.
  ///
  /// In en, this message translates to:
  /// **'Only you see this'**
  String get dashPrivateNote;

  /// No description provided for @err_invalid_rating.
  ///
  /// In en, this message translates to:
  /// **'Pick 1 to 5 stars.'**
  String get err_invalid_rating;

  /// No description provided for @err_not_visited.
  ///
  /// In en, this message translates to:
  /// **'You can rate the place after it scans your code.'**
  String get err_not_visited;

  /// No description provided for @repTitle.
  ///
  /// In en, this message translates to:
  /// **'Reputation kit'**
  String get repTitle;

  /// No description provided for @repIntro.
  ///
  /// In en, this message translates to:
  /// **'Turn treat visits into lasting reputation: a public page with your verified treat score, and a counter card that brings in Google reviews from all your customers.'**
  String get repIntro;

  /// No description provided for @repPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Your public page'**
  String get repPageTitle;

  /// No description provided for @repOpenPage.
  ///
  /// In en, this message translates to:
  /// **'Open page'**
  String get repOpenPage;

  /// No description provided for @repCopyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get repCopyLink;

  /// No description provided for @repLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Link copied — put it in your Instagram bio'**
  String get repLinkCopied;

  /// No description provided for @repCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Google review counter card'**
  String get repCardTitle;

  /// No description provided for @repCardHint.
  ///
  /// In en, this message translates to:
  /// **'In Google Business Profile tap “Ask for reviews”, paste the link here and print the card. Anyone can scan it — it\'s never tied to a treat, which keeps it within Google\'s rules.'**
  String get repCardHint;

  /// No description provided for @repGoogleLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Google review link'**
  String get repGoogleLabel;

  /// No description provided for @repPrintCard.
  ///
  /// In en, this message translates to:
  /// **'Print card'**
  String get repPrintCard;

  /// No description provided for @err_invalid_google_link.
  ///
  /// In en, this message translates to:
  /// **'Paste the review link from your Google Business Profile (it starts with https://g.page or https://search.google.com).'**
  String get err_invalid_google_link;

  /// No description provided for @err_proof_type_not_offered.
  ///
  /// In en, this message translates to:
  /// **'Pick Instagram or TikTok posts — treat never asks for Google reviews, because Google forbids rewarding them. Use the counter card from your Business tab instead.'**
  String get err_proof_type_not_offered;

  /// No description provided for @proofLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Link to your post'**
  String get proofLinkLabel;

  /// No description provided for @proofLinkHelp.
  ///
  /// In en, this message translates to:
  /// **'Feed posts, Reels and TikToks stay online — the place can open yours. Keep it up: TikToks are checked again after a week.'**
  String get proofLinkHelp;

  /// No description provided for @dashOpenPost.
  ///
  /// In en, this message translates to:
  /// **'Open the post'**
  String get dashOpenPost;

  /// No description provided for @rejectPostRemoved.
  ///
  /// In en, this message translates to:
  /// **'Your TikTok was no longer online a week after approval, so the treat was taken back. Keep permanent posts up.'**
  String get rejectPostRemoved;

  /// No description provided for @err_post_link_required.
  ///
  /// In en, this message translates to:
  /// **'Paste the link to your post so the place can see it.'**
  String get err_post_link_required;

  /// No description provided for @err_invalid_post_link.
  ///
  /// In en, this message translates to:
  /// **'Use the share link of your Instagram post/Reel or TikTok (it starts with https://).'**
  String get err_invalid_post_link;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get settingsProfile;

  /// No description provided for @settingsGuestUniversity.
  ///
  /// In en, this message translates to:
  /// **'Demo guests stay at Demo University — sign up to use your own.'**
  String get settingsGuestUniversity;

  /// No description provided for @settingsLegal.
  ///
  /// In en, this message translates to:
  /// **'Privacy & terms'**
  String get settingsLegal;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy notice'**
  String get settingsPrivacy;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTerms;

  /// No description provided for @settingsAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsAccount;

  /// No description provided for @settingsSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String settingsSignedInAs(String email);

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountStudent.
  ///
  /// In en, this message translates to:
  /// **'Your profile, treats, ratings, reviews, notes and post screenshots are deleted right away. This can\'t be undone.'**
  String get deleteAccountStudent;

  /// No description provided for @deleteAccountShop.
  ///
  /// In en, this message translates to:
  /// **'Your place, its offers, the claims made there and their screenshots are deleted right away. This can\'t be undone.'**
  String get deleteAccountShop;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'I understand this can\'t be undone'**
  String get deleteAccountConfirm;

  /// No description provided for @deleteAccountGo.
  ///
  /// In en, this message translates to:
  /// **'Delete forever'**
  String get deleteAccountGo;

  /// No description provided for @deleteAccountDone.
  ///
  /// In en, this message translates to:
  /// **'Your account was deleted'**
  String get deleteAccountDone;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @reportTitleReview.
  ///
  /// In en, this message translates to:
  /// **'Report this review'**
  String get reportTitleReview;

  /// No description provided for @reportTitlePost.
  ///
  /// In en, this message translates to:
  /// **'Report this post'**
  String get reportTitlePost;

  /// No description provided for @reportTitleShop.
  ///
  /// In en, this message translates to:
  /// **'Report this place'**
  String get reportTitleShop;

  /// No description provided for @reportSpam.
  ///
  /// In en, this message translates to:
  /// **'Spam or advertising'**
  String get reportSpam;

  /// No description provided for @reportOffensive.
  ///
  /// In en, this message translates to:
  /// **'Offensive or hateful'**
  String get reportOffensive;

  /// No description provided for @reportFake.
  ///
  /// In en, this message translates to:
  /// **'Fake or misleading'**
  String get reportFake;

  /// No description provided for @reportPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Shows someone without consent'**
  String get reportPrivacy;

  /// No description provided for @reportOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get reportOther;

  /// No description provided for @reportSend.
  ///
  /// In en, this message translates to:
  /// **'Send report'**
  String get reportSend;

  /// No description provided for @reportThanks.
  ///
  /// In en, this message translates to:
  /// **'Thanks — content reported by several people is hidden, and we look at every report.'**
  String get reportThanks;

  /// No description provided for @err_own_content.
  ///
  /// In en, this message translates to:
  /// **'You can\'t report your own page.'**
  String get err_own_content;

  /// No description provided for @err_guest_university.
  ///
  /// In en, this message translates to:
  /// **'Demo guests stay at Demo University. Sign up to use your own.'**
  String get err_guest_university;

  /// No description provided for @err_invalid_name.
  ///
  /// In en, this message translates to:
  /// **'Enter a name (up to 60 characters).'**
  String get err_invalid_name;

  /// No description provided for @err_invalid_university.
  ///
  /// In en, this message translates to:
  /// **'Enter your university (up to 80 characters).'**
  String get err_invalid_university;

  /// No description provided for @verifyStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify you\'re a student'**
  String get verifyStudentTitle;

  /// No description provided for @verifyShopTitle.
  ///
  /// In en, this message translates to:
  /// **'Get the verified badge'**
  String get verifyShopTitle;

  /// No description provided for @verifyStudentIntro.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of the front of your student ID card (or your university\'s digital student card). Claude checks it in about a minute.'**
  String get verifyStudentIntro;

  /// No description provided for @verifyShopIntro.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of an official document of your business: tax certificate (vergi levhası), workplace licence, or trade registry record. Claude checks it in about a minute, and your place gets the verified badge students see.'**
  String get verifyShopIntro;

  /// No description provided for @verifyMustMatch.
  ///
  /// In en, this message translates to:
  /// **'It must match your profile'**
  String get verifyMustMatch;

  /// No description provided for @verifyStudentMatchHint.
  ///
  /// In en, this message translates to:
  /// **'Name and university as on the card — fix them in Settings first if needed.'**
  String get verifyStudentMatchHint;

  /// No description provided for @verifyShopMatchHint.
  ///
  /// In en, this message translates to:
  /// **'The legal trade name may differ from your sign; then the address must match.'**
  String get verifyShopMatchHint;

  /// No description provided for @verifyTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get verifyTakePhoto;

  /// No description provided for @verifyChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose photo'**
  String get verifyChoosePhoto;

  /// No description provided for @verifySend.
  ///
  /// In en, this message translates to:
  /// **'Send for checking'**
  String get verifySend;

  /// No description provided for @verifyChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking your photo… you can leave this page, we\'ll keep going.'**
  String get verifyChecking;

  /// No description provided for @verifyPrivacy.
  ///
  /// In en, this message translates to:
  /// **'The photo is stored privately, seen only by the AI, and deleted as soon as it has decided. We keep only the result.'**
  String get verifyPrivacy;

  /// No description provided for @verifyStudentDone.
  ///
  /// In en, this message translates to:
  /// **'You\'re a verified student — go claim your first treat!'**
  String get verifyStudentDone;

  /// No description provided for @verifyShopDone.
  ///
  /// In en, this message translates to:
  /// **'Your place is verified: students see the badge on your page and offers.'**
  String get verifyShopDone;

  /// No description provided for @verifyFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t check the photo just now. Please send it again.'**
  String get verifyFailed;

  /// No description provided for @verifyNotAStudentCard.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like a student ID card. Photograph the front of your university card.'**
  String get verifyNotAStudentCard;

  /// No description provided for @verifyNotABusinessDocument.
  ///
  /// In en, this message translates to:
  /// **'That doesn\'t look like an official business document. Use your tax certificate, licence or registry record.'**
  String get verifyNotABusinessDocument;

  /// No description provided for @verifyNameMismatch.
  ///
  /// In en, this message translates to:
  /// **'The name on the document doesn\'t match your profile. Check your name in Settings, or use your own document.'**
  String get verifyNameMismatch;

  /// No description provided for @verifySchoolMismatch.
  ///
  /// In en, this message translates to:
  /// **'The university on the card doesn\'t match your profile. Fix it in Settings and send again.'**
  String get verifySchoolMismatch;

  /// No description provided for @verifyExpired.
  ///
  /// In en, this message translates to:
  /// **'This card has expired. Use your current card or the digital card from your university.'**
  String get verifyExpired;

  /// No description provided for @verifyUnreadable.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read the photo. Take it in good light, flat and sharp, with the whole document visible.'**
  String get verifyUnreadable;

  /// No description provided for @verifyCta.
  ///
  /// In en, this message translates to:
  /// **'Verify with your student card'**
  String get verifyCta;

  /// No description provided for @verifyShopCta.
  ///
  /// In en, this message translates to:
  /// **'Get verified'**
  String get verifyShopCta;

  /// No description provided for @verifyShopBanner.
  ///
  /// In en, this message translates to:
  /// **'Verified places get a badge on their page and offers. Send a photo of your tax certificate or licence.'**
  String get verifyShopBanner;

  /// No description provided for @verifiedBusiness.
  ///
  /// In en, this message translates to:
  /// **'Verified business'**
  String get verifiedBusiness;

  /// No description provided for @err_already_verified.
  ///
  /// In en, this message translates to:
  /// **'You\'re already verified.'**
  String get err_already_verified;

  /// No description provided for @err_check_pending.
  ///
  /// In en, this message translates to:
  /// **'Your last photo is still being checked.'**
  String get err_check_pending;

  /// No description provided for @err_too_many_checks.
  ///
  /// In en, this message translates to:
  /// **'That was 3 tries today — try again tomorrow.'**
  String get err_too_many_checks;

  /// No description provided for @err_no_role.
  ///
  /// In en, this message translates to:
  /// **'Finish setting up your account first.'**
  String get err_no_role;

  /// No description provided for @navGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get navGifts;

  /// No description provided for @giftsTitle.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get giftsTitle;

  /// No description provided for @giftsIntro.
  ///
  /// In en, this message translates to:
  /// **'Pay for a treat at a verified place and give it to a friend. They show a QR at the counter; the place gets 85 %.'**
  String get giftsIntro;

  /// No description provided for @giftsReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get giftsReceived;

  /// No description provided for @giftsSent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get giftsSent;

  /// No description provided for @giftsSend.
  ///
  /// In en, this message translates to:
  /// **'Send a gift'**
  String get giftsSend;

  /// No description provided for @giftsEmptyReceived.
  ///
  /// In en, this message translates to:
  /// **'No gifts yet. A friend can gift you a treat with the e-mail you signed up with.'**
  String get giftsEmptyReceived;

  /// No description provided for @giftsEmptySent.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t sent a gift yet.'**
  String get giftsEmptySent;

  /// No description provided for @giftsOff.
  ///
  /// In en, this message translates to:
  /// **'Gifts need payments, which aren\'t set up on this server.'**
  String get giftsOff;

  /// No description provided for @giftStatusAwaitingPayment.
  ///
  /// In en, this message translates to:
  /// **'Waiting for payment'**
  String get giftStatusAwaitingPayment;

  /// No description provided for @giftStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Ready to collect'**
  String get giftStatusPending;

  /// No description provided for @giftStatusRedeemed.
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get giftStatusRedeemed;

  /// No description provided for @giftStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get giftStatusCancelled;

  /// No description provided for @giftStatusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get giftStatusExpired;

  /// No description provided for @giftStatusFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get giftStatusFailed;

  /// No description provided for @giftFrom.
  ///
  /// In en, this message translates to:
  /// **'From {name}'**
  String giftFrom(String name);

  /// No description provided for @giftTo.
  ///
  /// In en, this message translates to:
  /// **'To {name}'**
  String giftTo(String name);

  /// No description provided for @giftSendTitle.
  ///
  /// In en, this message translates to:
  /// **'Send a gift'**
  String get giftSendTitle;

  /// No description provided for @giftPlace.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get giftPlace;

  /// No description provided for @giftNoPlaces.
  ///
  /// In en, this message translates to:
  /// **'No verified places yet — gifts go to places that passed the document check.'**
  String get giftNoPlaces;

  /// No description provided for @giftAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount (TL)'**
  String get giftAmountLabel;

  /// No description provided for @giftAmountHelp.
  ///
  /// In en, this message translates to:
  /// **'20 to 1000 TL'**
  String get giftAmountHelp;

  /// No description provided for @giftRecipient.
  ///
  /// In en, this message translates to:
  /// **'Friend\'s e-mail'**
  String get giftRecipient;

  /// No description provided for @giftRecipientHelp.
  ///
  /// In en, this message translates to:
  /// **'The e-mail they signed up to treat with'**
  String get giftRecipientHelp;

  /// No description provided for @giftToName.
  ///
  /// In en, this message translates to:
  /// **'Gift to {name}'**
  String giftToName(String name);

  /// No description provided for @giftMessage.
  ///
  /// In en, this message translates to:
  /// **'Message (optional)'**
  String get giftMessage;

  /// No description provided for @giftSplit.
  ///
  /// In en, this message translates to:
  /// **'{place} gets {net} TL · treat keeps {commission} TL (15 %)'**
  String giftSplit(String place, String net, String commission);

  /// No description provided for @giftPay.
  ///
  /// In en, this message translates to:
  /// **'Pay {n} TL'**
  String giftPay(int n);

  /// No description provided for @giftSecure.
  ///
  /// In en, this message translates to:
  /// **'You pay by card on iyzico\'s secure page — treat never sees your card.'**
  String get giftSecure;

  /// No description provided for @giftSandboxHint.
  ///
  /// In en, this message translates to:
  /// **'Test mode: use card 5528 7900 0000 0008, any future date, CVC 123, SMS code 283126. No real money moves.'**
  String get giftSandboxHint;

  /// No description provided for @giftDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get giftDetailTitle;

  /// No description provided for @giftConfirming.
  ///
  /// In en, this message translates to:
  /// **'Confirming your payment…'**
  String get giftConfirming;

  /// No description provided for @giftPaidOk.
  ///
  /// In en, this message translates to:
  /// **'Payment received — your friend can collect it now.'**
  String get giftPaidOk;

  /// No description provided for @giftPayFailed.
  ///
  /// In en, this message translates to:
  /// **'The payment didn\'t go through, so nothing was charged.'**
  String get giftPayFailed;

  /// No description provided for @giftPayUnknown.
  ///
  /// In en, this message translates to:
  /// **'iyzico hasn\'t confirmed yet. Pull down to check again in a minute.'**
  String get giftPayUnknown;

  /// No description provided for @giftShowQr.
  ///
  /// In en, this message translates to:
  /// **'Show this at {place}'**
  String giftShowQr(String place);

  /// No description provided for @giftValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String giftValidUntil(String date);

  /// No description provided for @giftCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel gift'**
  String get giftCancel;

  /// No description provided for @giftCancelTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this gift?'**
  String get giftCancelTitle;

  /// No description provided for @giftCancelBody.
  ///
  /// In en, this message translates to:
  /// **'You get a full refund and your friend can no longer collect it.'**
  String get giftCancelBody;

  /// No description provided for @giftCancelDone.
  ///
  /// In en, this message translates to:
  /// **'Gift cancelled'**
  String get giftCancelDone;

  /// No description provided for @giftRefundPending.
  ///
  /// In en, this message translates to:
  /// **'Your refund is on its way.'**
  String get giftRefundPending;

  /// No description provided for @giftRefunded.
  ///
  /// In en, this message translates to:
  /// **'Refunded to your card.'**
  String get giftRefunded;

  /// No description provided for @giftRedeemedNote.
  ///
  /// In en, this message translates to:
  /// **'Collected at {place}.'**
  String giftRedeemedNote(String place);

  /// No description provided for @giftReceivedNote.
  ///
  /// In en, this message translates to:
  /// **'Collecting it counts as a treat on your profile.'**
  String get giftReceivedNote;

  /// No description provided for @giftWaitingNote.
  ///
  /// In en, this message translates to:
  /// **'{name} can collect it at {place} until {date}.'**
  String giftWaitingNote(String name, String place, String date);

  /// No description provided for @giftCta.
  ///
  /// In en, this message translates to:
  /// **'Gift a treat'**
  String get giftCta;

  /// No description provided for @giftYourAddress.
  ///
  /// In en, this message translates to:
  /// **'Friends can gift you with this e-mail'**
  String get giftYourAddress;

  /// No description provided for @scanGiftSuccess.
  ///
  /// In en, this message translates to:
  /// **'Gift handed over'**
  String get scanGiftSuccess;

  /// No description provided for @scanGiftFor.
  ///
  /// In en, this message translates to:
  /// **'Gift for {name} · {n} TL'**
  String scanGiftFor(String name, int n);

  /// No description provided for @dashGiftsTitle.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get dashGiftsTitle;

  /// No description provided for @dashGiftsCollected.
  ///
  /// In en, this message translates to:
  /// **'Collected'**
  String get dashGiftsCollected;

  /// No description provided for @dashGiftsWaiting.
  ///
  /// In en, this message translates to:
  /// **'Waiting'**
  String get dashGiftsWaiting;

  /// No description provided for @dashGiftsNet.
  ///
  /// In en, this message translates to:
  /// **'{n} TL for you after treat\'s 15 %'**
  String dashGiftsNet(String n);

  /// No description provided for @dashGiftsWaitingNet.
  ///
  /// In en, this message translates to:
  /// **'{n} TL paid in, not collected yet'**
  String dashGiftsWaitingNet(String n);

  /// No description provided for @dashGiftsHint.
  ///
  /// In en, this message translates to:
  /// **'Gift payments are collected by treat; paying them out to places is not automated in this build.'**
  String get dashGiftsHint;

  /// No description provided for @err_gift_to_self.
  ///
  /// In en, this message translates to:
  /// **'You can\'t gift yourself — pick a friend.'**
  String get err_gift_to_self;

  /// No description provided for @err_recipient_not_found.
  ///
  /// In en, this message translates to:
  /// **'No student on treat has that e-mail.'**
  String get err_recipient_not_found;

  /// No description provided for @err_recipient_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Only verified students can receive gifts.'**
  String get err_recipient_not_verified;

  /// No description provided for @err_invalid_recipient.
  ///
  /// In en, this message translates to:
  /// **'Enter your friend\'s e-mail.'**
  String get err_invalid_recipient;

  /// No description provided for @err_shop_not_giftable.
  ///
  /// In en, this message translates to:
  /// **'Gifts go to verified places only.'**
  String get err_shop_not_giftable;

  /// No description provided for @err_invalid_amount.
  ///
  /// In en, this message translates to:
  /// **'Gifts are 20 to 1000 TL.'**
  String get err_invalid_amount;

  /// No description provided for @err_daily_gift_cap.
  ///
  /// In en, this message translates to:
  /// **'That\'s 10 gifts today — try again tomorrow.'**
  String get err_daily_gift_cap;

  /// No description provided for @err_payment_unavailable.
  ///
  /// In en, this message translates to:
  /// **'The payment page isn\'t available right now. Try again in a moment.'**
  String get err_payment_unavailable;

  /// No description provided for @err_payments_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Payments aren\'t set up on this server.'**
  String get err_payments_unavailable;

  /// No description provided for @err_gift_redeemed.
  ///
  /// In en, this message translates to:
  /// **'The place already handed this gift over.'**
  String get err_gift_redeemed;

  /// No description provided for @err_gift_closed.
  ///
  /// In en, this message translates to:
  /// **'This gift is no longer valid.'**
  String get err_gift_closed;

  /// No description provided for @err_not_verified.
  ///
  /// In en, this message translates to:
  /// **'Verify your student status first.'**
  String get err_not_verified;

  /// No description provided for @demoUnverified.
  ///
  /// In en, this message translates to:
  /// **'Try the student-card check'**
  String get demoUnverified;

  /// No description provided for @demoUnverifiedHint.
  ///
  /// In en, this message translates to:
  /// **'A student who isn\'t verified yet'**
  String get demoUnverifiedHint;

  /// No description provided for @verifySampleTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo: no card at hand?'**
  String get verifySampleTitle;

  /// No description provided for @verifySampleMatching.
  ///
  /// In en, this message translates to:
  /// **'Use the sample card'**
  String get verifySampleMatching;

  /// No description provided for @verifySampleOther.
  ///
  /// In en, this message translates to:
  /// **'Use someone else\'s card'**
  String get verifySampleOther;

  /// No description provided for @verifySampleHint.
  ///
  /// In en, this message translates to:
  /// **'Ready-made card photos. The real AI checks them like any upload — the second one shows a rejection.'**
  String get verifySampleHint;

  /// No description provided for @err_demo_only.
  ///
  /// In en, this message translates to:
  /// **'Samples are only for demo students.'**
  String get err_demo_only;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
