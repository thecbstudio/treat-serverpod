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
import 'claim_view.dart' as _i48lh927;
import 'shop.dart' as _isgf2ncs;
import 'top_student.dart' as _iub4wqas;

/// Business panel: totals, ROI estimate, recent activity, top students.
abstract class ShopDashboard
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopDashboard._({
    required this.shop,
    required this.activeOffers,
    required this.claimsThisWeek,
    required this.estimatedReach,
    required this.estimatedValueTl,
    required this.recent,
    required this.topStudents,
  });

  factory ShopDashboard({
    required _isgf2ncs.Shop shop,
    required int activeOffers,
    required int claimsThisWeek,
    required int estimatedReach,
    required int estimatedValueTl,
    required List<_i48lh927.ClaimView> recent,
    required List<_iub4wqas.TopStudent> topStudents,
  }) = _ShopDashboardImpl;

  factory ShopDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopDashboard(
      shop: _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      activeOffers: jsonSerialization['activeOffers'] as int,
      claimsThisWeek: jsonSerialization['claimsThisWeek'] as int,
      estimatedReach: jsonSerialization['estimatedReach'] as int,
      estimatedValueTl: jsonSerialization['estimatedValueTl'] as int,
      recent: _iu07tsrf.Protocol().deserialize<List<_i48lh927.ClaimView>>(
        jsonSerialization['recent'],
      ),
      topStudents: _iu07tsrf.Protocol().deserialize<List<_iub4wqas.TopStudent>>(
        jsonSerialization['topStudents'],
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

  /// Returns a shallow copy of this [ShopDashboard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopDashboard copyWith({
    _isgf2ncs.Shop? shop,
    int? activeOffers,
    int? claimsThisWeek,
    int? estimatedReach,
    int? estimatedValueTl,
    List<_i48lh927.ClaimView>? recent,
    List<_iub4wqas.TopStudent>? topStudents,
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
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  }) : super._(
         shop: shop,
         activeOffers: activeOffers,
         claimsThisWeek: claimsThisWeek,
         estimatedReach: estimatedReach,
         estimatedValueTl: estimatedValueTl,
         recent: recent,
         topStudents: topStudents,
       );

  /// Returns a shallow copy of this [ShopDashboard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopDashboard copyWith({
    _isgf2ncs.Shop? shop,
    int? activeOffers,
    int? claimsThisWeek,
    int? estimatedReach,
    int? estimatedValueTl,
    List<_i48lh927.ClaimView>? recent,
    List<_iub4wqas.TopStudent>? topStudents,
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
    );
  }
}
