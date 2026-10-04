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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Who gets the treat: a verified student, by the e-mail they signed up with
/// or by profile (from their public page). Exactly one of the two.
abstract class GiftInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GiftInput._({
    required this.shopId,
    required this.amountTl,
    this.recipientEmail,
    this.recipientStudentId,
    this.message,
  });

  factory GiftInput({
    required int shopId,
    required int amountTl,
    String? recipientEmail,
    int? recipientStudentId,
    String? message,
  }) = _GiftInputImpl;

  factory GiftInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return GiftInput(
      shopId: jsonSerialization['shopId'] as int,
      amountTl: jsonSerialization['amountTl'] as int,
      recipientEmail: jsonSerialization['recipientEmail'] as String?,
      recipientStudentId: jsonSerialization['recipientStudentId'] as int?,
      message: jsonSerialization['message'] as String?,
    );
  }

  int shopId;

  int amountTl;

  String? recipientEmail;

  int? recipientStudentId;

  String? message;

  /// Returns a shallow copy of this [GiftInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GiftInput copyWith({
    int? shopId,
    int? amountTl,
    String? recipientEmail,
    int? recipientStudentId,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GiftInput',
      'shopId': shopId,
      'amountTl': amountTl,
      if (recipientEmail != null) 'recipientEmail': recipientEmail,
      if (recipientStudentId != null) 'recipientStudentId': recipientStudentId,
      if (message != null) 'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GiftInput',
      'shopId': shopId,
      'amountTl': amountTl,
      if (recipientEmail != null) 'recipientEmail': recipientEmail,
      if (recipientStudentId != null) 'recipientStudentId': recipientStudentId,
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GiftInputImpl extends GiftInput {
  _GiftInputImpl({
    required int shopId,
    required int amountTl,
    String? recipientEmail,
    int? recipientStudentId,
    String? message,
  }) : super._(
         shopId: shopId,
         amountTl: amountTl,
         recipientEmail: recipientEmail,
         recipientStudentId: recipientStudentId,
         message: message,
       );

  /// Returns a shallow copy of this [GiftInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GiftInput copyWith({
    int? shopId,
    int? amountTl,
    Object? recipientEmail = _Undefined,
    Object? recipientStudentId = _Undefined,
    Object? message = _Undefined,
  }) {
    return GiftInput(
      shopId: shopId ?? this.shopId,
      amountTl: amountTl ?? this.amountTl,
      recipientEmail: recipientEmail is String?
          ? recipientEmail
          : this.recipientEmail,
      recipientStudentId: recipientStudentId is int?
          ? recipientStudentId
          : this.recipientStudentId,
      message: message is String? ? message : this.message,
    );
  }
}
