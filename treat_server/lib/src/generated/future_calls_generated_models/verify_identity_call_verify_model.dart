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
import 'package:serverpod/serverpod.dart' as _is;

abstract class VerifyIdentityCallVerifyModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VerifyIdentityCallVerifyModel._({required this.checkId});

  factory VerifyIdentityCallVerifyModel({required int checkId}) =
      _VerifyIdentityCallVerifyModelImpl;

  factory VerifyIdentityCallVerifyModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return VerifyIdentityCallVerifyModel(
      checkId: jsonSerialization['checkId'] as int,
    );
  }

  int checkId;

  /// Returns a shallow copy of this [VerifyIdentityCallVerifyModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VerifyIdentityCallVerifyModel copyWith({int? checkId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VerifyIdentityCallVerifyModel',
      'checkId': checkId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VerifyIdentityCallVerifyModelImpl extends VerifyIdentityCallVerifyModel {
  _VerifyIdentityCallVerifyModelImpl({required int checkId})
    : super._(checkId: checkId);

  /// Returns a shallow copy of this [VerifyIdentityCallVerifyModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VerifyIdentityCallVerifyModel copyWith({int? checkId}) {
    return VerifyIdentityCallVerifyModel(checkId: checkId ?? this.checkId);
  }
}
