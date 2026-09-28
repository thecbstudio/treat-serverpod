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

/// "Something about this drop changed" — sent on the drops channel.
abstract class DropSignal
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DropSignal._({required this.offerId});

  factory DropSignal({required int offerId}) = _DropSignalImpl;

  factory DropSignal.fromJson(Map<String, dynamic> jsonSerialization) {
    return DropSignal(offerId: jsonSerialization['offerId'] as int);
  }

  int offerId;

  /// Returns a shallow copy of this [DropSignal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DropSignal copyWith({int? offerId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DropSignal',
      'offerId': offerId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DropSignal',
      'offerId': offerId,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DropSignalImpl extends DropSignal {
  _DropSignalImpl({required int offerId}) : super._(offerId: offerId);

  /// Returns a shallow copy of this [DropSignal]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DropSignal copyWith({int? offerId}) {
    return DropSignal(offerId: offerId ?? this.offerId);
  }
}
