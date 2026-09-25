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
import 'package:treat_client/src/protocol/offer_card.dart' as _i1fp4eeg;
import 'badge_id.dart' as _i14xwlyb;
import 'claim.dart' as _iywv5oz4;
import 'claim_status.dart' as _i4cqplnc;
import 'claim_view.dart' as _i48lh927;
import 'eligibility.dart' as _iapxm79h;
import 'eligibility_reason.dart' as _ixt5yy28;
import 'me.dart' as _i22ljs0z;
import 'offer.dart' as _iqlmmtnc;
import 'offer_card.dart' as _irfq3mof;
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_input.dart' as _in0575rn;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'redeem_result.dart' as _iggnnz44;
import 'shop.dart' as _isgf2ncs;
import 'shop_input.dart' as _i5vfstp6;
import 'student_profile.dart' as _iovtxv26;
import 'student_verification.dart' as _ipqqbskf;
import 'treat_exception.dart' as _iawcmjml;
import 'user_role.dart' as _ir0y0iu6;
export 'badge_id.dart';
export 'claim.dart';
export 'claim_status.dart';
export 'claim_view.dart';
export 'eligibility.dart';
export 'eligibility_reason.dart';
export 'me.dart';
export 'offer.dart';
export 'offer_card.dart';
export 'offer_category.dart';
export 'offer_frequency.dart';
export 'offer_input.dart';
export 'offer_status.dart';
export 'proof_type.dart';
export 'redeem_result.dart';
export 'shop.dart';
export 'shop_input.dart';
export 'student_profile.dart';
export 'student_verification.dart';
export 'treat_exception.dart';
export 'user_role.dart';
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
    if (t == _i4cqplnc.ClaimStatus) {
      return _i4cqplnc.ClaimStatus.fromJson(data) as T;
    }
    if (t == _i48lh927.ClaimView) {
      return _i48lh927.ClaimView.fromJson(data) as T;
    }
    if (t == _iapxm79h.Eligibility) {
      return _iapxm79h.Eligibility.fromJson(data) as T;
    }
    if (t == _ixt5yy28.EligibilityReason) {
      return _ixt5yy28.EligibilityReason.fromJson(data) as T;
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
    if (t == _i40dfi1m.OfferStatus) {
      return _i40dfi1m.OfferStatus.fromJson(data) as T;
    }
    if (t == _i671eu65.ProofType) {
      return _i671eu65.ProofType.fromJson(data) as T;
    }
    if (t == _iggnnz44.RedeemResult) {
      return _iggnnz44.RedeemResult.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _i5vfstp6.ShopInput) {
      return _i5vfstp6.ShopInput.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _ipqqbskf.StudentVerification) {
      return _ipqqbskf.StudentVerification.fromJson(data) as T;
    }
    if (t == _iawcmjml.TreatException) {
      return _iawcmjml.TreatException.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _isc.getType<_i14xwlyb.BadgeId?>()) {
      return (data != null ? _i14xwlyb.BadgeId.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iywv5oz4.Claim?>()) {
      return (data != null ? _iywv5oz4.Claim.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4cqplnc.ClaimStatus?>()) {
      return (data != null ? _i4cqplnc.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i48lh927.ClaimView?>()) {
      return (data != null ? _i48lh927.ClaimView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iapxm79h.Eligibility?>()) {
      return (data != null ? _iapxm79h.Eligibility.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixt5yy28.EligibilityReason?>()) {
      return (data != null ? _ixt5yy28.EligibilityReason.fromJson(data) : null)
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
    if (t == _isc.getType<_i40dfi1m.OfferStatus?>()) {
      return (data != null ? _i40dfi1m.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i671eu65.ProofType?>()) {
      return (data != null ? _i671eu65.ProofType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iggnnz44.RedeemResult?>()) {
      return (data != null ? _iggnnz44.RedeemResult.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5vfstp6.ShopInput?>()) {
      return (data != null ? _i5vfstp6.ShopInput.fromJson(data) : null) as T;
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
    if (t == _isc.getType<_iawcmjml.TreatException?>()) {
      return (data != null ? _iawcmjml.TreatException.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<_i14xwlyb.BadgeId>) {
      return (data as List)
              .map((e) => deserialize<_i14xwlyb.BadgeId>(e))
              .toList()
          as T;
    }
    if (t == List<_i671eu65.ProofType>) {
      return (data as List)
              .map((e) => deserialize<_i671eu65.ProofType>(e))
              .toList()
          as T;
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
    if (t == List<_i1fp4eeg.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_i1fp4eeg.OfferCard>(e))
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
      _i4cqplnc.ClaimStatus => 'ClaimStatus',
      _i48lh927.ClaimView => 'ClaimView',
      _iapxm79h.Eligibility => 'Eligibility',
      _ixt5yy28.EligibilityReason => 'EligibilityReason',
      _i22ljs0z.Me => 'Me',
      _iqlmmtnc.Offer => 'Offer',
      _irfq3mof.OfferCard => 'OfferCard',
      _iqmyfspq.OfferCategory => 'OfferCategory',
      _ix7dcs2a.OfferFrequency => 'OfferFrequency',
      _in0575rn.OfferInput => 'OfferInput',
      _i40dfi1m.OfferStatus => 'OfferStatus',
      _i671eu65.ProofType => 'ProofType',
      _iggnnz44.RedeemResult => 'RedeemResult',
      _isgf2ncs.Shop => 'Shop',
      _i5vfstp6.ShopInput => 'ShopInput',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _ipqqbskf.StudentVerification => 'StudentVerification',
      _iawcmjml.TreatException => 'TreatException',
      _ir0y0iu6.UserRole => 'UserRole',
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
      case _i4cqplnc.ClaimStatus():
        return 'ClaimStatus';
      case _i48lh927.ClaimView():
        return 'ClaimView';
      case _iapxm79h.Eligibility():
        return 'Eligibility';
      case _ixt5yy28.EligibilityReason():
        return 'EligibilityReason';
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
      case _i40dfi1m.OfferStatus():
        return 'OfferStatus';
      case _i671eu65.ProofType():
        return 'ProofType';
      case _iggnnz44.RedeemResult():
        return 'RedeemResult';
      case _isgf2ncs.Shop():
        return 'Shop';
      case _i5vfstp6.ShopInput():
        return 'ShopInput';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _ipqqbskf.StudentVerification():
        return 'StudentVerification';
      case _iawcmjml.TreatException():
        return 'TreatException';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
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
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_i4cqplnc.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'ClaimView') {
      return deserialize<_i48lh927.ClaimView>(data['data']);
    }
    if (dataClassName == 'Eligibility') {
      return deserialize<_iapxm79h.Eligibility>(data['data']);
    }
    if (dataClassName == 'EligibilityReason') {
      return deserialize<_ixt5yy28.EligibilityReason>(data['data']);
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
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i40dfi1m.OfferStatus>(data['data']);
    }
    if (dataClassName == 'ProofType') {
      return deserialize<_i671eu65.ProofType>(data['data']);
    }
    if (dataClassName == 'RedeemResult') {
      return deserialize<_iggnnz44.RedeemResult>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName == 'ShopInput') {
      return deserialize<_i5vfstp6.ShopInput>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudentVerification') {
      return deserialize<_ipqqbskf.StudentVerification>(data['data']);
    }
    if (dataClassName == 'TreatException') {
      return deserialize<_iawcmjml.TreatException>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
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
