/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/claim_view.dart' as _iq1pcdgl;
import 'package:treat_client/src/protocol/leaderboard_entry.dart' as _inztnej7;
import 'package:treat_client/src/protocol/offer_card.dart' as _i1fp4eeg;
import 'package:treat_client/src/protocol/wall_post.dart' as _ie03ixnw;
import 'badge_id.dart' as _i14xwlyb;
import 'claim.dart' as _iywv5oz4;
import 'claim_proof.dart' as _iiz71frh;
import 'claim_status.dart' as _i4cqplnc;
import 'claim_view.dart' as _i48lh927;
import 'drop_input.dart' as _ippz03u2;
import 'drop_signal.dart' as _i1c14r0n;
import 'eligibility.dart' as _iapxm79h;
import 'eligibility_reason.dart' as _ixt5yy28;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'me.dart' as _i22ljs0z;
import 'offer.dart' as _iqlmmtnc;
import 'offer_card.dart' as _irfq3mof;
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_input.dart' as _in0575rn;
import 'offer_kind.dart' as _ijq1l2tf;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'proof_upload.dart' as _idi75cqx;
import 'public_student.dart' as _i377gh4k;
import 'redeem_result.dart' as _iggnnz44;
import 'review.dart' as _itqm5y01;
import 'sample_proof.dart' as _iyeld2s2;
import 'shop.dart' as _isgf2ncs;
import 'shop_dashboard.dart' as _iqgdamt7;
import 'shop_input.dart' as _i5vfstp6;
import 'shop_page.dart' as _iv7ebkk1;
import 'shop_rating.dart' as _i7zra0pp;
import 'student_profile.dart' as _iovtxv26;
import 'student_verification.dart' as _ipqqbskf;
import 'top_student.dart' as _iub4wqas;
import 'treat_exception.dart' as _iawcmjml;
import 'user_role.dart' as _ir0y0iu6;
import 'wall_post.dart' as _i6mr85kx;
export 'badge_id.dart';
export 'claim.dart';
export 'claim_proof.dart';
export 'claim_status.dart';
export 'claim_view.dart';
export 'drop_input.dart';
export 'drop_signal.dart';
export 'eligibility.dart';
export 'eligibility_reason.dart';
export 'leaderboard_entry.dart';
export 'me.dart';
export 'offer.dart';
export 'offer_card.dart';
export 'offer_category.dart';
export 'offer_frequency.dart';
export 'offer_input.dart';
export 'offer_kind.dart';
export 'offer_status.dart';
export 'proof_type.dart';
export 'proof_upload.dart';
export 'public_student.dart';
export 'redeem_result.dart';
export 'review.dart';
export 'sample_proof.dart';
export 'shop.dart';
export 'shop_dashboard.dart';
export 'shop_input.dart';
export 'shop_page.dart';
export 'shop_rating.dart';
export 'student_profile.dart';
export 'student_verification.dart';
export 'top_student.dart';
export 'treat_exception.dart';
export 'user_role.dart';
export 'wall_post.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i14xwlyb.BadgeId) {
      return _i14xwlyb.BadgeId.fromJson(data) as T;
    }
    if (t == _iywv5oz4.Claim) {
      return _iywv5oz4.Claim.fromJson(data) as T;
    }
    if (t == _iiz71frh.ProofLink) {
      return _iiz71frh.ProofLink.fromJson(data) as T;
    }
    if (t == _i4cqplnc.ClaimStatus) {
      return _i4cqplnc.ClaimStatus.fromJson(data) as T;
    }
    if (t == _i48lh927.ClaimView) {
      return _i48lh927.ClaimView.fromJson(data) as T;
    }
    if (t == _ippz03u2.DropInput) {
      return _ippz03u2.DropInput.fromJson(data) as T;
    }
    if (t == _i1c14r0n.DropSignal) {
      return _i1c14r0n.DropSignal.fromJson(data) as T;
    }
    if (t == _iapxm79h.Eligibility) {
      return _iapxm79h.Eligibility.fromJson(data) as T;
    }
    if (t == _ixt5yy28.EligibilityReason) {
      return _ixt5yy28.EligibilityReason.fromJson(data) as T;
    }
    if (t == _ikawkn1p.LeaderboardEntry) {
      return _ikawkn1p.LeaderboardEntry.fromJson(data) as T;
    }
    if (t == _i22ljs0z.Me) {
      return _i22ljs0z.Me.fromJson(data) as T;
    }
    if (t == _iqlmmtnc.Offer) {
      return _iqlmmtnc.Offer.fromJson(data) as T;
    }
    if (t == _irfq3mof.OfferCard) {
      return _irfq3mof.OfferCard.fromJson(data) as T;
    }
    if (t == _iqmyfspq.OfferCategory) {
      return _iqmyfspq.OfferCategory.fromJson(data) as T;
    }
    if (t == _ix7dcs2a.OfferFrequency) {
      return _ix7dcs2a.OfferFrequency.fromJson(data) as T;
    }
    if (t == _in0575rn.OfferInput) {
      return _in0575rn.OfferInput.fromJson(data) as T;
    }
    if (t == _ijq1l2tf.OfferKind) {
      return _ijq1l2tf.OfferKind.fromJson(data) as T;
    }
    if (t == _i40dfi1m.OfferStatus) {
      return _i40dfi1m.OfferStatus.fromJson(data) as T;
    }
    if (t == _i671eu65.ProofType) {
      return _i671eu65.ProofType.fromJson(data) as T;
    }
    if (t == _idi75cqx.ProofUpload) {
      return _idi75cqx.ProofUpload.fromJson(data) as T;
    }
    if (t == _i377gh4k.PublicStudent) {
      return _i377gh4k.PublicStudent.fromJson(data) as T;
    }
    if (t == _iggnnz44.RedeemResult) {
      return _iggnnz44.RedeemResult.fromJson(data) as T;
    }
    if (t == _itqm5y01.Review) {
      return _itqm5y01.Review.fromJson(data) as T;
    }
    if (t == _iyeld2s2.SampleProof) {
      return _iyeld2s2.SampleProof.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _iqgdamt7.ShopDashboard) {
      return _iqgdamt7.ShopDashboard.fromJson(data) as T;
    }
    if (t == _i5vfstp6.ShopInput) {
      return _i5vfstp6.ShopInput.fromJson(data) as T;
    }
    if (t == _iv7ebkk1.ShopPage) {
      return _iv7ebkk1.ShopPage.fromJson(data) as T;
    }
    if (t == _i7zra0pp.ShopRating) {
      return _i7zra0pp.ShopRating.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _ipqqbskf.StudentVerification) {
      return _ipqqbskf.StudentVerification.fromJson(data) as T;
    }
    if (t == _iub4wqas.TopStudent) {
      return _iub4wqas.TopStudent.fromJson(data) as T;
    }
    if (t == _iawcmjml.TreatException) {
      return _iawcmjml.TreatException.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _i6mr85kx.WallPost) {
      return _i6mr85kx.WallPost.fromJson(data) as T;
    }
    if (t == _isc.getType<_i14xwlyb.BadgeId?>()) {
      return (data != null ? _i14xwlyb.BadgeId.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iywv5oz4.Claim?>()) {
      return (data != null ? _iywv5oz4.Claim.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iiz71frh.ProofLink?>()) {
      return (data != null ? _iiz71frh.ProofLink.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4cqplnc.ClaimStatus?>()) {
      return (data != null ? _i4cqplnc.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i48lh927.ClaimView?>()) {
      return (data != null ? _i48lh927.ClaimView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ippz03u2.DropInput?>()) {
      return (data != null ? _ippz03u2.DropInput.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1c14r0n.DropSignal?>()) {
      return (data != null ? _i1c14r0n.DropSignal.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iapxm79h.Eligibility?>()) {
      return (data != null ? _iapxm79h.Eligibility.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixt5yy28.EligibilityReason?>()) {
      return (data != null ? _ixt5yy28.EligibilityReason.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i22ljs0z.Me?>()) {
      return (data != null ? _i22ljs0z.Me.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqlmmtnc.Offer?>()) {
      return (data != null ? _iqlmmtnc.Offer.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irfq3mof.OfferCard?>()) {
      return (data != null ? _irfq3mof.OfferCard.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqmyfspq.OfferCategory?>()) {
      return (data != null ? _iqmyfspq.OfferCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ix7dcs2a.OfferFrequency?>()) {
      return (data != null ? _ix7dcs2a.OfferFrequency.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_in0575rn.OfferInput?>()) {
      return (data != null ? _in0575rn.OfferInput.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijq1l2tf.OfferKind?>()) {
      return (data != null ? _ijq1l2tf.OfferKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i40dfi1m.OfferStatus?>()) {
      return (data != null ? _i40dfi1m.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i671eu65.ProofType?>()) {
      return (data != null ? _i671eu65.ProofType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idi75cqx.ProofUpload?>()) {
      return (data != null ? _idi75cqx.ProofUpload.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i377gh4k.PublicStudent?>()) {
      return (data != null ? _i377gh4k.PublicStudent.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iggnnz44.RedeemResult?>()) {
      return (data != null ? _iggnnz44.RedeemResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itqm5y01.Review?>()) {
      return (data != null ? _itqm5y01.Review.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iyeld2s2.SampleProof?>()) {
      return (data != null ? _iyeld2s2.SampleProof.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqgdamt7.ShopDashboard?>()) {
      return (data != null ? _iqgdamt7.ShopDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5vfstp6.ShopInput?>()) {
      return (data != null ? _i5vfstp6.ShopInput.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iv7ebkk1.ShopPage?>()) {
      return (data != null ? _iv7ebkk1.ShopPage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7zra0pp.ShopRating?>()) {
      return (data != null ? _i7zra0pp.ShopRating.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipqqbskf.StudentVerification?>()) {
      return (data != null
              ? _ipqqbskf.StudentVerification.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iub4wqas.TopStudent?>()) {
      return (data != null ? _iub4wqas.TopStudent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iawcmjml.TreatException?>()) {
      return (data != null ? _iawcmjml.TreatException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6mr85kx.WallPost?>()) {
      return (data != null ? _i6mr85kx.WallPost.fromJson(data) : null) as T;
    }
    if (t == List<_i671eu65.ProofType>) {
      return (data as List)
              .map((e) => deserialize<_i671eu65.ProofType>(e))
              .toList()
          as T;
    }
    if (t == List<_i14xwlyb.BadgeId>) {
      return (data as List)
              .map((e) => deserialize<_i14xwlyb.BadgeId>(e))
              .toList()
          as T;
    }
    if (t == List<_i6mr85kx.WallPost>) {
      return (data as List)
              .map((e) => deserialize<_i6mr85kx.WallPost>(e))
              .toList()
          as T;
    }
    if (t == List<_i48lh927.ClaimView>) {
      return (data as List)
              .map((e) => deserialize<_i48lh927.ClaimView>(e))
              .toList()
          as T;
    }
    if (t == List<_iub4wqas.TopStudent>) {
      return (data as List)
              .map((e) => deserialize<_iub4wqas.TopStudent>(e))
              .toList()
          as T;
    }
    if (t == List<_itqm5y01.Review>) {
      return (data as List)
              .map((e) => deserialize<_itqm5y01.Review>(e))
              .toList()
          as T;
    }
    if (t == List<_irfq3mof.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_irfq3mof.OfferCard>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_iqmyfspq.OfferCategory>) {
      return (data as List)
              .map((e) => deserialize<_iqmyfspq.OfferCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_iq1pcdgl.ClaimView>) {
      return (data as List)
              .map((e) => deserialize<_iq1pcdgl.ClaimView>(e))
              .toList()
          as T;
    }
    if (t == List<_inztnej7.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_inztnej7.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i1fp4eeg.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_i1fp4eeg.OfferCard>(e))
              .toList()
          as T;
    }
    if (t == List<_ie03ixnw.WallPost>) {
      return (data as List)
              .map((e) => deserialize<_ie03ixnw.WallPost>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i14xwlyb.BadgeId => 'BadgeId',
      _iywv5oz4.Claim => 'Claim',
      _iiz71frh.ProofLink => 'ProofLink',
      _i4cqplnc.ClaimStatus => 'ClaimStatus',
      _i48lh927.ClaimView => 'ClaimView',
      _ippz03u2.DropInput => 'DropInput',
      _i1c14r0n.DropSignal => 'DropSignal',
      _iapxm79h.Eligibility => 'Eligibility',
      _ixt5yy28.EligibilityReason => 'EligibilityReason',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _i22ljs0z.Me => 'Me',
      _iqlmmtnc.Offer => 'Offer',
      _irfq3mof.OfferCard => 'OfferCard',
      _iqmyfspq.OfferCategory => 'OfferCategory',
      _ix7dcs2a.OfferFrequency => 'OfferFrequency',
      _in0575rn.OfferInput => 'OfferInput',
      _ijq1l2tf.OfferKind => 'OfferKind',
      _i40dfi1m.OfferStatus => 'OfferStatus',
      _i671eu65.ProofType => 'ProofType',
      _idi75cqx.ProofUpload => 'ProofUpload',
      _i377gh4k.PublicStudent => 'PublicStudent',
      _iggnnz44.RedeemResult => 'RedeemResult',
      _itqm5y01.Review => 'Review',
      _iyeld2s2.SampleProof => 'SampleProof',
      _isgf2ncs.Shop => 'Shop',
      _iqgdamt7.ShopDashboard => 'ShopDashboard',
      _i5vfstp6.ShopInput => 'ShopInput',
      _iv7ebkk1.ShopPage => 'ShopPage',
      _i7zra0pp.ShopRating => 'ShopRating',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _ipqqbskf.StudentVerification => 'StudentVerification',
      _iub4wqas.TopStudent => 'TopStudent',
      _iawcmjml.TreatException => 'TreatException',
      _ir0y0iu6.UserRole => 'UserRole',
      _i6mr85kx.WallPost => 'WallPost',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('treat.', '');
    }

    switch (data) {
      case _i14xwlyb.BadgeId():
        return 'BadgeId';
      case _iywv5oz4.Claim():
        return 'Claim';
      case _iiz71frh.ProofLink():
        return 'ProofLink';
      case _i4cqplnc.ClaimStatus():
        return 'ClaimStatus';
      case _i48lh927.ClaimView():
        return 'ClaimView';
      case _ippz03u2.DropInput():
        return 'DropInput';
      case _i1c14r0n.DropSignal():
        return 'DropSignal';
      case _iapxm79h.Eligibility():
        return 'Eligibility';
      case _ixt5yy28.EligibilityReason():
        return 'EligibilityReason';
      case _ikawkn1p.LeaderboardEntry():
        return 'LeaderboardEntry';
      case _i22ljs0z.Me():
        return 'Me';
      case _iqlmmtnc.Offer():
        return 'Offer';
      case _irfq3mof.OfferCard():
        return 'OfferCard';
      case _iqmyfspq.OfferCategory():
        return 'OfferCategory';
      case _ix7dcs2a.OfferFrequency():
        return 'OfferFrequency';
      case _in0575rn.OfferInput():
        return 'OfferInput';
      case _ijq1l2tf.OfferKind():
        return 'OfferKind';
      case _i40dfi1m.OfferStatus():
        return 'OfferStatus';
      case _i671eu65.ProofType():
        return 'ProofType';
      case _idi75cqx.ProofUpload():
        return 'ProofUpload';
      case _i377gh4k.PublicStudent():
        return 'PublicStudent';
      case _iggnnz44.RedeemResult():
        return 'RedeemResult';
      case _itqm5y01.Review():
        return 'Review';
      case _iyeld2s2.SampleProof():
        return 'SampleProof';
      case _isgf2ncs.Shop():
        return 'Shop';
      case _iqgdamt7.ShopDashboard():
        return 'ShopDashboard';
      case _i5vfstp6.ShopInput():
        return 'ShopInput';
      case _iv7ebkk1.ShopPage():
        return 'ShopPage';
      case _i7zra0pp.ShopRating():
        return 'ShopRating';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _ipqqbskf.StudentVerification():
        return 'StudentVerification';
      case _iub4wqas.TopStudent():
        return 'TopStudent';
      case _iawcmjml.TreatException():
        return 'TreatException';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
      case _i6mr85kx.WallPost():
        return 'WallPost';
    }
    if (data is List<_i1fp4eeg.OfferCard>) {
      return 'List<OfferCard>';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BadgeId') {
      return deserialize<_i14xwlyb.BadgeId>(data['data']);
    }
    if (dataClassName == 'Claim') {
      return deserialize<_iywv5oz4.Claim>(data['data']);
    }
    if (dataClassName == 'ProofLink') {
      return deserialize<_iiz71frh.ProofLink>(data['data']);
    }
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_i4cqplnc.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'ClaimView') {
      return deserialize<_i48lh927.ClaimView>(data['data']);
    }
    if (dataClassName == 'DropInput') {
      return deserialize<_ippz03u2.DropInput>(data['data']);
    }
    if (dataClassName == 'DropSignal') {
      return deserialize<_i1c14r0n.DropSignal>(data['data']);
    }
    if (dataClassName == 'Eligibility') {
      return deserialize<_iapxm79h.Eligibility>(data['data']);
    }
    if (dataClassName == 'EligibilityReason') {
      return deserialize<_ixt5yy28.EligibilityReason>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ikawkn1p.LeaderboardEntry>(data['data']);
    }
    if (dataClassName == 'Me') {
      return deserialize<_i22ljs0z.Me>(data['data']);
    }
    if (dataClassName == 'Offer') {
      return deserialize<_iqlmmtnc.Offer>(data['data']);
    }
    if (dataClassName == 'OfferCard') {
      return deserialize<_irfq3mof.OfferCard>(data['data']);
    }
    if (dataClassName == 'OfferCategory') {
      return deserialize<_iqmyfspq.OfferCategory>(data['data']);
    }
    if (dataClassName == 'OfferFrequency') {
      return deserialize<_ix7dcs2a.OfferFrequency>(data['data']);
    }
    if (dataClassName == 'OfferInput') {
      return deserialize<_in0575rn.OfferInput>(data['data']);
    }
    if (dataClassName == 'OfferKind') {
      return deserialize<_ijq1l2tf.OfferKind>(data['data']);
    }
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i40dfi1m.OfferStatus>(data['data']);
    }
    if (dataClassName == 'ProofType') {
      return deserialize<_i671eu65.ProofType>(data['data']);
    }
    if (dataClassName == 'ProofUpload') {
      return deserialize<_idi75cqx.ProofUpload>(data['data']);
    }
    if (dataClassName == 'PublicStudent') {
      return deserialize<_i377gh4k.PublicStudent>(data['data']);
    }
    if (dataClassName == 'RedeemResult') {
      return deserialize<_iggnnz44.RedeemResult>(data['data']);
    }
    if (dataClassName == 'Review') {
      return deserialize<_itqm5y01.Review>(data['data']);
    }
    if (dataClassName == 'SampleProof') {
      return deserialize<_iyeld2s2.SampleProof>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName == 'ShopDashboard') {
      return deserialize<_iqgdamt7.ShopDashboard>(data['data']);
    }
    if (dataClassName == 'ShopInput') {
      return deserialize<_i5vfstp6.ShopInput>(data['data']);
    }
    if (dataClassName == 'ShopPage') {
      return deserialize<_iv7ebkk1.ShopPage>(data['data']);
    }
    if (dataClassName == 'ShopRating') {
      return deserialize<_i7zra0pp.ShopRating>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudentVerification') {
      return deserialize<_ipqqbskf.StudentVerification>(data['data']);
    }
    if (dataClassName == 'TopStudent') {
      return deserialize<_iub4wqas.TopStudent>(data['data']);
    }
    if (dataClassName == 'TreatException') {
      return deserialize<_iawcmjml.TreatException>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName == 'WallPost') {
      return deserialize<_i6mr85kx.WallPost>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    if (dataClassName == 'List<OfferCard>') {
      return deserialize<List<_i1fp4eeg.OfferCard>>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('treat', this);
    _iacc.Protocol().registerHostProtocol('treat', this);
  }

  @override
  String getModuleName() => 'treat';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
