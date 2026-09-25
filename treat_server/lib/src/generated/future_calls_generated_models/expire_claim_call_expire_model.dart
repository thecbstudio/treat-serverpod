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

abstract class ExpireClaimCallExpireModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ExpireClaimCallExpireModel._({required this.claimId});

  factory ExpireClaimCallExpireModel({required int claimId}) =
      _ExpireClaimCallExpireModelImpl;

  factory ExpireClaimCallExpireModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ExpireClaimCallExpireModel(
      claimId: jsonSerialization['claimId'] as int,
    );
  }

  int claimId;

  /// Returns a shallow copy of this [ExpireClaimCallExpireModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ExpireClaimCallExpireModel copyWith({int? claimId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ExpireClaimCallExpireModel',
      'claimId': claimId,
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

class _ExpireClaimCallExpireModelImpl extends ExpireClaimCallExpireModel {
  _ExpireClaimCallExpireModelImpl({required int claimId})
    : super._(claimId: claimId);

  /// Returns a shallow copy of this [ExpireClaimCallExpireModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ExpireClaimCallExpireModel copyWith({int? claimId}) {
    return ExpireClaimCallExpireModel(claimId: claimId ?? this.claimId);
  }
}
