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
import 'eligibility.dart' as _iapxm79h;
import 'offer.dart' as _iqlmmtnc;
import 'shop.dart' as _isgf2ncs;

/// An offer with its shop, today's usage and (for students) eligibility.
abstract class OfferCard
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  OfferCard._({
    required this.offer,
    required this.shop,
    required this.claimedToday,
    required this.claimedTotal,
    this.eligibility,
  });

  factory OfferCard({
    required _iqlmmtnc.Offer offer,
    required _isgf2ncs.Shop shop,
    required int claimedToday,
    required int claimedTotal,
    _iapxm79h.Eligibility? eligibility,
  }) = _OfferCardImpl;

  factory OfferCard.fromJson(Map<String, dynamic> jsonSerialization) {
    return OfferCard(
      offer: _iu07tsrf.Protocol().deserialize<_iqlmmtnc.Offer>(
        jsonSerialization['offer'],
      ),
      shop: _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      claimedToday: jsonSerialization['claimedToday'] as int,
      claimedTotal: jsonSerialization['claimedTotal'] as int,
      eligibility: jsonSerialization['eligibility'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iapxm79h.Eligibility>(
              jsonSerialization['eligibility'],
            ),
    );
  }

  _iqlmmtnc.Offer offer;

  _isgf2ncs.Shop shop;

  int claimedToday;

  int claimedTotal;

  _iapxm79h.Eligibility? eligibility;

  /// Returns a shallow copy of this [OfferCard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  OfferCard copyWith({
    _iqlmmtnc.Offer? offer,
    _isgf2ncs.Shop? shop,
    int? claimedToday,
    int? claimedTotal,
    _iapxm79h.Eligibility? eligibility,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OfferCard',
      'offer': offer.toJson(),
      'shop': shop.toJson(),
      'claimedToday': claimedToday,
      'claimedTotal': claimedTotal,
      if (eligibility != null) 'eligibility': eligibility?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OfferCard',
      'offer': offer.toJsonForProtocol(),
      'shop': shop.toJsonForProtocol(),
      'claimedToday': claimedToday,
      'claimedTotal': claimedTotal,
      if (eligibility != null) 'eligibility': eligibility?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfferCardImpl extends OfferCard {
  _OfferCardImpl({
    required _iqlmmtnc.Offer offer,
    required _isgf2ncs.Shop shop,
    required int claimedToday,
    required int claimedTotal,
    _iapxm79h.Eligibility? eligibility,
  }) : super._(
         offer: offer,
         shop: shop,
         claimedToday: claimedToday,
         claimedTotal: claimedTotal,
         eligibility: eligibility,
       );

  /// Returns a shallow copy of this [OfferCard]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  OfferCard copyWith({
    _iqlmmtnc.Offer? offer,
    _isgf2ncs.Shop? shop,
    int? claimedToday,
    int? claimedTotal,
    Object? eligibility = _Undefined,
  }) {
    return OfferCard(
      offer: offer ?? this.offer.copyWith(),
      shop: shop ?? this.shop.copyWith(),
      claimedToday: claimedToday ?? this.claimedToday,
      claimedTotal: claimedTotal ?? this.claimedTotal,
      eligibility: eligibility is _iapxm79h.Eligibility?
          ? eligibility
          : this.eligibility?.copyWith(),
    );
  }
}
