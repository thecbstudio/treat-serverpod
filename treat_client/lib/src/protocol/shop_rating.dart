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

/// A place's treat score: ratings from students who were scanned in there.
abstract class ShopRating
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopRating._({
    required this.average,
    required this.count,
    required this.distribution,
  });

  factory ShopRating({
    required double average,
    required int count,
    required List<int> distribution,
  }) = _ShopRatingImpl;

  factory ShopRating.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopRating(
      average: (jsonSerialization['average'] as num).toDouble(),
      count: jsonSerialization['count'] as int,
      distribution: _iu07tsrf.Protocol().deserialize<List<int>>(
        jsonSerialization['distribution'],
      ),
    );
  }

  /// 0 when there are no ratings yet.
  double average;

  int count;

  /// How many 1★ … 5★ ratings (index 0 = 1★).
  List<int> distribution;

  /// Returns a shallow copy of this [ShopRating]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopRating copyWith({
    double? average,
    int? count,
    List<int>? distribution,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopRating',
      'average': average,
      'count': count,
      'distribution': distribution.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopRating',
      'average': average,
      'count': count,
      'distribution': distribution.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ShopRatingImpl extends ShopRating {
  _ShopRatingImpl({
    required double average,
    required int count,
    required List<int> distribution,
  }) : super._(
         average: average,
         count: count,
         distribution: distribution,
       );

  /// Returns a shallow copy of this [ShopRating]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopRating copyWith({
    double? average,
    int? count,
    List<int>? distribution,
  }) {
    return ShopRating(
      average: average ?? this.average,
      count: count ?? this.count,
      distribution: distribution ?? this.distribution.map((e0) => e0).toList(),
    );
  }
}
