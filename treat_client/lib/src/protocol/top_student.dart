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

abstract class TopStudent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TopStudent._({
    required this.name,
    required this.university,
    required this.approved,
  });

  factory TopStudent({
    required String name,
    required String university,
    required int approved,
  }) = _TopStudentImpl;

  factory TopStudent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopStudent(
      name: jsonSerialization['name'] as String,
      university: jsonSerialization['university'] as String,
      approved: jsonSerialization['approved'] as int,
    );
  }

  String name;

  String university;

  int approved;

  /// Returns a shallow copy of this [TopStudent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TopStudent copyWith({
    String? name,
    String? university,
    int? approved,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopStudent',
      'name': name,
      'university': university,
      'approved': approved,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopStudent',
      'name': name,
      'university': university,
      'approved': approved,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _TopStudentImpl extends TopStudent {
  _TopStudentImpl({
    required String name,
    required String university,
    required int approved,
  }) : super._(
         name: name,
         university: university,
         approved: approved,
       );

  /// Returns a shallow copy of this [TopStudent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TopStudent copyWith({
    String? name,
    String? university,
    int? approved,
  }) {
    return TopStudent(
      name: name ?? this.name,
      university: university ?? this.university,
      approved: approved ?? this.approved,
    );
  }
}
