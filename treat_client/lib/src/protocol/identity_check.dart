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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/protocol.dart' as _iu07tsrf;
import 'check_status.dart' as _i152b260;
import 'verification_kind.dart' as _ikt935kv;

/// One AI check of a student card or business document. The photo is
/// deleted as soon as there is a verdict; only the result stays.
abstract class IdentityCheck
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  IdentityCheck._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.kind,
    required this.status,
    this.reason,
    int? attempts,
    DateTime? createdAt,
    this.decidedAt,
  }) : attempts = attempts ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory IdentityCheck({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required _ikt935kv.VerificationKind kind,
    required _i152b260.CheckStatus status,
    String? reason,
    int? attempts,
    DateTime? createdAt,
    DateTime? decidedAt,
  }) = _IdentityCheckImpl;

  factory IdentityCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return IdentityCheck(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      kind: _ikt935kv.VerificationKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      status: _i152b260.CheckStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      reason: jsonSerialization['reason'] as String?,
      attempts: jsonSerialization['attempts'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  _ikt935kv.VerificationKind kind;

  _i152b260.CheckStatus status;

  /// not_a_student_card | not_a_business_document | name_mismatch |
  /// school_mismatch | expired | unreadable | verify_failed
  String? reason;

  int attempts;

  DateTime createdAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [IdentityCheck]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  IdentityCheck copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    _ikt935kv.VerificationKind? kind,
    _i152b260.CheckStatus? status,
    String? reason,
    int? attempts,
    DateTime? createdAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IdentityCheck',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'kind': kind.toJson(),
      'status': status.toJson(),
      if (reason != null) 'reason': reason,
      'attempts': attempts,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IdentityCheck',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'kind': kind.toJson(),
      'status': status.toJson(),
      if (reason != null) 'reason': reason,
      'attempts': attempts,
      'createdAt': createdAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IdentityCheckImpl extends IdentityCheck {
  _IdentityCheckImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required _ikt935kv.VerificationKind kind,
    required _i152b260.CheckStatus status,
    String? reason,
    int? attempts,
    DateTime? createdAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         kind: kind,
         status: status,
         reason: reason,
         attempts: attempts,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [IdentityCheck]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  IdentityCheck copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _ikt935kv.VerificationKind? kind,
    _i152b260.CheckStatus? status,
    Object? reason = _Undefined,
    int? attempts,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return IdentityCheck(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      kind: kind ?? this.kind,
      status: status ?? this.status,
      reason: reason is String? ? reason : this.reason,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
