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
import 'gift.dart' as _ihguimva;

/// Result of scanning a code. `alreadyRedeemed`: this exact claim was already
/// redeemed by this shop (double scan) — nothing was counted twice.
abstract class RedeemResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RedeemResult._({
    this.view,
    this.gift,
    required this.alreadyRedeemed,
  });

  factory RedeemResult({
    _i48lh927.ClaimView? view,
    _ihguimva.Gift? gift,
    required bool alreadyRedeemed,
  }) = _RedeemResultImpl;

  factory RedeemResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedeemResult(
      view: jsonSerialization['view'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_i48lh927.ClaimView>(
              jsonSerialization['view'],
            ),
      gift: jsonSerialization['gift'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_ihguimva.Gift>(
              jsonSerialization['gift'],
            ),
      alreadyRedeemed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['alreadyRedeemed'],
      ),
    );
  }

  /// A treat claim ...
  _i48lh927.ClaimView? view;

  /// ... or a paid gift (exactly one of the two).
  _ihguimva.Gift? gift;

  bool alreadyRedeemed;

  /// Returns a shallow copy of this [RedeemResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RedeemResult copyWith({
    _i48lh927.ClaimView? view,
    _ihguimva.Gift? gift,
    bool? alreadyRedeemed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedeemResult',
      if (view != null) 'view': view?.toJson(),
      if (gift != null) 'gift': gift?.toJson(),
      'alreadyRedeemed': alreadyRedeemed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RedeemResult',
      if (view != null) 'view': view?.toJsonForProtocol(),
      if (gift != null) 'gift': gift?.toJsonForProtocol(),
      'alreadyRedeemed': alreadyRedeemed,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RedeemResultImpl extends RedeemResult {
  _RedeemResultImpl({
    _i48lh927.ClaimView? view,
    _ihguimva.Gift? gift,
    required bool alreadyRedeemed,
  }) : super._(
         view: view,
         gift: gift,
         alreadyRedeemed: alreadyRedeemed,
       );

  /// Returns a shallow copy of this [RedeemResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RedeemResult copyWith({
    Object? view = _Undefined,
    Object? gift = _Undefined,
    bool? alreadyRedeemed,
  }) {
    return RedeemResult(
      view: view is _i48lh927.ClaimView? ? view : this.view?.copyWith(),
      gift: gift is _ihguimva.Gift? ? gift : this.gift?.copyWith(),
      alreadyRedeemed: alreadyRedeemed ?? this.alreadyRedeemed,
    );
  }
}
