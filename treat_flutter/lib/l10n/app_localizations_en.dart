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
      'This isn\'t a university email: you can browse offers now, and claim them once you\'ve verified with a photo of your student card.';

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
      'Only verified students can claim. Verify with a photo of your student card — it takes a minute.';

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
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Claimed $n times',
      one: 'Claimed once',
    );
    return '$_temp0';
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

  @override
  String get navMyTreats => 'My treats';

  @override
  String get navScan => 'Scan';

  @override
  String get offerGoToQr => 'Go to your QR';

  @override
  String get lockFrequencyGeneric =>
      'You\'ve already claimed from this place recently.';

  @override
  String get claimTitle => 'Your QR code';

  @override
  String get claimShowThis =>
      'Show this screen at the counter — once scanned, your treat counts as used.';

  @override
  String get claimManualCode => 'Backup code if scanning fails';

  @override
  String get claimExpiresIn => 'Time left';

  @override
  String get claimExpired => 'Expired';

  @override
  String get claimExpiredBody =>
      'This QR is no longer valid. No worries — claim again if the offer allows.';

  @override
  String get claimRedeemed => 'Redeemed';

  @override
  String claimRedeemedAt(String time) {
    return 'Redeemed at $time';
  }

  @override
  String get claimNextStep => 'Next step: your post';

  @override
  String get claimProofExplain =>
      'Share one of the posts below tagging the place, then upload a screenshot here. Once approved, it counts toward your treats.';

  @override
  String get claimProofSoon => 'Proof upload arrives in the next build.';

  @override
  String get claimLive => 'Live';

  @override
  String get claimReconnecting => 'Reconnecting…';

  @override
  String get statusActive => 'QR active';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusRedeemed => 'Awaiting post';

  @override
  String get statusProofPending => 'Under review';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusRejected => 'Rejected';

  @override
  String get claimsTitle => 'My treats';

  @override
  String get claimsEmpty => 'You haven\'t claimed any treats yet.';

  @override
  String get claimsEmptyHint =>
      'Head to Discover and grab your first one — a badge is waiting.';

  @override
  String get claimsGoDiscover => 'See offers';

  @override
  String get claimsActive => 'Active';

  @override
  String get claimsPast => 'Past';

  @override
  String get scanTitle => 'Scan QR';

  @override
  String get scanHint =>
      'Point the camera at the student\'s QR, or type the 6-character code.';

  @override
  String get scanCameraStart => 'Start camera';

  @override
  String get scanCameraStop => 'Stop camera';

  @override
  String get scanCameraFail =>
      'Camera scanning isn\'t available here — enter the code instead.';

  @override
  String get scanManualLabel => '6-character code';

  @override
  String get scanCheck => 'Verify code';

  @override
  String get scanSuccess => 'Valid — treat redeemed';

  @override
  String get scanAlready => 'Already redeemed — counted once';

  @override
  String get scanNext => 'Scan next';

  @override
  String get err_not_found => 'No such code.';

  @override
  String get err_expired => 'This code has expired.';

  @override
  String get err_wrong_shop =>
      'This code belongs to another business\'s offer.';

  @override
  String get err_claim_not_found => 'This claim doesn\'t exist.';

  @override
  String get navLeaderboard => 'Ranking';

  @override
  String get navPanel => 'Panel';

  @override
  String get proofPickOne => 'Which one did you post?';

  @override
  String get proofTodoIgStory =>
      'Share an Instagram story that tags the place and says it was a gift (#işbirliği), then upload a screenshot.';

  @override
  String get proofTodoIgPost =>
      'Share an Instagram post that tags the place and says it was a gift (#işbirliği), then upload a screenshot.';

  @override
  String get proofTodoGoogleReview =>
      'Leave the business a Google review, then upload a screenshot.';

  @override
  String get proofTodoTiktok =>
      'Post a TikTok that mentions the place and says it was a gift (#işbirliği), then upload a screenshot.';

  @override
  String get proofChoose => 'Choose screenshot';

  @override
  String get proofChange => 'Change image';

  @override
  String get proofSubmit => 'Submit proof';

  @override
  String get proofUploading => 'Uploading…';

  @override
  String get proofVerifyFailed =>
      'We couldn\'t check your screenshot this time — nothing counted against you. Please send it again.';

  @override
  String get claimProofPending => 'Under review';

  @override
  String get claimProofPendingBody =>
      'Our AI is checking your post. It usually takes a few seconds — the result appears here by itself.';

  @override
  String get claimApproved => 'Approved';

  @override
  String get claimApprovedBody =>
      'Your post was approved and your treat count went up. Enjoy!';

  @override
  String get claimRejected => 'Rejected';

  @override
  String claimRejectedBody(int strikes, int max) {
    return 'The post didn\'t meet the requirements. One strike was added to your account ($strikes/$max).';
  }

  @override
  String get rejectNoMention =>
      'Couldn\'t find the business tag or name in the post.';

  @override
  String get rejectFlagged =>
      'The place reported that this post was taken down, so the treat was taken back. Reported posts can\'t be appealed — keep your posts up.';

  @override
  String get rejectNoDisclosure =>
      'The place is tagged, but the post doesn\'t say it was a gift. Add #işbirliği (or #reklam) — Turkey\'s ad rules require it for free products — and appeal with the new screenshot.';

  @override
  String get rejectNotAPost =>
      'The image doesn\'t look like that kind of post.';

  @override
  String get rejectUnreadable =>
      'Couldn\'t read the image — try a clearer screenshot.';

  @override
  String get appealExplain =>
      'If your post genuinely qualifies, you can appeal once with the same or a clearer screenshot. If the appeal is approved, the strike is removed.';

  @override
  String get appealTitle => 'Appeal';

  @override
  String get appealSubmit => 'Send appeal';

  @override
  String get appealUsed => 'You\'ve already used your appeal for this claim.';

  @override
  String get leaderboardTitle => 'Leaderboard';

  @override
  String get leaderboardSubtitle => 'Top treat collectors';

  @override
  String get leaderboardEmpty =>
      'No approved treats yet — be the first on the board.';

  @override
  String get leaderboardYou => 'you';

  @override
  String leaderboardTreats(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n treats',
      one: '1 treat',
    );
    return '$_temp0';
  }

  @override
  String get dashTitle => 'Panel';

  @override
  String get dashTotalRedeems => 'Total redeems';

  @override
  String get dashApprovedProofs => 'Approved posts';

  @override
  String get dashActiveOffers => 'Active offers';

  @override
  String get dashWeekClaims => 'Claims this week';

  @override
  String get dashEstReach => 'Estimated reach';

  @override
  String get dashEstReachNote => 'approved posts × ~180 avg. views';

  @override
  String get dashEstValue => 'Estimated marketing value';

  @override
  String get dashEstValueNote => 'rough benchmark: ₺0.15 per view';

  @override
  String get flagHint =>
      'Post taken down after approval? You can report it once, within 48 hours.';

  @override
  String get flagAction => 'Report removed post';

  @override
  String get flagConfirmTitle => 'Report this post as removed?';

  @override
  String flagConfirmBody(String name) {
    return '$name loses this treat and gets a strike. Reports can\'t be undone or appealed — only report posts that are really gone.';
  }

  @override
  String get flagDone => 'Reported. The treat was taken back.';

  @override
  String get dashCompliance =>
      'Every approved post tags you and carries an ad disclosure (#işbirliği), as Turkey\'s influencer-ad guidelines require for gifted products.';

  @override
  String proofCopyTags(String tags) {
    return 'Copy “$tags”';
  }

  @override
  String get proofCopied => 'Copied — paste it into your post';

  @override
  String get dashLive => 'Live activity';

  @override
  String get dashTopStudents => 'Most active students';

  @override
  String get dashEmpty =>
      'No activity yet — create an offer and students will show up here.';

  @override
  String dashApprovedCount(int n) {
    return '$n approved';
  }

  @override
  String get dashViewProof => 'View post';

  @override
  String get err_proof_not_allowed =>
      'This claim doesn\'t take a screenshot right now.';

  @override
  String get err_proof_type_not_accepted =>
      'Pick one of the posts this place asks for.';

  @override
  String get err_invalid_proof =>
      'Upload a JPEG, PNG or WebP screenshot (max 5 MB).';

  @override
  String get claimTitleTreat => 'Your treat';

  @override
  String get welcomeWho => 'Who are you?';

  @override
  String get welcomeStudentCta => 'I\'m a student';

  @override
  String get welcomeStudentHint =>
      'Claim free treats around campus, post about them.';

  @override
  String get welcomeShopCta => 'I run a business';

  @override
  String get welcomeShopHint =>
      'Give small treats, get real local reach from students.';

  @override
  String get welcomeHaveAccount => 'Already have an account?';

  @override
  String get authShopRegisterTitle => 'Business sign-up';

  @override
  String get authShopHint =>
      'Create your login first — next you\'ll add your business details.';

  @override
  String get dropsTitle => 'Live drops';

  @override
  String get dropsSubtitle => 'Last-minute treats — first come, first served.';

  @override
  String get dropBadge => 'DROP';

  @override
  String get dropLive => 'LIVE';

  @override
  String dropLeft(int n, int total) {
    return '$n of $total left';
  }

  @override
  String get dropSoldOut => 'All gone';

  @override
  String dropEndsIn(String time) {
    return 'ends in $time';
  }

  @override
  String get dropEnded => 'Ended';

  @override
  String dropClaimedOf(int n, int total) {
    return '$n of $total claimed';
  }

  @override
  String get dropRules =>
      'One per student. Pick it up within 30 minutes after the drop ends.';

  @override
  String dropClaimHint(String time) {
    return 'Pick it up by $time — after that your code stops working.';
  }

  @override
  String get lockShortPaused => 'Paused';

  @override
  String get lockShortVerify => 'Verify to claim';

  @override
  String get lockShortActive => 'Claim open';

  @override
  String get lockShortUsed => 'Already used';

  @override
  String lockShortOpens(String time) {
    return 'Opens $time';
  }

  @override
  String get lockDropEnded => 'This drop has ended.';

  @override
  String get lockAlreadyClaimed => 'You already got one from this drop.';

  @override
  String get shopDropsSection => 'Drops';

  @override
  String get shopRegularSection => 'Regular offers';

  @override
  String get shopStartDropCta => 'Got leftovers? Start a drop';

  @override
  String get shopStartDropHint =>
      'Surplus pastries, the last seats, an empty hour — students nearby see it live.';

  @override
  String get dropFormTitle => 'Start a drop';

  @override
  String get dropFormWhat => 'What\'s up for grabs?';

  @override
  String get dropFormWhatHint => 'e.g. 6 croissants from this morning';

  @override
  String get dropFormDesc => 'Details (optional)';

  @override
  String get dropFormQuantity => 'How many?';

  @override
  String get dropFormDuration => 'Open for';

  @override
  String dropFormMinutes(int n) {
    return '$n min';
  }

  @override
  String get dropFormStart => 'Start drop';

  @override
  String get shopDropEnd => 'End drop';

  @override
  String get shopDropEndConfirm =>
      'End this drop now? Students who already claimed can still pick up.';

  @override
  String get wallTitle => 'Posts from students';

  @override
  String get studentWallTitle => 'Posts';

  @override
  String get wallEmpty => 'No shared posts yet.';

  @override
  String get wallFreshTitle => 'Fresh on the wall';

  @override
  String placeTreated(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n students',
      one: '1 student',
    );
    return 'Treated $_temp0';
  }

  @override
  String get placeView => 'View place';

  @override
  String get placeOffers => 'Offers';

  @override
  String get placeNoOffers => 'No open offers right now.';

  @override
  String get studentProfileTitle => 'Student';

  @override
  String proofShareOnWall(String shop) {
    return 'Show my post on $shop\'s page';
  }

  @override
  String get proofShareHint =>
      'Only after approval. You can change this later.';

  @override
  String get thanksTitle => 'Say thanks';

  @override
  String thanksHint(String shop) {
    return 'A short note to $shop (optional)';
  }

  @override
  String get thanksSend => 'Send';

  @override
  String get thanksUpdate => 'Update';

  @override
  String get thanksSent => 'Thanks sent';

  @override
  String get thanksYourNote => 'Your note';

  @override
  String get err_invalid_quantity => 'Pick between 1 and 50.';

  @override
  String get err_invalid_duration => 'Pick between 10 and 180 minutes.';

  @override
  String get err_drop_not_editable =>
      'Drops can\'t be edited — end it and start a new one.';

  @override
  String get err_not_approved =>
      'You can thank the place after your post is approved.';

  @override
  String get err_note_too_long => 'Keep it under 280 characters.';

  @override
  String get err_demo_off => 'Demo sign-in is turned off on this server.';

  @override
  String get err_flag_window_over =>
      'Posts can only be reported within 48 hours of approval.';

  @override
  String get err_demo_locked =>
      'This demo account is shared by everyone trying the app, so parts of it are read-only. Create your own offer or start a drop — or try it as a one-tap guest.';

  @override
  String get err_demo_busy =>
      'Lots of people are trying the demo right now. Try again in a few minutes.';

  @override
  String get err_no_sample =>
      'There\'s no sample screenshot for this offer. Upload your own.';

  @override
  String get demoTitle => 'Judging? Try it in one tap';

  @override
  String get demoHint =>
      'Open the student here and the business in a second window — watch both update live.';

  @override
  String get demoStudent => 'Student';

  @override
  String get demoShop => 'Business';

  @override
  String get proofSampleTitle => 'Demo: no post handy?';

  @override
  String get proofSampleHint =>
      'Send a ready-made story screenshot. Claude checks it for real — try a failing one first, then appeal with the good one.';

  @override
  String proofSampleGood(String shop) {
    return 'Tags $shop + #işbirliği';
  }

  @override
  String get proofSampleUndisclosed => 'Tags the place, no #işbirliği';

  @override
  String get proofSampleBad => 'Tags nobody';

  @override
  String rateTitle(String shop) {
    return 'How was $shop?';
  }

  @override
  String get rateDone => 'Thanks for rating your visit';

  @override
  String get rateEdit => 'Edit';

  @override
  String get rateReviewHint =>
      'A few words for other students (optional, public)';

  @override
  String ratePrivateHint(String shop) {
    return 'A note only $shop sees (optional)';
  }

  @override
  String get rateDisclaimer =>
      'Be honest — your rating doesn\'t affect your treat. It shows on the place page as a verified visit with a free treat.';

  @override
  String get rateSave => 'Save rating';

  @override
  String get rateThanks => 'Rating saved';

  @override
  String get reviewVerified => 'Verified visit · free treat';

  @override
  String get reviewsTitle => 'What students say';

  @override
  String get reviewsEmpty =>
      'No ratings yet — students rate a place after it scans their code.';

  @override
  String reviewCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n verified ratings',
      one: '1 verified rating',
    );
    return '$_temp0';
  }

  @override
  String get dashRatingTitle => 'Your treat score';

  @override
  String get dashPrivateNote => 'Only you see this';

  @override
  String get err_invalid_rating => 'Pick 1 to 5 stars.';

  @override
  String get err_not_visited =>
      'You can rate the place after it scans your code.';

  @override
  String get repTitle => 'Reputation kit';

  @override
  String get repIntro =>
      'Turn treat visits into lasting reputation: a public page with your verified treat score, and a counter card that brings in Google reviews from all your customers.';

  @override
  String get repPageTitle => 'Your public page';

  @override
  String get repOpenPage => 'Open page';

  @override
  String get repCopyLink => 'Copy link';

  @override
  String get repLinkCopied => 'Link copied — put it in your Instagram bio';

  @override
  String get repCardTitle => 'Google review counter card';

  @override
  String get repCardHint =>
      'In Google Business Profile tap “Ask for reviews”, paste the link here and print the card. Anyone can scan it — it\'s never tied to a treat, which keeps it within Google\'s rules.';

  @override
  String get repGoogleLabel => 'Your Google review link';

  @override
  String get repPrintCard => 'Print card';

  @override
  String get err_invalid_google_link =>
      'Paste the review link from your Google Business Profile (it starts with https://g.page or https://search.google.com).';

  @override
  String get err_proof_type_not_offered =>
      'Pick Instagram or TikTok posts — treat never asks for Google reviews, because Google forbids rewarding them. Use the counter card from your Business tab instead.';

  @override
  String get proofLinkLabel => 'Link to your post';

  @override
  String get proofLinkHelp =>
      'Feed posts, Reels and TikToks stay online — the place can open yours. Keep it up: TikToks are checked again after a week.';

  @override
  String get dashOpenPost => 'Open the post';

  @override
  String get rejectPostRemoved =>
      'Your TikTok was no longer online a week after approval, so the treat was taken back. Keep permanent posts up.';

  @override
  String get err_post_link_required =>
      'Paste the link to your post so the place can see it.';

  @override
  String get err_invalid_post_link =>
      'Use the share link of your Instagram post/Reel or TikTok (it starts with https://).';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsProfile => 'Your profile';

  @override
  String get settingsGuestUniversity =>
      'Demo guests stay at Demo University — sign up to use your own.';

  @override
  String get settingsLegal => 'Privacy & terms';

  @override
  String get settingsPrivacy => 'Privacy notice';

  @override
  String get settingsTerms => 'Terms of use';

  @override
  String get settingsAccount => 'Account';

  @override
  String settingsSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountTitle => 'Delete your account?';

  @override
  String get deleteAccountStudent =>
      'Your profile, treats, ratings, reviews, notes and post screenshots are deleted right away. This can\'t be undone.';

  @override
  String get deleteAccountShop =>
      'Your place, its offers, the claims made there and their screenshots are deleted right away. This can\'t be undone.';

  @override
  String get deleteAccountConfirm => 'I understand this can\'t be undone';

  @override
  String get deleteAccountGo => 'Delete forever';

  @override
  String get deleteAccountDone => 'Your account was deleted';

  @override
  String get report => 'Report';

  @override
  String get reportTitleReview => 'Report this review';

  @override
  String get reportTitlePost => 'Report this post';

  @override
  String get reportTitleShop => 'Report this place';

  @override
  String get reportSpam => 'Spam or advertising';

  @override
  String get reportOffensive => 'Offensive or hateful';

  @override
  String get reportFake => 'Fake or misleading';

  @override
  String get reportPrivacy => 'Shows someone without consent';

  @override
  String get reportOther => 'Something else';

  @override
  String get reportSend => 'Send report';

  @override
  String get reportThanks =>
      'Thanks — content reported by several people is hidden, and we look at every report.';

  @override
  String get err_own_content => 'You can\'t report your own page.';

  @override
  String get err_guest_university =>
      'Demo guests stay at Demo University. Sign up to use your own.';

  @override
  String get err_invalid_name => 'Enter a name (up to 60 characters).';

  @override
  String get err_invalid_university =>
      'Enter your university (up to 80 characters).';

  @override
  String get verifyStudentTitle => 'Verify you\'re a student';

  @override
  String get verifyShopTitle => 'Get the verified badge';

  @override
  String get verifyStudentIntro =>
      'Take a photo of the front of your student ID card (or your university\'s digital student card). Claude checks it in about a minute.';

  @override
  String get verifyShopIntro =>
      'Take a photo of an official document of your business: tax certificate (vergi levhası), workplace licence, or trade registry record. Claude checks it in about a minute, and your place gets the verified badge students see.';

  @override
  String get verifyMustMatch => 'It must match your profile';

  @override
  String get verifyStudentMatchHint =>
      'Name and university as on the card — fix them in Settings first if needed.';

  @override
  String get verifyShopMatchHint =>
      'The legal trade name may differ from your sign; then the address must match.';

  @override
  String get verifyTakePhoto => 'Take photo';

  @override
  String get verifyChoosePhoto => 'Choose photo';

  @override
  String get verifySend => 'Send for checking';

  @override
  String get verifyChecking =>
      'Checking your photo… you can leave this page, we\'ll keep going.';

  @override
  String get verifyPrivacy =>
      'The photo is stored privately, seen only by the AI, and deleted as soon as it has decided. We keep only the result.';

  @override
  String get verifyStudentDone =>
      'You\'re a verified student — go claim your first treat!';

  @override
  String get verifyShopDone =>
      'Your place is verified: students see the badge on your page and offers.';

  @override
  String get verifyFailed =>
      'We couldn\'t check the photo just now. Please send it again.';

  @override
  String get verifyNotAStudentCard =>
      'That doesn\'t look like a student ID card. Photograph the front of your university card.';

  @override
  String get verifyNotABusinessDocument =>
      'That doesn\'t look like an official business document. Use your tax certificate, licence or registry record.';

  @override
  String get verifyNameMismatch =>
      'The name on the document doesn\'t match your profile. Check your name in Settings, or use your own document.';

  @override
  String get verifySchoolMismatch =>
      'The university on the card doesn\'t match your profile. Fix it in Settings and send again.';

  @override
  String get verifyExpired =>
      'This card has expired. Use your current card or the digital card from your university.';

  @override
  String get verifyUnreadable =>
      'We couldn\'t read the photo. Take it in good light, flat and sharp, with the whole document visible.';

  @override
  String get verifyCta => 'Verify with your student card';

  @override
  String get verifyShopCta => 'Get verified';

  @override
  String get verifyShopBanner =>
      'Verified places get a badge on their page and offers. Send a photo of your tax certificate or licence.';

  @override
  String get verifiedBusiness => 'Verified business';

  @override
  String get err_already_verified => 'You\'re already verified.';

  @override
  String get err_check_pending => 'Your last photo is still being checked.';

  @override
  String get err_too_many_checks =>
      'That was 3 tries today — try again tomorrow.';

  @override
  String get err_no_role => 'Finish setting up your account first.';

  @override
  String get navGifts => 'Gifts';

  @override
  String get giftsTitle => 'Gifts';

  @override
  String get giftsIntro =>
      'Pay for a treat at a verified place and give it to a friend. They show a QR at the counter; the place gets 85 %.';

  @override
  String get giftsReceived => 'Received';

  @override
  String get giftsSent => 'Sent';

  @override
  String get giftsSend => 'Send a gift';

  @override
  String get giftsEmptyReceived =>
      'No gifts yet. A friend can gift you a treat with the e-mail you signed up with.';

  @override
  String get giftsEmptySent => 'You haven\'t sent a gift yet.';

  @override
  String get giftsOff =>
      'Gifts need payments, which aren\'t set up on this server.';

  @override
  String get giftStatusAwaitingPayment => 'Waiting for payment';

  @override
  String get giftStatusPending => 'Ready to collect';

  @override
  String get giftStatusRedeemed => 'Collected';

  @override
  String get giftStatusCancelled => 'Cancelled';

  @override
  String get giftStatusExpired => 'Expired';

  @override
  String get giftStatusFailed => 'Payment failed';

  @override
  String giftFrom(String name) {
    return 'From $name';
  }

  @override
  String giftTo(String name) {
    return 'To $name';
  }

  @override
  String get giftSendTitle => 'Send a gift';

  @override
  String get giftPlace => 'Place';

  @override
  String get giftNoPlaces =>
      'No verified places yet — gifts go to places that passed the document check.';

  @override
  String get giftAmountLabel => 'Amount (TL)';

  @override
  String get giftAmountHelp => '20 to 1000 TL';

  @override
  String get giftRecipient => 'Friend\'s e-mail';

  @override
  String get giftRecipientHelp => 'The e-mail they signed up to treat with';

  @override
  String giftToName(String name) {
    return 'Gift to $name';
  }

  @override
  String get giftMessage => 'Message (optional)';

  @override
  String giftSplit(String place, String net, String commission) {
    return '$place gets $net TL · treat keeps $commission TL (15 %)';
  }

  @override
  String giftPay(int n) {
    return 'Pay $n TL';
  }

  @override
  String get giftSecure =>
      'You pay by card on iyzico\'s secure page — treat never sees your card.';

  @override
  String get giftSandboxHint =>
      'Test mode: use card 5528 7900 0000 0008, any future date, CVC 123, SMS code 283126. No real money moves.';

  @override
  String get giftDetailTitle => 'Gift';

  @override
  String get giftConfirming => 'Confirming your payment…';

  @override
  String get giftPaidOk => 'Payment received — your friend can collect it now.';

  @override
  String get giftPayFailed =>
      'The payment didn\'t go through, so nothing was charged.';

  @override
  String get giftPayUnknown =>
      'iyzico hasn\'t confirmed yet. Pull down to check again in a minute.';

  @override
  String giftShowQr(String place) {
    return 'Show this at $place';
  }

  @override
  String giftValidUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String get giftCancel => 'Cancel gift';

  @override
  String get giftCancelTitle => 'Cancel this gift?';

  @override
  String get giftCancelBody =>
      'You get a full refund and your friend can no longer collect it.';

  @override
  String get giftCancelDone => 'Gift cancelled';

  @override
  String get giftRefundPending => 'Your refund is on its way.';

  @override
  String get giftRefunded => 'Refunded to your card.';

  @override
  String giftRedeemedNote(String place) {
    return 'Collected at $place.';
  }

  @override
  String get giftReceivedNote =>
      'Collecting it counts as a treat on your profile.';

  @override
  String giftWaitingNote(String name, String place, String date) {
    return '$name can collect it at $place until $date.';
  }

  @override
  String get giftCta => 'Gift a treat';

  @override
  String get giftYourAddress => 'Friends can gift you with this e-mail';

  @override
  String get scanGiftSuccess => 'Gift handed over';

  @override
  String scanGiftFor(String name, int n) {
    return 'Gift for $name · $n TL';
  }

  @override
  String get dashGiftsTitle => 'Gifts';

  @override
  String get dashGiftsCollected => 'Collected';

  @override
  String get dashGiftsWaiting => 'Waiting';

  @override
  String dashGiftsNet(String n) {
    return '$n TL for you after treat\'s 15 %';
  }

  @override
  String dashGiftsWaitingNet(String n) {
    return '$n TL paid in, not collected yet';
  }

  @override
  String get dashGiftsHint =>
      'Gift payments are collected by treat; paying them out to places is not automated in this build.';

  @override
  String get err_gift_to_self => 'You can\'t gift yourself — pick a friend.';

  @override
  String get err_recipient_not_found => 'No student on treat has that e-mail.';

  @override
  String get err_recipient_not_verified =>
      'Only verified students can receive gifts.';

  @override
  String get err_invalid_recipient => 'Enter your friend\'s e-mail.';

  @override
  String get err_shop_not_giftable => 'Gifts go to verified places only.';

  @override
  String get err_invalid_amount => 'Gifts are 20 to 1000 TL.';

  @override
  String get err_daily_gift_cap =>
      'That\'s 10 gifts today — try again tomorrow.';

  @override
  String get err_payment_unavailable =>
      'The payment page isn\'t available right now. Try again in a moment.';

  @override
  String get err_payments_unavailable =>
      'Payments aren\'t set up on this server.';

  @override
  String get err_gift_redeemed => 'The place already handed this gift over.';

  @override
  String get err_gift_closed => 'This gift is no longer valid.';

  @override
  String get err_not_verified => 'Verify your student status first.';

  @override
  String get demoUnverified => 'Try the student-card check';

  @override
  String get demoUnverifiedHint => 'A student who isn\'t verified yet';

  @override
  String get verifySampleTitle => 'Demo: no card at hand?';

  @override
  String get verifySampleMatching => 'Use the sample card';

  @override
  String get verifySampleOther => 'Use someone else\'s card';

  @override
  String get verifySampleHint =>
      'Ready-made card photos. The real AI checks them like any upload — the second one shows a rejection.';

  @override
  String get err_demo_only => 'Samples are only for demo students.';
}
