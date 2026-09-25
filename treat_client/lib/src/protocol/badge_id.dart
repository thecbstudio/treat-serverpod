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

enum BadgeId implements _isc.SerializableModel {
  firstTreat,
  tenTreats,
  twentyfiveTreats,
  streak4,
  explorer3,
  verifiedStudent;

  static BadgeId fromJson(String name) {
    switch (name) {
      case 'firstTreat':
        return BadgeId.firstTreat;
      case 'tenTreats':
        return BadgeId.tenTreats;
      case 'twentyfiveTreats':
        return BadgeId.twentyfiveTreats;
      case 'streak4':
        return BadgeId.streak4;
      case 'explorer3':
        return BadgeId.explorer3;
      case 'verifiedStudent':
        return BadgeId.verifiedStudent;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "BadgeId"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
