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

/// A place's gift money, for its panel. "To pay out" = redeemed, net of the
/// 15 % commission; "waiting" = paid gifts not collected yet.
abstract class GiftShopStats
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  GiftShopStats._({
    required this.redeemed,
    required this.netRedeemedTl,
    required this.waiting,
    required this.waitingNetTl,
  });

  factory GiftShopStats({
    required int redeemed,
    required double netRedeemedTl,
    required int waiting,
    required double waitingNetTl,
  }) = _GiftShopStatsImpl;

  factory GiftShopStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return GiftShopStats(
      redeemed: jsonSerialization['redeemed'] as int,
      netRedeemedTl: (jsonSerialization['netRedeemedTl'] as num).toDouble(),
      waiting: jsonSerialization['waiting'] as int,
      waitingNetTl: (jsonSerialization['waitingNetTl'] as num).toDouble(),
    );
  }

  int redeemed;

  double netRedeemedTl;

  int waiting;

  double waitingNetTl;

  /// Returns a shallow copy of this [GiftShopStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  GiftShopStats copyWith({
    int? redeemed,
    double? netRedeemedTl,
    int? waiting,
    double? waitingNetTl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GiftShopStats',
      'redeemed': redeemed,
      'netRedeemedTl': netRedeemedTl,
      'waiting': waiting,
      'waitingNetTl': waitingNetTl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GiftShopStats',
      'redeemed': redeemed,
      'netRedeemedTl': netRedeemedTl,
      'waiting': waiting,
      'waitingNetTl': waitingNetTl,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _GiftShopStatsImpl extends GiftShopStats {
  _GiftShopStatsImpl({
    required int redeemed,
    required double netRedeemedTl,
    required int waiting,
    required double waitingNetTl,
  }) : super._(
         redeemed: redeemed,
         netRedeemedTl: netRedeemedTl,
         waiting: waiting,
         waitingNetTl: waitingNetTl,
       );

  /// Returns a shallow copy of this [GiftShopStats]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  GiftShopStats copyWith({
    int? redeemed,
    double? netRedeemedTl,
    int? waiting,
    double? waitingNetTl,
  }) {
    return GiftShopStats(
      redeemed: redeemed ?? this.redeemed,
      netRedeemedTl: netRedeemedTl ?? this.netRedeemedTl,
      waiting: waiting ?? this.waiting,
      waitingNetTl: waitingNetTl ?? this.waitingNetTl,
    );
  }
}
