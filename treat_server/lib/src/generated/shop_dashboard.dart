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
import 'claim_view.dart' as _i48lh927;
import 'gift_shop_stats.dart' as _iglfqzwp;
import 'review.dart' as _itqm5y01;
import 'shop.dart' as _isgf2ncs;
import 'shop_rating.dart' as _i7zra0pp;
import 'top_student.dart' as _iub4wqas;

/// Business panel: totals, ROI estimate, recent activity, top students.
abstract class ShopDashboard
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ShopDashboard._({
    required this.shop,
    required this.activeOffers,
    required this.claimsThisWeek,
    required this.estimatedReach,
    required this.estimatedValueTl,
    required this.recent,
    required this.topStudents,
    required this.rating,
    required this.reviews,
    required this.gifts,
  });

  factory ShopDashboard({
    required _isgf2ncs.Shop shop,
    required int activeOffers,
    required int claimsThisWeek,
    required int estimatedReach,
    required int estimatedValueTl,
    required List<_i48lh927.ClaimView> recent,
    required List<_iub4wqas.TopStudent> topStudents,
    required _i7zra0pp.ShopRating rating,
    required List<_itqm5y01.Review> reviews,
    required _iglfqzwp.GiftShopStats gifts,
  }) = _ShopDashboardImpl;

  factory ShopDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopDashboard(
      shop: _iegszk5h.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      activeOffers: jsonSerialization['activeOffers'] as int,
      claimsThisWeek: jsonSerialization['claimsThisWeek'] as int,
      estimatedReach: jsonSerialization['estimatedReach'] as int,
      estimatedValueTl: jsonSerialization['estimatedValueTl'] as int,
      recent: _iegszk5h.Protocol().deserialize<List<_i48lh927.ClaimView>>(
        jsonSerialization['recent'],
      ),
      topStudents: _iegszk5h.Protocol().deserialize<List<_iub4wqas.TopStudent>>(
        jsonSerialization['topStudents'],
      ),
      rating: _iegszk5h.Protocol().deserialize<_i7zra0pp.ShopRating>(
        jsonSerialization['rating'],
      ),
      reviews: _iegszk5h.Protocol().deserialize<List<_itqm5y01.Review>>(
        jsonSerialization['reviews'],
      ),
      gifts: _iegszk5h.Protocol().deserialize<_iglfqzwp.GiftShopStats>(
        jsonSerialization['gifts'],
      ),
    );
  }

  _isgf2ncs.Shop shop;

  int activeOffers;

  int claimsThisWeek;

  int estimatedReach;

  int estimatedValueTl;

  List<_i48lh927.ClaimView> recent;

  List<_iub4wqas.TopStudent> topStudents;

  _i7zra0pp.ShopRating rating;

  /// Newest first, with private notes.
  List<_itqm5y01.Review> reviews;

  _iglfqzwp.GiftShopStats gifts;

  /// Returns a shallow copy of this [ShopDashboard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShopDashboard copyWith({
    _isgf2ncs.Shop? shop,
    int? activeOffers,
    int? claimsThisWeek,
    int? estimatedReach,
    int? estimatedValueTl,
    List<_i48lh927.ClaimView>? recent,
    List<_iub4wqas.TopStudent>? topStudents,
    _i7zra0pp.ShopRating? rating,
    List<_itqm5y01.Review>? reviews,
    _iglfqzwp.GiftShopStats? gifts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopDashboard',
      'shop': shop.toJson(),
      'activeOffers': activeOffers,
      'claimsThisWeek': claimsThisWeek,
      'estimatedReach': estimatedReach,
      'estimatedValueTl': estimatedValueTl,
      'recent': recent.toJson(valueToJson: (v) => v.toJson()),
      'topStudents': topStudents.toJson(valueToJson: (v) => v.toJson()),
      'rating': rating.toJson(),
      'reviews': reviews.toJson(valueToJson: (v) => v.toJson()),
      'gifts': gifts.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopDashboard',
      'shop': shop.toJsonForProtocol(),
      'activeOffers': activeOffers,
      'claimsThisWeek': claimsThisWeek,
      'estimatedReach': estimatedReach,
      'estimatedValueTl': estimatedValueTl,
      'recent': recent.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'topStudents': topStudents.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'rating': rating.toJsonForProtocol(),
      'reviews': reviews.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'gifts': gifts.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ShopDashboardImpl extends ShopDashboard {
  _ShopDashboardImpl({
    required _isgf2ncs.Shop shop,
    required int activeOffers,
    required int claimsThisWeek,
    required int estimatedReach,
    required int estimatedValueTl,
    required List<_i48lh927.ClaimView> recent,
    required List<_iub4wqas.TopStudent> topStudents,
    required _i7zra0pp.ShopRating rating,
    required List<_itqm5y01.Review> reviews,
    required _iglfqzwp.GiftShopStats gifts,
  }) : super._(
         shop: shop,
         activeOffers: activeOffers,
         claimsThisWeek: claimsThisWeek,
         estimatedReach: estimatedReach,
         estimatedValueTl: estimatedValueTl,
         recent: recent,
         topStudents: topStudents,
         rating: rating,
         reviews: reviews,
         gifts: gifts,
       );

  /// Returns a shallow copy of this [ShopDashboard]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShopDashboard copyWith({
    _isgf2ncs.Shop? shop,
    int? activeOffers,
    int? claimsThisWeek,
    int? estimatedReach,
    int? estimatedValueTl,
    List<_i48lh927.ClaimView>? recent,
    List<_iub4wqas.TopStudent>? topStudents,
    _i7zra0pp.ShopRating? rating,
    List<_itqm5y01.Review>? reviews,
    _iglfqzwp.GiftShopStats? gifts,
  }) {
    return ShopDashboard(
      shop: shop ?? this.shop.copyWith(),
      activeOffers: activeOffers ?? this.activeOffers,
      claimsThisWeek: claimsThisWeek ?? this.claimsThisWeek,
      estimatedReach: estimatedReach ?? this.estimatedReach,
      estimatedValueTl: estimatedValueTl ?? this.estimatedValueTl,
      recent: recent ?? this.recent.map((e0) => e0.copyWith()).toList(),
      topStudents:
          topStudents ?? this.topStudents.map((e0) => e0.copyWith()).toList(),
      rating: rating ?? this.rating.copyWith(),
      reviews: reviews ?? this.reviews.map((e0) => e0.copyWith()).toList(),
      gifts: gifts ?? this.gifts.copyWith(),
    );
  }
}
