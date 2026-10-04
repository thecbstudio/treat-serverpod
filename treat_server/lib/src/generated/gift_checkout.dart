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
import 'gift.dart' as _ihguimva;

/// A new gift and where to pay for it (iyzico's hosted checkout page).
abstract class GiftCheckout
    implements _is.SerializableModel, _is.ProtocolSerialization {
  GiftCheckout._({
    required this.gift,
    required this.paymentPageUrl,
  });

  factory GiftCheckout({
    required _ihguimva.Gift gift,
    required String paymentPageUrl,
  }) = _GiftCheckoutImpl;

  factory GiftCheckout.fromJson(Map<String, dynamic> jsonSerialization) {
    return GiftCheckout(
      gift: _iegszk5h.Protocol().deserialize<_ihguimva.Gift>(
        jsonSerialization['gift'],
      ),
      paymentPageUrl: jsonSerialization['paymentPageUrl'] as String,
    );
  }

  _ihguimva.Gift gift;

  String paymentPageUrl;

  /// Returns a shallow copy of this [GiftCheckout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  GiftCheckout copyWith({
    _ihguimva.Gift? gift,
    String? paymentPageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GiftCheckout',
      'gift': gift.toJson(),
      'paymentPageUrl': paymentPageUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GiftCheckout',
      'gift': gift.toJsonForProtocol(),
      'paymentPageUrl': paymentPageUrl,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _GiftCheckoutImpl extends GiftCheckout {
  _GiftCheckoutImpl({
    required _ihguimva.Gift gift,
    required String paymentPageUrl,
  }) : super._(
         gift: gift,
         paymentPageUrl: paymentPageUrl,
       );

  /// Returns a shallow copy of this [GiftCheckout]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  GiftCheckout copyWith({
    _ihguimva.Gift? gift,
    String? paymentPageUrl,
  }) {
    return GiftCheckout(
      gift: gift ?? this.gift.copyWith(),
      paymentPageUrl: paymentPageUrl ?? this.paymentPageUrl,
    );
  }
}
