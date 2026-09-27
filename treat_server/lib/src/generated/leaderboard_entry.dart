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

/// Public leaderboard row — never includes email.
abstract class LeaderboardEntry
    implements _is.SerializableModel, _is.ProtocolSerialization {
  LeaderboardEntry._({
    required this.rank,
    required this.name,
    required this.university,
    required this.treats,
    required this.isMe,
  });

  factory LeaderboardEntry({
    required int rank,
    required String name,
    required String university,
    required int treats,
    required bool isMe,
  }) = _LeaderboardEntryImpl;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return LeaderboardEntry(
      rank: jsonSerialization['rank'] as int,
      name: jsonSerialization['name'] as String,
      university: jsonSerialization['university'] as String,
      treats: jsonSerialization['treats'] as int,
      isMe: _is.BoolJsonExtension.fromJson(jsonSerialization['isMe']),
    );
  }

  int rank;

  String name;

  String university;

  int treats;

  bool isMe;

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  LeaderboardEntry copyWith({
    int? rank,
    String? name,
    String? university,
    int? treats,
    bool? isMe,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'name': name,
      'university': university,
      'treats': treats,
      'isMe': isMe,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeaderboardEntry',
      'rank': rank,
      'name': name,
      'university': university,
      'treats': treats,
      'isMe': isMe,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _LeaderboardEntryImpl extends LeaderboardEntry {
  _LeaderboardEntryImpl({
    required int rank,
    required String name,
    required String university,
    required int treats,
    required bool isMe,
  }) : super._(
         rank: rank,
         name: name,
         university: university,
         treats: treats,
         isMe: isMe,
       );

  /// Returns a shallow copy of this [LeaderboardEntry]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  LeaderboardEntry copyWith({
    int? rank,
    String? name,
    String? university,
    int? treats,
    bool? isMe,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      name: name ?? this.name,
      university: university ?? this.university,
      treats: treats ?? this.treats,
      isMe: isMe ?? this.isMe,
    );
  }
}
