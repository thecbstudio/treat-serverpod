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
import 'offer_category.dart' as _iqmyfspq;

abstract class ShopInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopInput._({
    required this.name,
    required this.category,
    required this.district,
    required this.address,
    required this.bio,
    this.instagramHandle,
  });

  factory ShopInput({
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
  }) = _ShopInputImpl;

  factory ShopInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopInput(
      name: jsonSerialization['name'] as String,
      category: _iqmyfspq.OfferCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      district: jsonSerialization['district'] as String,
      address: jsonSerialization['address'] as String,
      bio: jsonSerialization['bio'] as String,
      instagramHandle: jsonSerialization['instagramHandle'] as String?,
    );
  }

  String name;

  _iqmyfspq.OfferCategory category;

  String district;

  String address;

  String bio;

  String? instagramHandle;

  /// Returns a shallow copy of this [ShopInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopInput copyWith({
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    String? instagramHandle,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopInput',
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopInput',
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopInputImpl extends ShopInput {
  _ShopInputImpl({
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
  }) : super._(
         name: name,
         category: category,
         district: district,
         address: address,
         bio: bio,
         instagramHandle: instagramHandle,
       );

  /// Returns a shallow copy of this [ShopInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopInput copyWith({
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    Object? instagramHandle = _Undefined,
  }) {
    return ShopInput(
      name: name ?? this.name,
      category: category ?? this.category,
      district: district ?? this.district,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      instagramHandle: instagramHandle is String?
          ? instagramHandle
          : this.instagramHandle,
    );
  }
}
