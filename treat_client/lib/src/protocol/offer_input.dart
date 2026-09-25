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
import 'package:treat_client/src/protocol/protocol.dart' as _iu07tsrf;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'proof_type.dart' as _i671eu65;

/// What a shop sends when creating or editing an offer.
abstract class OfferInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OfferInput._({
    required this.title,
    required this.description,
    required this.frequency,
    required this.activeStartMin,
    required this.activeEndMin,
    this.dailyCap,
    this.totalCap,
    required this.proofTypes,
  });

  factory OfferInput({
    required String title,
    required String description,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    required List<_i671eu65.ProofType> proofTypes,
  }) = _OfferInputImpl;

  factory OfferInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return OfferInput(
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      frequency: _ix7dcs2a.OfferFrequency.fromJson(
        (jsonSerialization['frequency'] as String),
      ),
      activeStartMin: jsonSerialization['activeStartMin'] as int,
      activeEndMin: jsonSerialization['activeEndMin'] as int,
      dailyCap: jsonSerialization['dailyCap'] as int?,
      totalCap: jsonSerialization['totalCap'] as int?,
      proofTypes: _iu07tsrf.Protocol().deserialize<List<_i671eu65.ProofType>>(
        jsonSerialization['proofTypes'],
      ),
    );
  }

  String title;

  String description;

  _ix7dcs2a.OfferFrequency frequency;

  int activeStartMin;

  int activeEndMin;

  int? dailyCap;

  int? totalCap;

  List<_i671eu65.ProofType> proofTypes;

  /// Returns a shallow copy of this [OfferInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OfferInput copyWith({
    String? title,
    String? description,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    int? dailyCap,
    int? totalCap,
    List<_i671eu65.ProofType>? proofTypes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfferInput',
      'title': title,
      'description': description,
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfferInput',
      'title': title,
      'description': description,
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfferInputImpl extends OfferInput {
  _OfferInputImpl({
    required String title,
    required String description,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    required List<_i671eu65.ProofType> proofTypes,
  }) : super._(
         title: title,
         description: description,
         frequency: frequency,
         activeStartMin: activeStartMin,
         activeEndMin: activeEndMin,
         dailyCap: dailyCap,
         totalCap: totalCap,
         proofTypes: proofTypes,
       );

  /// Returns a shallow copy of this [OfferInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OfferInput copyWith({
    String? title,
    String? description,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    Object? dailyCap = _Undefined,
    Object? totalCap = _Undefined,
    List<_i671eu65.ProofType>? proofTypes,
  }) {
    return OfferInput(
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      activeStartMin: activeStartMin ?? this.activeStartMin,
      activeEndMin: activeEndMin ?? this.activeEndMin,
      dailyCap: dailyCap is int? ? dailyCap : this.dailyCap,
      totalCap: totalCap is int? ? totalCap : this.totalCap,
      proofTypes: proofTypes ?? this.proofTypes.map((e0) => e0).toList(),
    );
  }
}
