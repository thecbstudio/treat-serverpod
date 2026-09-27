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

  /// No description provided for @welcomeDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Judging? Demo logins are in the project README.'**
  String get welcomeDemoHint;

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
  /// **'This isn\'t a university email, so your account stays unverified: you can browse offers but not claim them.'**
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
  /// **'Only verified students can claim. Sign up with a university email.'**
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
  /// **'Claimed {n} times'**
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
