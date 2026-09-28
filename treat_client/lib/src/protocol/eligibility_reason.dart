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

/// Checked in this order by `eligibilityOf` (see domain/rules.dart).
enum EligibilityReason implements _isc.SerializableModel {
  ok,
  offerInactive,
  notVerified,
  tooManyStrikes,
  activeClaim,
  frequency,
  outsideHours,
  totalCap,
  dailyCap,
  dropEnded,
  alreadyClaimed;

  static EligibilityReason fromJson(String name) {
    switch (name) {
      case 'ok':
        return EligibilityReason.ok;
      case 'offerInactive':
        return EligibilityReason.offerInactive;
      case 'notVerified':
        return EligibilityReason.notVerified;
      case 'tooManyStrikes':
        return EligibilityReason.tooManyStrikes;
      case 'activeClaim':
        return EligibilityReason.activeClaim;
      case 'frequency':
        return EligibilityReason.frequency;
      case 'outsideHours':
        return EligibilityReason.outsideHours;
      case 'totalCap':
        return EligibilityReason.totalCap;
      case 'dailyCap':
        return EligibilityReason.dailyCap;
      case 'dropEnded':
        return EligibilityReason.dropEnded;
      case 'alreadyClaimed':
        return EligibilityReason.alreadyClaimed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "EligibilityReason"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
