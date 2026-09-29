/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/claim_proof.dart' as _islgq58o;
import 'package:treat_client/src/protocol/claim_view.dart' as _iq1pcdgl;
import 'package:treat_client/src/protocol/drop_input.dart' as _id0be9cq;
import 'package:treat_client/src/protocol/leaderboard_entry.dart' as _inztnej7;
import 'package:treat_client/src/protocol/me.dart' as _iap2bcnj;
import 'package:treat_client/src/protocol/offer.dart' as _ibnzpjkx;
import 'package:treat_client/src/protocol/offer_card.dart' as _i1fp4eeg;
import 'package:treat_client/src/protocol/offer_input.dart' as _i8mx2n74;
import 'package:treat_client/src/protocol/offer_status.dart' as _ipcd8cwl;
import 'package:treat_client/src/protocol/proof_type.dart' as _i99q6qgz;
import 'package:treat_client/src/protocol/proof_upload.dart' as _iu72foho;
import 'package:treat_client/src/protocol/public_student.dart' as _ihfjemru;
import 'package:treat_client/src/protocol/redeem_result.dart' as _i8ej1owz;
import 'package:treat_client/src/protocol/sample_proof.dart' as _ij1gidu7;
import 'package:treat_client/src/protocol/shop.dart' as _ij1m347g;
import 'package:treat_client/src/protocol/shop_dashboard.dart' as _iqqmplla;
import 'package:treat_client/src/protocol/shop_input.dart' as _inznu32h;
import 'package:treat_client/src/protocol/shop_page.dart' as _izsk3a1k;
import 'package:treat_client/src/protocol/wall_post.dart' as _ie03ixnw;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// A student's claims: create, list, open, and watch one live.
/// {@category Endpoint}
class EndpointClaim extends _isc.EndpointRef {
  EndpointClaim(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'claim';

  _ida.Future<_iq1pcdgl.ClaimView> create(int offerId) =>
      caller.callServerEndpoint<_iq1pcdgl.ClaimView>(
        'claim',
        'create',
        {'offerId': offerId},
      );

  /// Where to upload the proof screenshot for [claimId].
  _ida.Future<_iu72foho.ProofUpload> proofUpload(int claimId) =>
      caller.callServerEndpoint<_iu72foho.ProofUpload>(
        'claim',
        'proofUpload',
        {'claimId': claimId},
      );

  /// Submits the uploaded screenshot (first proof, or the one appeal after a
  /// rejection). Verification runs in the background; watch the claim.
  _ida.Future<_iq1pcdgl.ClaimView> submitProof(
    int claimId,
    _i99q6qgz.ProofType proofType,
    String path, {
    bool? shareOnWall,
  }) => caller.callServerEndpoint<_iq1pcdgl.ClaimView>(
    'claim',
    'submitProof',
    {
      'claimId': claimId,
      'proofType': proofType,
      'path': path,
      'shareOnWall': shareOnWall,
    },
  );

  /// Demo accounts only: submits a ready-made story screenshot ([kind])
  /// through the same verification. Never shared on a wall — it isn't the
  /// student's own post.
  _ida.Future<_iq1pcdgl.ClaimView> submitSampleProof(
    int claimId,
    _ij1gidu7.SampleProof kind,
  ) => caller.callServerEndpoint<_iq1pcdgl.ClaimView>(
    'claim',
    'submitSampleProof',
    {
      'claimId': claimId,
      'kind': kind,
    },
  );

  /// After approval: a short thank-you note to the place (shown on its page
  /// and in its panel) and whether the post may appear on its public wall.
  _ida.Future<_iq1pcdgl.ClaimView> thank(
    int claimId,
    String? note,
    bool shareOnWall,
  ) => caller.callServerEndpoint<_iq1pcdgl.ClaimView>(
    'claim',
    'thank',
    {
      'claimId': claimId,
      'note': note,
      'shareOnWall': shareOnWall,
    },
  );

  /// Newest first.
  _ida.Future<List<_iq1pcdgl.ClaimView>> listMine() =>
      caller.callServerEndpoint<List<_iq1pcdgl.ClaimView>>(
        'claim',
        'listMine',
        {},
      );

  _ida.Future<_iq1pcdgl.ClaimView> get(int claimId) =>
      caller.callServerEndpoint<_iq1pcdgl.ClaimView>(
        'claim',
        'get',
        {'claimId': claimId},
      );

  /// Current state first, then every change (redeemed, expired, …).
  _ida.Stream<_iq1pcdgl.ClaimView> watch(int claimId) =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iq1pcdgl.ClaimView>,
        _iq1pcdgl.ClaimView
      >(
        'claim',
        'watch',
        {'claimId': claimId},
        {},
      );
}

/// One-tap demo sign-in for judges. Only works when the server runs in demo
/// mode (`demoAccountPassword` is set), so a real deployment can switch it off.
///
/// Every "try as a student" gets a fresh guest student: a shared account would
/// let one judge's claim (once a week per place) or strikes block the next.
/// The business side signs into the shared demo shop, which can serve many
/// students at once.
/// {@category Endpoint}
class EndpointDemo extends _isc.EndpointRef {
  EndpointDemo(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'demo';

  _ida.Future<bool> enabled() => caller.callServerEndpoint<bool>(
    'demo',
    'enabled',
    {},
  );

  _ida.Future<_iacc.AuthSuccess> signInAsGuestStudent() =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'demo',
        'signInAsGuestStudent',
        {},
      );

