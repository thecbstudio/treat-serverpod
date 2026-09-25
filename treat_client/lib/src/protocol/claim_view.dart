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
import 'claim.dart' as _iywv5oz4;
import 'offer.dart' as _iqlmmtnc;
import 'shop.dart' as _isgf2ncs;

/// A claim with the offer and shop it belongs to (student screens, scan result).
abstract class ClaimView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClaimView._({
    required this.claim,
    required this.offer,
    required this.shop,
  });

  factory ClaimView({
    required _iywv5oz4.Claim claim,
    required _iqlmmtnc.Offer offer,
    required _isgf2ncs.Shop shop,
  }) = _ClaimViewImpl;

  factory ClaimView.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClaimView(
      claim: _iu07tsrf.Protocol().deserialize<_iywv5oz4.Claim>(
        jsonSerialization['claim'],
      ),
      offer: _iu07tsrf.Protocol().deserialize<_iqlmmtnc.Offer>(
        jsonSerialization['offer'],
      ),
      shop: _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
    );
  }

  _iywv5oz4.Claim claim;

  _iqlmmtnc.Offer offer;

  _isgf2ncs.Shop shop;

  /// Returns a shallow copy of this [ClaimView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClaimView copyWith({
    _iywv5oz4.Claim? claim,
    _iqlmmtnc.Offer? offer,
    _isgf2ncs.Shop? shop,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClaimView',
      'claim': claim.toJson(),
      'offer': offer.toJson(),
      'shop': shop.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClaimView',
      'claim': claim.toJsonForProtocol(),
      'offer': offer.toJsonForProtocol(),
      'shop': shop.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ClaimViewImpl extends ClaimView {
  _ClaimViewImpl({
    required _iywv5oz4.Claim claim,
    required _iqlmmtnc.Offer offer,
    required _isgf2ncs.Shop shop,
  }) : super._(
         claim: claim,
         offer: offer,
         shop: shop,
       );

  /// Returns a shallow copy of this [ClaimView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClaimView copyWith({
    _iywv5oz4.Claim? claim,
    _iqlmmtnc.Offer? offer,
    _isgf2ncs.Shop? shop,
  }) {
    return ClaimView(
      claim: claim ?? this.claim.copyWith(),
      offer: offer ?? this.offer.copyWith(),
      shop: shop ?? this.shop.copyWith(),
    );
  }
}
