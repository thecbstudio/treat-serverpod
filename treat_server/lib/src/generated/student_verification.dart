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

enum StudentVerification implements _is.SerializableModel {
  verified,
  pending,
  rejected;

  static StudentVerification fromJson(String name) {
    switch (name) {
      case 'verified':
        return StudentVerification.verified;
      case 'pending':
        return StudentVerification.pending;
      case 'rejected':
        return StudentVerification.rejected;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "StudentVerification"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
