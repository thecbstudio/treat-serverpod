/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:treat_server/src/generated/protocol.dart' as _iegszk5h;
import 'check_status.dart' as _i152b260;
import 'verification_kind.dart' as _ikt935kv;

/// One AI check of a student card or business document. The photo is
/// deleted as soon as there is a verdict; only the result stays.
abstract class IdentityCheck
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  IdentityCheck._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.kind,
    this.imagePath,
    required this.status,
    this.reason,
    int? attempts,
    DateTime? createdAt,
    this.decidedAt,
  }) : attempts = attempts ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory IdentityCheck({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _ikt935kv.VerificationKind kind,
    String? imagePath,
    required _i152b260.CheckStatus status,
    String? reason,
    int? attempts,
    DateTime? createdAt,
    DateTime? decidedAt,
  }) = _IdentityCheckImpl;

  factory IdentityCheck.fromJson(Map<String, dynamic> jsonSerialization) {
    return IdentityCheck(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      kind: _ikt935kv.VerificationKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      imagePath: jsonSerialization['imagePath'] as String?,
      status: _i152b260.CheckStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      reason: jsonSerialization['reason'] as String?,
      attempts: jsonSerialization['attempts'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = IdentityCheckTable();

  static const db = IdentityCheckRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  _ikt935kv.VerificationKind kind;

  /// Private storage; null once the photo was deleted.
  String? imagePath;

  _i152b260.CheckStatus status;

  /// not_a_student_card | not_a_business_document | name_mismatch |
  /// school_mismatch | expired | unreadable | verify_failed
  String? reason;

  int attempts;

  DateTime createdAt;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [IdentityCheck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  IdentityCheck copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    _ikt935kv.VerificationKind? kind,
    String? imagePath,
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
      if (imagePath != null) 'imagePath': imagePath,
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

  static IdentityCheckInclude include({_iacs.AuthUserInclude? authUser}) {
    return IdentityCheckInclude._(authUser: authUser);
  }

  static IdentityCheckIncludeList includeList({
    _is.WhereExpressionBuilder<IdentityCheckTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    IdentityCheckInclude? include,
  }) {
    return IdentityCheckIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IdentityCheckImpl extends IdentityCheck {
  _IdentityCheckImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required _ikt935kv.VerificationKind kind,
    String? imagePath,
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
         imagePath: imagePath,
         status: status,
         reason: reason,
         attempts: attempts,
         createdAt: createdAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [IdentityCheck]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  IdentityCheck copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _ikt935kv.VerificationKind? kind,
    Object? imagePath = _Undefined,
    _i152b260.CheckStatus? status,
    Object? reason = _Undefined,
    int? attempts,
    DateTime? createdAt,
    Object? decidedAt = _Undefined,
  }) {
    return IdentityCheck(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      kind: kind ?? this.kind,
      imagePath: imagePath is String? ? imagePath : this.imagePath,
      status: status ?? this.status,
      reason: reason is String? ? reason : this.reason,
      attempts: attempts ?? this.attempts,
      createdAt: createdAt ?? this.createdAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class IdentityCheckUpdateTable extends _is.UpdateTable<IdentityCheckTable> {
  IdentityCheckUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<_ikt935kv.VerificationKind, _ikt935kv.VerificationKind> kind(
    _ikt935kv.VerificationKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> imagePath(String? value) => _is.ColumnValue(
    table.imagePath,
    value,
  );

  _is.ColumnValue<_i152b260.CheckStatus, _i152b260.CheckStatus> status(
    _i152b260.CheckStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> reason(String? value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<int, int> attempts(int value) => _is.ColumnValue(
    table.attempts,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class IdentityCheckTable extends _is.Table<int?> {
  IdentityCheckTable({super.tableRelation})
    : super(tableName: 'identity_check') {
    updateTable = IdentityCheckUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    imagePath = _is.ColumnString(
      'imagePath',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    attempts = _is.ColumnInt(
      'attempts',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final IdentityCheckUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnEnum<_ikt935kv.VerificationKind> kind;

  /// Private storage; null once the photo was deleted.
  late final _is.ColumnString imagePath;

  late final _is.ColumnEnum<_i152b260.CheckStatus> status;

  /// not_a_student_card | not_a_business_document | name_mismatch |
  /// school_mismatch | expired | unreadable | verify_failed
  late final _is.ColumnString reason;

  late final _is.ColumnInt attempts;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime decidedAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: IdentityCheck.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    authUserId,
    kind,
    imagePath,
    status,
    reason,
    attempts,
    createdAt,
    decidedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class IdentityCheckInclude extends _is.IncludeObject {
  IdentityCheckInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => IdentityCheck.t;
}

class IdentityCheckIncludeList extends _is.IncludeList {
  IdentityCheckIncludeList._({
    _is.WhereExpressionBuilder<IdentityCheckTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IdentityCheck.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => IdentityCheck.t;
}

class IdentityCheckRepository {
  const IdentityCheckRepository._();

  final attachRow = const IdentityCheckAttachRowRepository._();

  /// Returns a list of [IdentityCheck]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<IdentityCheck>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IdentityCheckTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    _is.Transaction? transaction,
    IdentityCheckInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<IdentityCheck>(
      where: where?.call(IdentityCheck.t),
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [IdentityCheck] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<IdentityCheck?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IdentityCheckTable>? where,
    int? offset,
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    _is.Transaction? transaction,
    IdentityCheckInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<IdentityCheck>(
      where: where?.call(IdentityCheck.t),
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [IdentityCheck] by its [id] or null if no such row exists.
  Future<IdentityCheck?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    IdentityCheckInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<IdentityCheck>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [IdentityCheck]s in the list and returns the inserted rows.
  ///
  /// The returned [IdentityCheck]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> insert(
    _is.DatabaseSession session,
    List<IdentityCheck> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<IdentityCheck>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [IdentityCheck] and returns the inserted row.
  ///
  /// The returned [IdentityCheck] will have its `id` field set.
  Future<IdentityCheck> insertRow(
    _is.DatabaseSession session,
    IdentityCheck row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<IdentityCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [IdentityCheck]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [IdentityCheck]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> upsert(
    _is.DatabaseSession session,
    List<IdentityCheck> rows, {
    required _is.ColumnSelections<IdentityCheckTable> conflictColumns,
    _is.ColumnSelections<IdentityCheckTable>? updateColumns,
    _is.WhereExpressionBuilder<IdentityCheckTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<IdentityCheck>(
      rows,
      conflictColumns: conflictColumns(IdentityCheck.t),
      updateColumns: updateColumns?.call(IdentityCheck.t),
      updateWhere: updateWhere?.call(IdentityCheck.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [IdentityCheck] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [IdentityCheck] will have its `id` field set.
  Future<IdentityCheck?> upsertRow(
    _is.DatabaseSession session,
    IdentityCheck row, {
    required _is.ColumnSelections<IdentityCheckTable> conflictColumns,
    _is.ColumnSelections<IdentityCheckTable>? updateColumns,
    _is.WhereExpressionBuilder<IdentityCheckTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<IdentityCheck>(
      row,
      conflictColumns: conflictColumns(IdentityCheck.t),
      updateColumns: updateColumns?.call(IdentityCheck.t),
      updateWhere: updateWhere?.call(IdentityCheck.t),
      transaction: transaction,
    );
  }

  /// Updates all [IdentityCheck]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> update(
    _is.DatabaseSession session,
    List<IdentityCheck> rows, {
    _is.ColumnSelections<IdentityCheckTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<IdentityCheck>(
      rows,
      columns: columns?.call(IdentityCheck.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [IdentityCheck]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IdentityCheck> updateRow(
    _is.DatabaseSession session,
    IdentityCheck row, {
    _is.ColumnSelections<IdentityCheckTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<IdentityCheck>(
      row,
      columns: columns?.call(IdentityCheck.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IdentityCheck] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IdentityCheck?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<IdentityCheckUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<IdentityCheck>(
      id,
      columnValues: columnValues(IdentityCheck.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IdentityCheck]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<IdentityCheckUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<IdentityCheckTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<IdentityCheck>(
      columnValues: columnValues(IdentityCheck.t.updateTable),
      where: where(IdentityCheck.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [IdentityCheck]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> delete(
    _is.DatabaseSession session,
    List<IdentityCheck> rows, {
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<IdentityCheck>(
      rows,
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [IdentityCheck].
  Future<IdentityCheck> deleteRow(
    _is.DatabaseSession session,
    IdentityCheck row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IdentityCheck>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<IdentityCheck>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IdentityCheckTable> where,
    _is.OrderByBuilder<IdentityCheckTable>? orderBy,
    _is.OrderByListBuilder<IdentityCheckTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<IdentityCheck>(
      where: where(IdentityCheck.t),
      orderBy: orderBy?.call(IdentityCheck.t),
      orderByList: orderByList?.call(IdentityCheck.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<IdentityCheckTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<IdentityCheck>(
      where: where?.call(IdentityCheck.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [IdentityCheck] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<IdentityCheckTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<IdentityCheck>(
      where: where(IdentityCheck.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class IdentityCheckAttachRowRepository {
  const IdentityCheckAttachRowRepository._();

  /// Creates a relation between the given [IdentityCheck] and [AuthUser]
  /// by setting the [IdentityCheck]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    IdentityCheck identityCheck,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (identityCheck.id == null) {
      throw ArgumentError.notNull('identityCheck.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $identityCheck = identityCheck.copyWith(authUserId: authUser.id);
    await session.db.updateRow<IdentityCheck>(
      $identityCheck,
      columns: [IdentityCheck.t.authUserId],
      transaction: transaction,
    );
  }
}
