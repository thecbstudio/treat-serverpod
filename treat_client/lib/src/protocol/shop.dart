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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/protocol.dart' as _iu07tsrf;
import 'offer_category.dart' as _iqmyfspq;

/// A business account. `owner` is null only for seeded shops without a login.
abstract class Shop
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Shop._({
    this.id,
    this.ownerId,
    this.owner,
    this.seedKey,
    required this.name,
    required this.category,
    required this.district,
    required this.address,
    required this.bio,
    this.instagramHandle,
    this.googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) : verified = verified ?? false,
       totalRedeems = totalRedeems ?? 0,
       approvedProofs = approvedProofs ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Shop({
    int? id,
    _isc.UuidValue? ownerId,
    _iacc.AuthUser? owner,
    String? seedKey,
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) = _ShopImpl;

  factory Shop.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shop(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['ownerId']),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['owner'],
            ),
      seedKey: jsonSerialization['seedKey'] as String?,
      name: jsonSerialization['name'] as String,
      category: _iqmyfspq.OfferCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      district: jsonSerialization['district'] as String,
      address: jsonSerialization['address'] as String,
      bio: jsonSerialization['bio'] as String,
      instagramHandle: jsonSerialization['instagramHandle'] as String?,
      googleReviewUrl: jsonSerialization['googleReviewUrl'] as String?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      totalRedeems: jsonSerialization['totalRedeems'] as int?,
      approvedProofs: jsonSerialization['approvedProofs'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue? ownerId;

  _iacc.AuthUser? owner;

  /// Stable key for idempotent seeding; null for real sign-ups.
  String? seedKey;

  String name;

  _iqmyfspq.OfferCategory category;

  String district;

  String address;

  String bio;

  /// Without "@". Used by the AI proof verifier.
  String? instagramHandle;

  /// The place's own Google "ask for reviews" link, printed as a QR on its
  /// counter card for every customer. Never shown to students in the treat
  /// flow and never rewarded.
  String? googleReviewUrl;

  bool verified;

  int totalRedeems;

  int approvedProofs;

  DateTime createdAt;

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Shop copyWith({
    int? id,
    _isc.UuidValue? ownerId,
    _iacc.AuthUser? owner,
    String? seedKey,
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
      if (googleReviewUrl != null) 'googleReviewUrl': googleReviewUrl,
      'verified': verified,
      'totalRedeems': totalRedeems,
      'approvedProofs': approvedProofs,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
      if (googleReviewUrl != null) 'googleReviewUrl': googleReviewUrl,
      'verified': verified,
      'totalRedeems': totalRedeems,
      'approvedProofs': approvedProofs,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopImpl extends Shop {
  _ShopImpl({
    int? id,
    _isc.UuidValue? ownerId,
    _iacc.AuthUser? owner,
    String? seedKey,
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         owner: owner,
         seedKey: seedKey,
         name: name,
         category: category,
         district: district,
         address: address,
         bio: bio,
         instagramHandle: instagramHandle,
         googleReviewUrl: googleReviewUrl,
         verified: verified,
         totalRedeems: totalRedeems,
         approvedProofs: approvedProofs,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Shop copyWith({
    Object? id = _Undefined,
    Object? ownerId = _Undefined,
    Object? owner = _Undefined,
    Object? seedKey = _Undefined,
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    Object? instagramHandle = _Undefined,
    Object? googleReviewUrl = _Undefined,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) {
    return Shop(
      id: id is int? ? id : this.id,
      ownerId: ownerId is _isc.UuidValue? ? ownerId : this.ownerId,
      owner: owner is _iacc.AuthUser? ? owner : this.owner?.copyWith(),
      seedKey: seedKey is String? ? seedKey : this.seedKey,
      name: name ?? this.name,
      category: category ?? this.category,
      district: district ?? this.district,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      instagramHandle: instagramHandle is String?
          ? instagramHandle
          : this.instagramHandle,
      googleReviewUrl: googleReviewUrl is String?
          ? googleReviewUrl
          : this.googleReviewUrl,
      verified: verified ?? this.verified,
      totalRedeems: totalRedeems ?? this.totalRedeems,
      approvedProofs: approvedProofs ?? this.approvedProofs,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
