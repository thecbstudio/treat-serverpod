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
import 'badge_id.dart' as _i14xwlyb;
import 'wall_post.dart' as _i6mr85kx;

/// A student's public profile — no email, no strikes.
abstract class PublicStudent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PublicStudent._({
    required this.id,
    required this.name,
    required this.university,
    required this.treats,
    required this.streakWeeks,
    required this.badges,
    required this.joinedAt,
    required this.wall,
  });

  factory PublicStudent({
    required int id,
    required String name,
    required String university,
    required int treats,
    required int streakWeeks,
    required List<_i14xwlyb.BadgeId> badges,
    required DateTime joinedAt,
    required List<_i6mr85kx.WallPost> wall,
  }) = _PublicStudentImpl;

  factory PublicStudent.fromJson(Map<String, dynamic> jsonSerialization) {
    return PublicStudent(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      university: jsonSerialization['university'] as String,
      treats: jsonSerialization['treats'] as int,
      streakWeeks: jsonSerialization['streakWeeks'] as int,
      badges: _iu07tsrf.Protocol().deserialize<List<_i14xwlyb.BadgeId>>(
        jsonSerialization['badges'],
      ),
      joinedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      wall: _iu07tsrf.Protocol().deserialize<List<_i6mr85kx.WallPost>>(
        jsonSerialization['wall'],
      ),
    );
  }

  int id;

  String name;

  String university;

  int treats;

  int streakWeeks;

  List<_i14xwlyb.BadgeId> badges;

  DateTime joinedAt;

  List<_i6mr85kx.WallPost> wall;

  /// Returns a shallow copy of this [PublicStudent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PublicStudent copyWith({
    int? id,
    String? name,
    String? university,
    int? treats,
    int? streakWeeks,
    List<_i14xwlyb.BadgeId>? badges,
    DateTime? joinedAt,
    List<_i6mr85kx.WallPost>? wall,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PublicStudent',
      'id': id,
      'name': name,
      'university': university,
      'treats': treats,
      'streakWeeks': streakWeeks,
      'badges': badges.toJson(valueToJson: (v) => v.toJson()),
      'joinedAt': joinedAt.toJson(),
      'wall': wall.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PublicStudent',
      'id': id,
      'name': name,
      'university': university,
      'treats': treats,
      'streakWeeks': streakWeeks,
      'badges': badges.toJson(valueToJson: (v) => v.toJson()),
      'joinedAt': joinedAt.toJson(),
      'wall': wall.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PublicStudentImpl extends PublicStudent {
  _PublicStudentImpl({
    required int id,
    required String name,
    required String university,
    required int treats,
    required int streakWeeks,
    required List<_i14xwlyb.BadgeId> badges,
    required DateTime joinedAt,
    required List<_i6mr85kx.WallPost> wall,
  }) : super._(
         id: id,
         name: name,
         university: university,
         treats: treats,
         streakWeeks: streakWeeks,
         badges: badges,
         joinedAt: joinedAt,
         wall: wall,
       );

  /// Returns a shallow copy of this [PublicStudent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PublicStudent copyWith({
    int? id,
    String? name,
    String? university,
    int? treats,
    int? streakWeeks,
    List<_i14xwlyb.BadgeId>? badges,
    DateTime? joinedAt,
    List<_i6mr85kx.WallPost>? wall,
  }) {
    return PublicStudent(
      id: id ?? this.id,
      name: name ?? this.name,
      university: university ?? this.university,
      treats: treats ?? this.treats,
      streakWeeks: streakWeeks ?? this.streakWeeks,
      badges: badges ?? this.badges.map((e0) => e0).toList(),
      joinedAt: joinedAt ?? this.joinedAt,
      wall: wall ?? this.wall.map((e0) => e0.copyWith()).toList(),
    );
  }
}
