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
import 'offer_card.dart' as _irfq3mof;
import 'review.dart' as _itqm5y01;
import 'shop.dart' as _isgf2ncs;
import 'shop_rating.dart' as _i7zra0pp;
import 'wall_post.dart' as _i6mr85kx;

/// A place's public page.
abstract class ShopPage
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ShopPage._({
    required this.shop,
    required this.offers,
    required this.studentsTreated,
    required this.wall,
    required this.rating,
    required this.reviews,
  });

  factory ShopPage({
    required _isgf2ncs.Shop shop,
    required List<_irfq3mof.OfferCard> offers,
    required int studentsTreated,
    required List<_i6mr85kx.WallPost> wall,
    required _i7zra0pp.ShopRating rating,
    required List<_itqm5y01.Review> reviews,
  }) = _ShopPageImpl;

  factory ShopPage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopPage(
      shop: _iegszk5h.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      offers: _iegszk5h.Protocol().deserialize<List<_irfq3mof.OfferCard>>(
        jsonSerialization['offers'],
      ),
      studentsTreated: jsonSerialization['studentsTreated'] as int,
      wall: _iegszk5h.Protocol().deserialize<List<_i6mr85kx.WallPost>>(
        jsonSerialization['wall'],
      ),
      rating: _iegszk5h.Protocol().deserialize<_i7zra0pp.ShopRating>(
        jsonSerialization['rating'],
      ),
      reviews: _iegszk5h.Protocol().deserialize<List<_itqm5y01.Review>>(
        jsonSerialization['reviews'],
      ),
    );
  }

  _isgf2ncs.Shop shop;

  List<_irfq3mof.OfferCard> offers;

  int studentsTreated;

  List<_i6mr85kx.WallPost> wall;

  _i7zra0pp.ShopRating rating;

  List<_itqm5y01.Review> reviews;

  /// Returns a shallow copy of this [ShopPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShopPage copyWith({
    _isgf2ncs.Shop? shop,
    List<_irfq3mof.OfferCard>? offers,
    int? studentsTreated,
    List<_i6mr85kx.WallPost>? wall,
    _i7zra0pp.ShopRating? rating,
    List<_itqm5y01.Review>? reviews,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopPage',
      'shop': shop.toJson(),
      'offers': offers.toJson(valueToJson: (v) => v.toJson()),
      'studentsTreated': studentsTreated,
      'wall': wall.toJson(valueToJson: (v) => v.toJson()),
      'rating': rating.toJson(),
      'reviews': reviews.toJson(valueToJson: (v) => v.toJson()),
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
      'rating': rating.toJsonForProtocol(),
      'reviews': reviews.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ShopPageImpl extends ShopPage {
  _ShopPageImpl({
    required _isgf2ncs.Shop shop,
    required List<_irfq3mof.OfferCard> offers,
    required int studentsTreated,
    required List<_i6mr85kx.WallPost> wall,
    required _i7zra0pp.ShopRating rating,
    required List<_itqm5y01.Review> reviews,
  }) : super._(
         shop: shop,
         offers: offers,
         studentsTreated: studentsTreated,
         wall: wall,
         rating: rating,
         reviews: reviews,
       );

  /// Returns a shallow copy of this [ShopPage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShopPage copyWith({
    _isgf2ncs.Shop? shop,
    List<_irfq3mof.OfferCard>? offers,
    int? studentsTreated,
    List<_i6mr85kx.WallPost>? wall,
    _i7zra0pp.ShopRating? rating,
    List<_itqm5y01.Review>? reviews,
  }) {
    return ShopPage(
      shop: shop ?? this.shop.copyWith(),
      offers: offers ?? this.offers.map((e0) => e0.copyWith()).toList(),
      studentsTreated: studentsTreated ?? this.studentsTreated,
      wall: wall ?? this.wall.map((e0) => e0.copyWith()).toList(),
      rating: rating ?? this.rating.copyWith(),
      reviews: reviews ?? this.reviews.map((e0) => e0.copyWith()).toList(),
    );
  }
}
