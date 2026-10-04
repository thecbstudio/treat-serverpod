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

/// awaitingPayment: the checkout page is open. pending: paid, waiting at the
/// place. cancelled/expired: closed, money goes back to the sender.
enum GiftStatus implements _is.SerializableModel {
  awaitingPayment,
  pending,
  redeemed,
  cancelled,
  expired,
  paymentFailed;

  static GiftStatus fromJson(String name) {
    switch (name) {
      case 'awaitingPayment':
        return GiftStatus.awaitingPayment;
      case 'pending':
        return GiftStatus.pending;
      case 'redeemed':
        return GiftStatus.redeemed;
      case 'cancelled':
        return GiftStatus.cancelled;
      case 'expired':
        return GiftStatus.expired;
      case 'paymentFailed':
        return GiftStatus.paymentFailed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "GiftStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