  _ida.Future<_iacc.AuthSuccess> signInAsDemoShop() =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'demo',
        'signInAsDemoShop',
        {},
      );
}

/// Top students by approved treats. Name + university only, never email.
/// {@category Endpoint}
class EndpointLeaderboard extends _isc.EndpointRef {
  EndpointLeaderboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'leaderboard';

  _ida.Future<List<_inztnej7.LeaderboardEntry>> top() =>
      caller.callServerEndpoint<List<_inztnej7.LeaderboardEntry>>(
        'leaderboard',
        'top',
        {},
      );
}

/// Browsing offers (Discover + offer detail). Students also get their
/// eligibility for each offer, computed on the server.
/// {@category Endpoint}
class EndpointOffer extends _isc.EndpointRef {
  EndpointOffer(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'offer';

  /// Regular (standing) offers. Drops come from [watchDrops].
  _ida.Future<List<_i1fp4eeg.OfferCard>> listActive() =>
      caller.callServerEndpoint<List<_i1fp4eeg.OfferCard>>(
        'offer',
        'listActive',
        {},
      );

  _ida.Future<_i1fp4eeg.OfferCard> get(int offerId) =>
      caller.callServerEndpoint<_i1fp4eeg.OfferCard>(
        'offer',
        'get',
        {'offerId': offerId},
      );

  /// Live drops, soonest-ending first: the current list, then a new list
  /// whenever one starts, ends, or its stock changes.
  _ida.Stream<List<_i1fp4eeg.OfferCard>> watchDrops() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<List<_i1fp4eeg.OfferCard>>,
        List<_i1fp4eeg.OfferCard>
      >(
        'offer',
        'watchDrops',
        {},
        {},
      );
}

/// The signed-in user's own profile and onboarding (role choice).
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  _ida.Future<_iap2bcnj.Me> getMe() => caller.callServerEndpoint<_iap2bcnj.Me>(
    'profile',
    'getMe',
    {},
  );

  _ida.Future<_iap2bcnj.Me> createStudent(
    String name,
    String university,
  ) => caller.callServerEndpoint<_iap2bcnj.Me>(
    'profile',
    'createStudent',
    {
      'name': name,
      'university': university,
    },
  );

  _ida.Future<_iap2bcnj.Me> createShop(_inznu32h.ShopInput input) =>
      caller.callServerEndpoint<_iap2bcnj.Me>(
        'profile',
        'createShop',
        {'input': input},
      );

  _ida.Future<_ij1m347g.Shop> updateShop(_inznu32h.ShopInput input) =>
      caller.callServerEndpoint<_ij1m347g.Shop>(
        'profile',
        'updateShop',
        {'input': input},
      );
}

