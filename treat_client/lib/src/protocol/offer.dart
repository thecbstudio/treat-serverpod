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
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_kind.dart' as _ijq1l2tf;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'shop.dart' as _isgf2ncs;

/// A free treat a shop gives in exchange for a social-media proof.
abstract class Offer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Offer._({
    this.id,
    required this.shopId,
    this.shop,
    this.seedKey,
    required this.title,
    required this.description,
    required this.category,
    required this.frequency,
    required this.activeStartMin,
    required this.activeEndMin,
    this.dailyCap,
    this.totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required this.proofTypes,
    DateTime? createdAt,
    _ijq1l2tf.OfferKind? kind,
    this.endsAt,
  }) : status = status ?? _i40dfi1m.OfferStatus.active,
       featured = featured ?? false,
       createdAt = createdAt ?? DateTime.now(),
       kind = kind ?? _ijq1l2tf.OfferKind.regular;

  factory Offer({
    int? id,
    required int shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    required String title,
    required String description,
    required _iqmyfspq.OfferCategory category,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required List<_i671eu65.ProofType> proofTypes,
    DateTime? createdAt,
    _ijq1l2tf.OfferKind? kind,
    DateTime? endsAt,
  }) = _OfferImpl;

  factory Offer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Offer(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      shop: jsonSerialization['shop'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
              jsonSerialization['shop'],
            ),
      seedKey: jsonSerialization['seedKey'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: _iqmyfspq.OfferCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      frequency: _ix7dcs2a.OfferFrequency.fromJson(
        (jsonSerialization['frequency'] as String),
      ),
      activeStartMin: jsonSerialization['activeStartMin'] as int,
      activeEndMin: jsonSerialization['activeEndMin'] as int,
      dailyCap: jsonSerialization['dailyCap'] as int?,
      totalCap: jsonSerialization['totalCap'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i40dfi1m.OfferStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      featured: jsonSerialization['featured'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['featured']),
      proofTypes: _iu07tsrf.Protocol().deserialize<List<_i671eu65.ProofType>>(
        jsonSerialization['proofTypes'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      kind: jsonSerialization['kind'] == null
          ? null
          : _ijq1l2tf.OfferKind.fromJson((jsonSerialization['kind'] as String)),
      endsAt: jsonSerialization['endsAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shopId;

  _isgf2ncs.Shop? shop;

  String? seedKey;

  String title;

  String description;

  /// Copied from the shop at creation.
  _iqmyfspq.OfferCategory category;

  _ix7dcs2a.OfferFrequency frequency;

  /// Minutes after midnight, Europe/Istanbul. start < end.
  int activeStartMin;

  int activeEndMin;

  int? dailyCap;

  int? totalCap;

  _i40dfi1m.OfferStatus status;

  bool featured;

  /// At least one.
  List<_i671eu65.ProofType> proofTypes;

  DateTime createdAt;

  _ijq1l2tf.OfferKind kind;

  /// Drops only: when the drop closes. Stock is `totalCap`.
  DateTime? endsAt;

  /// Returns a shallow copy of this [Offer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Offer copyWith({
    int? id,
    int? shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    String? title,
    String? description,
    _iqmyfspq.OfferCategory? category,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    List<_i671eu65.ProofType>? proofTypes,
    DateTime? createdAt,
    _ijq1l2tf.OfferKind? kind,
    DateTime? endsAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Offer',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (shop != null) 'shop': shop?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'title': title,
      'description': description,
      'category': category.toJson(),
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'status': status.toJson(),
      'featured': featured,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'kind': kind.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Offer',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (shop != null) 'shop': shop?.toJsonForProtocol(),
      if (seedKey != null) 'seedKey': seedKey,
      'title': title,
      'description': description,
      'category': category.toJson(),
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'status': status.toJson(),
      'featured': featured,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
      'kind': kind.toJson(),
      if (endsAt != null) 'endsAt': endsAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfferImpl extends Offer {
  _OfferImpl({
    int? id,
    required int shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    required String title,
    required String description,
    required _iqmyfspq.OfferCategory category,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required List<_i671eu65.ProofType> proofTypes,
    DateTime? createdAt,
    _ijq1l2tf.OfferKind? kind,
    DateTime? endsAt,
  }) : super._(
         id: id,
         shopId: shopId,
         shop: shop,
         seedKey: seedKey,
         title: title,
         description: description,
         category: category,
         frequency: frequency,
         activeStartMin: activeStartMin,
         activeEndMin: activeEndMin,
         dailyCap: dailyCap,
         totalCap: totalCap,
         status: status,
         featured: featured,
         proofTypes: proofTypes,
         createdAt: createdAt,
         kind: kind,
         endsAt: endsAt,
       );

  /// Returns a shallow copy of this [Offer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Offer copyWith({
    Object? id = _Undefined,
    int? shopId,
    Object? shop = _Undefined,
    Object? seedKey = _Undefined,
    String? title,
    String? description,
    _iqmyfspq.OfferCategory? category,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    Object? dailyCap = _Undefined,
    Object? totalCap = _Undefined,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    List<_i671eu65.ProofType>? proofTypes,
    DateTime? createdAt,
    _ijq1l2tf.OfferKind? kind,
    Object? endsAt = _Undefined,
  }) {
    return Offer(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      shop: shop is _isgf2ncs.Shop? ? shop : this.shop?.copyWith(),
      seedKey: seedKey is String? ? seedKey : this.seedKey,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      activeStartMin: activeStartMin ?? this.activeStartMin,
      activeEndMin: activeEndMin ?? this.activeEndMin,
      dailyCap: dailyCap is int? ? dailyCap : this.dailyCap,
      totalCap: totalCap is int? ? totalCap : this.totalCap,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      proofTypes: proofTypes ?? this.proofTypes.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
      kind: kind ?? this.kind,
      endsAt: endsAt is DateTime? ? endsAt : this.endsAt,
    );
  }
}
