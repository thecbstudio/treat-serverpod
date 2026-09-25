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

/// active -> redeemed -> proofPending -> approved | rejected; active -> expired.
enum ClaimStatus implements _is.SerializableModel {
  active,
  expired,
  redeemed,
  proofPending,
  approved,
  rejected;

  static ClaimStatus fromJson(String name) {
    switch (name) {
      case 'active':
        return ClaimStatus.active;
      case 'expired':
        return ClaimStatus.expired;
      case 'redeemed':
        return ClaimStatus.redeemed;
      case 'proofPending':
        return ClaimStatus.proofPending;
      case 'approved':
        return ClaimStatus.approved;
      case 'rejected':
        return ClaimStatus.rejected;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "ClaimStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
