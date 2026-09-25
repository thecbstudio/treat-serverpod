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

/// Result of scanning a code. `alreadyRedeemed`: this exact claim was already
/// redeemed by this shop (double scan) — nothing was counted twice.
abstract class RedeemResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RedeemResult._({
    required this.view,
    required this.alreadyRedeemed,
  });

  factory RedeemResult({
    required _i48lh927.ClaimView view,
    required bool alreadyRedeemed,
  }) = _RedeemResultImpl;

  factory RedeemResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return RedeemResult(
      view: _iu07tsrf.Protocol().deserialize<_i48lh927.ClaimView>(
        jsonSerialization['view'],
      ),
      alreadyRedeemed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['alreadyRedeemed'],
      ),
    );
  }

  _i48lh927.ClaimView view;

  bool alreadyRedeemed;

  /// Returns a shallow copy of this [RedeemResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RedeemResult copyWith({
    _i48lh927.ClaimView? view,
    bool? alreadyRedeemed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RedeemResult',
      'view': view.toJson(),
      'alreadyRedeemed': alreadyRedeemed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RedeemResult',
      'view': view.toJsonForProtocol(),
      'alreadyRedeemed': alreadyRedeemed,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RedeemResultImpl extends RedeemResult {
  _RedeemResultImpl({
    required _i48lh927.ClaimView view,
    required bool alreadyRedeemed,
  }) : super._(
         view: view,
         alreadyRedeemed: alreadyRedeemed,
       );

  /// Returns a shallow copy of this [RedeemResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RedeemResult copyWith({
    _i48lh927.ClaimView? view,
    bool? alreadyRedeemed,
  }) {
    return RedeemResult(
      view: view ?? this.view.copyWith(),
      alreadyRedeemed: alreadyRedeemed ?? this.alreadyRedeemed,
    );
  }
}
