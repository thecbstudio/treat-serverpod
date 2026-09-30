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
import 'report_kind.dart' as _imx1jrz0;
import 'report_reason.dart' as _ijgj7dn0;

/// A user flagging public content. Reviews and wall posts are hidden once
/// enough different users reported them; places are only recorded for
/// review (two accounts must not be able to take a business off the app).
abstract class Report
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Report._({
    this.id,
    required this.reporterId,
    this.reporter,
    required this.kind,
    required this.targetId,
    required this.reason,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Report({
    int? id,
    required _isc.UuidValue reporterId,
    _iacc.AuthUser? reporter,
    required _imx1jrz0.ReportKind kind,
    required int targetId,
    required _ijgj7dn0.ReportReason reason,
    DateTime? createdAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reporterId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['reporterId'],
      ),
      reporter: jsonSerialization['reporter'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['reporter'],
            ),
      kind: _imx1jrz0.ReportKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      targetId: jsonSerialization['targetId'] as int,
      reason: _ijgj7dn0.ReportReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue reporterId;

  _iacc.AuthUser? reporter;

  _imx1jrz0.ReportKind kind;

  int targetId;

  _ijgj7dn0.ReportReason reason;

  DateTime createdAt;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Report copyWith({
    int? id,
    _isc.UuidValue? reporterId,
    _iacc.AuthUser? reporter,
    _imx1jrz0.ReportKind? kind,
    int? targetId,
    _ijgj7dn0.ReportReason? reason,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'reporterId': reporterId.toJson(),
      if (reporter != null) 'reporter': reporter?.toJson(),
      'kind': kind.toJson(),
      'targetId': targetId,
      'reason': reason.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Report',
      if (id != null) 'id': id,
      'reporterId': reporterId.toJson(),
      if (reporter != null) 'reporter': reporter?.toJson(),
      'kind': kind.toJson(),
      'targetId': targetId,
      'reason': reason.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required _isc.UuidValue reporterId,
    _iacc.AuthUser? reporter,
    required _imx1jrz0.ReportKind kind,
    required int targetId,
    required _ijgj7dn0.ReportReason reason,
    DateTime? createdAt,
  }) : super._(
         id: id,
         reporterId: reporterId,
         reporter: reporter,
         kind: kind,
         targetId: targetId,
         reason: reason,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? reporterId,
    Object? reporter = _Undefined,
    _imx1jrz0.ReportKind? kind,
    int? targetId,
    _ijgj7dn0.ReportReason? reason,
    DateTime? createdAt,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      reporter: reporter is _iacc.AuthUser?
          ? reporter
          : this.reporter?.copyWith(),
      kind: kind ?? this.kind,
      targetId: targetId ?? this.targetId,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
