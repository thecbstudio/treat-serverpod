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
import 'eligibility_reason.dart' as _ixt5yy28;

/// Result of `eligibilityOf`. Extra fields depend on [reason].
abstract class Eligibility
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Eligibility._({
    required this.reason,
    this.claimId,
    this.availableAt,
    this.opensAtMin,
  });

  factory Eligibility({
    required _ixt5yy28.EligibilityReason reason,
    int? claimId,
    DateTime? availableAt,
    int? opensAtMin,
  }) = _EligibilityImpl;

  factory Eligibility.fromJson(Map<String, dynamic> jsonSerialization) {
    return Eligibility(
      reason: _ixt5yy28.EligibilityReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      claimId: jsonSerialization['claimId'] as int?,
      availableAt: jsonSerialization['availableAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['availableAt'],
            ),
      opensAtMin: jsonSerialization['opensAtMin'] as int?,
    );
  }

  _ixt5yy28.EligibilityReason reason;

  /// reason == activeClaim
  int? claimId;

  /// reason == frequency
  DateTime? availableAt;

  /// reason == outsideHours (Istanbul minutes)
  int? opensAtMin;

  /// Returns a shallow copy of this [Eligibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Eligibility copyWith({
    _ixt5yy28.EligibilityReason? reason,
    int? claimId,
    DateTime? availableAt,
    int? opensAtMin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Eligibility',
      'reason': reason.toJson(),
      if (claimId != null) 'claimId': claimId,
      if (availableAt != null) 'availableAt': availableAt?.toJson(),
      if (opensAtMin != null) 'opensAtMin': opensAtMin,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Eligibility',
      'reason': reason.toJson(),
      if (claimId != null) 'claimId': claimId,
      if (availableAt != null) 'availableAt': availableAt?.toJson(),
      if (opensAtMin != null) 'opensAtMin': opensAtMin,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EligibilityImpl extends Eligibility {
  _EligibilityImpl({
    required _ixt5yy28.EligibilityReason reason,
    int? claimId,
    DateTime? availableAt,
    int? opensAtMin,
  }) : super._(
         reason: reason,
         claimId: claimId,
         availableAt: availableAt,
         opensAtMin: opensAtMin,
       );

  /// Returns a shallow copy of this [Eligibility]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Eligibility copyWith({
    _ixt5yy28.EligibilityReason? reason,
    Object? claimId = _Undefined,
    Object? availableAt = _Undefined,
    Object? opensAtMin = _Undefined,
  }) {
    return Eligibility(
      reason: reason ?? this.reason,
      claimId: claimId is int? ? claimId : this.claimId,
      availableAt: availableAt is DateTime? ? availableAt : this.availableAt,
      opensAtMin: opensAtMin is int? ? opensAtMin : this.opensAtMin,
    );
  }
}
