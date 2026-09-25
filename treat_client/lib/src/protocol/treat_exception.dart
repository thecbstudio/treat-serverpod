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

/// Business-rule failure. `code` is stable and mapped to UI copy on the client.
abstract class TreatException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  TreatException._({
    required this.code,
    required this.message,
  });

  factory TreatException({
    required String code,
    required String message,
  }) = _TreatExceptionImpl;

  factory TreatException.fromJson(Map<String, dynamic> jsonSerialization) {
    return TreatException(
      code: jsonSerialization['code'] as String,
      message: jsonSerialization['message'] as String,
    );
  }

  String code;

  String message;

  /// Returns a shallow copy of this [TreatException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TreatException copyWith({
    String? code,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TreatException',
      'code': code,
      'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TreatException',
      'code': code,
      'message': message,
    };
  }

  @override
  String toString() {
    return 'TreatException(code: $code, message: $message)';
  }
}

class _TreatExceptionImpl extends TreatException {
  _TreatExceptionImpl({
    required String code,
    required String message,
  }) : super._(
         code: code,
         message: message,
       );

  /// Returns a shallow copy of this [TreatException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TreatException copyWith({
    String? code,
    String? message,
  }) {
    return TreatException(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }
}
