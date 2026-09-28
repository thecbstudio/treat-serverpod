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
import 'package:treat_server/src/generated/protocol.dart' as _iegszk5h;
import 'proof_type.dart' as _i671eu65;

/// What a shop sends to start a drop.
abstract class DropInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DropInput._({
    required this.title,
    required this.description,
    required this.quantity,
    required this.durationMinutes,
    required this.proofTypes,
  });

  factory DropInput({
    required String title,
    required String description,
    required int quantity,
    required int durationMinutes,
    required List<_i671eu65.ProofType> proofTypes,
  }) = _DropInputImpl;

  factory DropInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return DropInput(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      durationMinutes: jsonSerialization['durationMinutes'] as int,
      proofTypes: _iegszk5h.Protocol().deserialize<List<_i671eu65.ProofType>>(
        jsonSerialization['proofTypes'],
      ),
    );
  }

  String title;

  String description;

  /// Stock, 1..50.
  int quantity;

  /// How long the drop stays open, 10..180 minutes.
  int durationMinutes;

  List<_i671eu65.ProofType> proofTypes;

  /// Returns a shallow copy of this [DropInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DropInput copyWith({
    String? title,
    String? description,
    int? quantity,
    int? durationMinutes,
    List<_i671eu65.ProofType>? proofTypes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DropInput',
      'title': title,
      'description': description,
      'quantity': quantity,
      'durationMinutes': durationMinutes,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DropInput',
      'title': title,
      'description': description,
      'quantity': quantity,
      'durationMinutes': durationMinutes,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DropInputImpl extends DropInput {
  _DropInputImpl({
    required String title,
    required String description,
    required int quantity,
    required int durationMinutes,
    required List<_i671eu65.ProofType> proofTypes,
  }) : super._(
         title: title,
         description: description,
         quantity: quantity,
         durationMinutes: durationMinutes,
         proofTypes: proofTypes,
       );

  /// Returns a shallow copy of this [DropInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DropInput copyWith({
    String? title,
    String? description,
    int? quantity,
    int? durationMinutes,
    List<_i671eu65.ProofType>? proofTypes,
  }) {
    return DropInput(
      title: title ?? this.title,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      proofTypes: proofTypes ?? this.proofTypes.map((e0) => e0).toList(),
    );
  }
}