/// Business-side actions at the counter and the live panel.
/// {@category Endpoint}
class EndpointShop extends _isc.EndpointRef {
  EndpointShop(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shop';

  /// [input]: the scanned QR payload or the 6-character code.
  _ida.Future<_i8ej1owz.RedeemResult> redeem(String input) =>
      caller.callServerEndpoint<_i8ej1owz.RedeemResult>(
        'shop',
        'redeem',
        {'input': input},
      );

  _ida.Future<_iqqmplla.ShopDashboard> dashboard() =>
      caller.callServerEndpoint<_iqqmplla.ShopDashboard>(
        'shop',
        'dashboard',
        {},
      );

  /// Every change to this shop's claims (new claim, redeem, proof, verdict),
  /// as it happens.
  _ida.Stream<_iq1pcdgl.ClaimView> watchFeed() =>
      caller.callStreamingServerEndpoint<
        _ida.Stream<_iq1pcdgl.ClaimView>,
        _iq1pcdgl.ClaimView
      >(
        'shop',
        'watchFeed',
        {},
        {},
      );

  /// Short-lived link to a claim's proof screenshot, for this shop only.
  _ida.Future<_islgq58o.ProofLink> proofLink(int claimId) =>
      caller.callServerEndpoint<_islgq58o.ProofLink>(
        'shop',
        'proofLink',
        {'claimId': claimId},
      );
}

/// A business managing its own offers.
/// {@category Endpoint}
class EndpointShopOffers extends _isc.EndpointRef {
  EndpointShopOffers(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shopOffers';

  /// All non-ended offers, newest first, with usage.
  _ida.Future<List<_i1fp4eeg.OfferCard>> listMine() =>
      caller.callServerEndpoint<List<_i1fp4eeg.OfferCard>>(
        'shopOffers',
        'listMine',
        {},
      );

  _ida.Future<_ibnzpjkx.Offer> create(_i8mx2n74.OfferInput input) =>
      caller.callServerEndpoint<_ibnzpjkx.Offer>(
        'shopOffers',
        'create',
        {'input': input},
      );

  /// Starts a drop: a short, stock-limited offer everyone sees live.
  _ida.Future<_ibnzpjkx.Offer> startDrop(_id0be9cq.DropInput input) =>
      caller.callServerEndpoint<_ibnzpjkx.Offer>(
        'shopOffers',
        'startDrop',
        {'input': input},
      );

  _ida.Future<_ibnzpjkx.Offer> update(
    int offerId,
    _i8mx2n74.OfferInput input,
  ) => caller.callServerEndpoint<_ibnzpjkx.Offer>(
    'shopOffers',
    'update',
    {
      'offerId': offerId,
      'input': input,
    },
  );

  /// active ⇄ paused, or ended (= deleted from the shop's point of view;
  /// the row stays because claims reference it).
  _ida.Future<_ibnzpjkx.Offer> setStatus(
    int offerId,
    _ipcd8cwl.OfferStatus status,
  ) => caller.callServerEndpoint<_ibnzpjkx.Offer>(
    'shopOffers',
    'setStatus',
    {
      'offerId': offerId,
      'status': status,
    },
  );
}

/// Public pages: a place's page with its wall, a student's profile, and the
/// latest shared posts. Never exposes emails or strikes.
/// {@category Endpoint}
class EndpointSocial extends _isc.EndpointRef {
  EndpointSocial(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'social';

  _ida.Future<_izsk3a1k.ShopPage> shopPage(int shopId) =>
      caller.callServerEndpoint<_izsk3a1k.ShopPage>(
        'social',
        'shopPage',
        {'shopId': shopId},
      );

  _ida.Future<_ihfjemru.PublicStudent> student(int studentId) =>
      caller.callServerEndpoint<_ihfjemru.PublicStudent>(
        'social',
        'student',
        {'studentId': studentId},
      );

  /// Latest shared posts across all places (Discover strip).
  _ida.Future<List<_ie03ixnw.WallPost>> recentPosts() =>
      caller.callServerEndpoint<List<_ie03ixnw.WallPost>>(
        'social',
        'recentPosts',
        {},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    claim = EndpointClaim(this);
    demo = EndpointDemo(this);
    leaderboard = EndpointLeaderboard(this);
    offer = EndpointOffer(this);
    profile = EndpointProfile(this);
    shop = EndpointShop(this);
    shopOffers = EndpointShopOffers(this);
    social = EndpointSocial(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointClaim claim;

  late final EndpointDemo demo;

  late final EndpointLeaderboard leaderboard;

  late final EndpointOffer offer;

  late final EndpointProfile profile;

  late final EndpointShop shop;

  late final EndpointShopOffers shopOffers;

  late final EndpointSocial social;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'claim': claim,
    'demo': demo,
    'leaderboard': leaderboard,
    'offer': offer,
    'profile': profile,
    'shop': shop,
    'shopOffers': shopOffers,
    'social': social,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
