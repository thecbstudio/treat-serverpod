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
import 'badge_id.dart' as _i14xwlyb;
import 'shop.dart' as _isgf2ncs;
import 'student_profile.dart' as _iovtxv26;
import 'user_role.dart' as _ir0y0iu6;

/// The signed-in user. `role` is null until onboarding picks one.
abstract class Me implements _is.SerializableModel, _is.ProtocolSerialization {
  Me._({
    required this.email,
    this.role,
    this.student,
    this.shop,
    required this.badges,
    required this.streakWeeks,
  });

  factory Me({
    required String email,
    _ir0y0iu6.UserRole? role,
    _iovtxv26.StudentProfile? student,
    _isgf2ncs.Shop? shop,
    required List<_i14xwlyb.BadgeId> badges,
    required int streakWeeks,
  }) = _MeImpl;

  factory Me.fromJson(Map<String, dynamic> jsonSerialization) {
    return Me(
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] == null
          ? null
          : _ir0y0iu6.UserRole.fromJson((jsonSerialization['role'] as String)),
      student: jsonSerialization['student'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['student'],
            ),
      shop: jsonSerialization['shop'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_isgf2ncs.Shop>(
              jsonSerialization['shop'],
            ),
      badges: _iegszk5h.Protocol().deserialize<List<_i14xwlyb.BadgeId>>(
        jsonSerialization['badges'],
      ),
      streakWeeks: jsonSerialization['streakWeeks'] as int,
    );
  }

  String email;

  _ir0y0iu6.UserRole? role;

  _iovtxv26.StudentProfile? student;

  _isgf2ncs.Shop? shop;

  List<_i14xwlyb.BadgeId> badges;

  int streakWeeks;

  /// Returns a shallow copy of this [Me]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Me copyWith({
    String? email,
    _ir0y0iu6.UserRole? role,
    _iovtxv26.StudentProfile? student,
    _isgf2ncs.Shop? shop,
    List<_i14xwlyb.BadgeId>? badges,
    int? streakWeeks,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Me',
      'email': email,
      if (role != null) 'role': role?.toJson(),
      if (student != null) 'student': student?.toJson(),
      if (shop != null) 'shop': shop?.toJson(),
      'badges': badges.toJson(valueToJson: (v) => v.toJson()),
      'streakWeeks': streakWeeks,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Me',
      'email': email,
      if (role != null) 'role': role?.toJson(),
      if (student != null) 'student': student?.toJsonForProtocol(),
      if (shop != null) 'shop': shop?.toJsonForProtocol(),
      'badges': badges.toJson(valueToJson: (v) => v.toJson()),
      'streakWeeks': streakWeeks,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MeImpl extends Me {
  _MeImpl({
    required String email,
    _ir0y0iu6.UserRole? role,
    _iovtxv26.StudentProfile? student,
    _isgf2ncs.Shop? shop,
    required List<_i14xwlyb.BadgeId> badges,
    required int streakWeeks,
  }) : super._(
         email: email,
         role: role,
         student: student,
         shop: shop,
         badges: badges,
         streakWeeks: streakWeeks,
       );

  /// Returns a shallow copy of this [Me]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Me copyWith({
    String? email,
    Object? role = _Undefined,
    Object? student = _Undefined,
    Object? shop = _Undefined,
    List<_i14xwlyb.BadgeId>? badges,
    int? streakWeeks,
  }) {
    return Me(
      email: email ?? this.email,
      role: role is _ir0y0iu6.UserRole? ? role : this.role,
      student: student is _iovtxv26.StudentProfile?
          ? student
          : this.student?.copyWith(),
      shop: shop is _isgf2ncs.Shop? ? shop : this.shop?.copyWith(),
      badges: badges ?? this.badges.map((e0) => e0).toList(),
      streakWeeks: streakWeeks ?? this.streakWeeks,
    );
  }
}
