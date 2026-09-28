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
import 'offer_card.dart' as _irfq3mof;
import 'shop.dart' as _isgf2ncs;
import 'wall_post.dart' as _i6mr85kx;

/// A place's public page.
abstract class ShopPage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopPage._({
    required this.shop,
    required this.offers,
    required this.studentsTreated,
    required this.wall,
  });

  factory ShopPage({
    required _isgf2ncs.Shop shop,
    required List<_irfq3mof.OfferCard> offers,
    required int studentsTreated,
    required List<_i6mr85kx.WallPost> wall,
  }) = _ShopPageImpl;

  factory ShopPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopPage(
      shop: _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      offers: _iu07tsrf.Protocol().deserialize<List<_irfq3mof.OfferCard>>(
        jsonSerialization['offers'],
      ),
      studentsTreated: jsonSerialization['studentsTreated'] as int,
      wall: _iu07tsrf.Protocol().deserialize<List<_i6mr85kx.WallPost>>(
        jsonSerialization['wall'],
      ),
    );
  }

  _isgf2ncs.Shop shop;

  List<_irfq3mof.OfferCard> offers;

  int studentsTreated;

  List<_i6mr85kx.WallPost> wall;

  /// Returns a shallow copy of this [ShopPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopPage copyWith({
    _isgf2ncs.Shop? shop,
    List<_irfq3mof.OfferCard>? offers,
    int? studentsTreated,
    List<_i6mr85kx.WallPost>? wall,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopPage',
      'shop': shop.toJson(),
      'offers': offers.toJson(valueToJson: (v) => v.toJson()),
      'studentsTreated': studentsTreated,
      'wall': wall.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopPage',
      'shop': shop.toJsonForProtocol(),
      'offers': offers.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'studentsTreated': studentsTreated,
      'wall': wall.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ShopPageImpl extends ShopPage {
  _ShopPageImpl({
    required _isgf2ncs.Shop shop,
    required List<_irfq3mof.OfferCard> offers,
    required int studentsTreated,
    required List<_i6mr85kx.WallPost> wall,
  }) : super._(
         shop: shop,
         offers: offers,
         studentsTreated: studentsTreated,
         wall: wall,
       );

  /// Returns a shallow copy of this [ShopPage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopPage copyWith({
    _isgf2ncs.Shop? shop,
    List<_irfq3mof.OfferCard>? offers,
    int? studentsTreated,
    List<_i6mr85kx.WallPost>? wall,
  }) {
    return ShopPage(
      shop: shop ?? this.shop.copyWith(),
      offers: offers ?? this.offers.map((e0) => e0.copyWith()).toList(),
      studentsTreated: studentsTreated ?? this.studentsTreated,
      wall: wall ?? this.wall.map((e0) => e0.copyWith()).toList(),
    );
  }
}
