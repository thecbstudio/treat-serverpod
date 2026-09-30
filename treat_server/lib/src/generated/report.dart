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
import 'report_kind.dart' as _imx1jrz0;
import 'report_reason.dart' as _ijgj7dn0;

/// A user flagging public content. Reviews and wall posts are hidden once
/// enough different users reported them; places are only recorded for
/// review (two accounts must not be able to take a business off the app).
abstract class Report implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue reporterId,
    _iacs.AuthUser? reporter,
    required _imx1jrz0.ReportKind kind,
    required int targetId,
    required _ijgj7dn0.ReportReason reason,
    DateTime? createdAt,
  }) = _ReportImpl;

  factory Report.fromJson(Map<String, dynamic> jsonSerialization) {
    return Report(
      id: jsonSerialization['id'] as int?,
      reporterId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['reporterId'],
      ),
      reporter: jsonSerialization['reporter'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iacs.AuthUser>(
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ReportTable();

  static const db = ReportRepository._();

  @override
  int? id;

  _is.UuidValue reporterId;

  _iacs.AuthUser? reporter;

  _imx1jrz0.ReportKind kind;

  int targetId;

  _ijgj7dn0.ReportReason reason;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Report]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Report copyWith({
    int? id,
    _is.UuidValue? reporterId,
    _iacs.AuthUser? reporter,
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

  static ReportInclude include({_iacs.AuthUserInclude? reporter}) {
    return ReportInclude._(reporter: reporter);
  }

  static ReportIncludeList includeList({
    _is.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    ReportInclude? include,
  }) {
    return ReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReportImpl extends Report {
  _ReportImpl({
    int? id,
    required _is.UuidValue reporterId,
    _iacs.AuthUser? reporter,
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
  @_is.useResult
  @override
  Report copyWith({
    Object? id = _Undefined,
    _is.UuidValue? reporterId,
    Object? reporter = _Undefined,
    _imx1jrz0.ReportKind? kind,
    int? targetId,
    _ijgj7dn0.ReportReason? reason,
    DateTime? createdAt,
  }) {
    return Report(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      reporter: reporter is _iacs.AuthUser?
          ? reporter
          : this.reporter?.copyWith(),
      kind: kind ?? this.kind,
      targetId: targetId ?? this.targetId,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReportUpdateTable extends _is.UpdateTable<ReportTable> {
  ReportUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> reporterId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.reporterId,
    value,
  );

  _is.ColumnValue<_imx1jrz0.ReportKind, _imx1jrz0.ReportKind> kind(
    _imx1jrz0.ReportKind value,
  ) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<int, int> targetId(int value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<_ijgj7dn0.ReportReason, _ijgj7dn0.ReportReason> reason(
    _ijgj7dn0.ReportReason value,
  ) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReportTable extends _is.Table<int?> {
  ReportTable({super.tableRelation}) : super(tableName: 'report') {
    updateTable = ReportUpdateTable(this);
    reporterId = _is.ColumnUuid(
      'reporterId',
      this,
    );
    kind = _is.ColumnEnum(
      'kind',
      this,
      _is.EnumSerialization.byName,
    );
    targetId = _is.ColumnInt(
      'targetId',
      this,
    );
    reason = _is.ColumnEnum(
      'reason',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReportUpdateTable updateTable;

  late final _is.ColumnUuid reporterId;

  _iacs.AuthUserTable? _reporter;

  late final _is.ColumnEnum<_imx1jrz0.ReportKind> kind;

  late final _is.ColumnInt targetId;

  late final _is.ColumnEnum<_ijgj7dn0.ReportReason> reason;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get reporter {
    if (_reporter != null) return _reporter!;
    _reporter = _is.createRelationTable(
      relationFieldName: 'reporter',
      field: Report.t.reporterId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _reporter!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    reporterId,
    kind,
    targetId,
    reason,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'reporter') {
      return reporter;
    }
    return null;
  }
}

class ReportInclude extends _is.IncludeObject {
  ReportInclude._({_iacs.AuthUserInclude? reporter}) {
    _reporter = reporter;
  }

  _iacs.AuthUserInclude? _reporter;

  @override
  Map<String, _is.Include?> get includes => {'reporter': _reporter};

  @override
  _is.Table<int?> get table => Report.t;
}

class ReportIncludeList extends _is.IncludeList {
  ReportIncludeList._({
    _is.WhereExpressionBuilder<ReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Report.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Report.t;
}

class ReportRepository {
  const ReportRepository._();

  final attachRow = const ReportAttachRowRepository._();

  /// Returns a list of [Report]s matching the given query parameters.
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
  Future<List<Report>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    _is.Transaction? transaction,
    ReportInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Report] matching the given query parameters.
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
  Future<Report?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReportTable>? where,
    int? offset,
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    _is.Transaction? transaction,
    ReportInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Report>(
      where: where?.call(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Report] by its [id] or null if no such row exists.
  Future<Report?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ReportInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Report>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Report]s in the list and returns the inserted rows.
  ///
  /// The returned [Report]s will have their `id` fields set.
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
  Future<List<Report>> insert(
    _is.DatabaseSession session,
    List<Report> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Report>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Report] and returns the inserted row.
  ///
  /// The returned [Report] will have its `id` field set.
  Future<Report> insertRow(
    _is.DatabaseSession session,
    Report row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Report>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Report]s in the list and returns the resulting rows.
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
  /// The returned [Report]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Report>> upsert(
    _is.DatabaseSession session,
    List<Report> rows, {
    required _is.ColumnSelections<ReportTable> conflictColumns,
    _is.ColumnSelections<ReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Report>(
      rows,
      conflictColumns: conflictColumns(Report.t),
      updateColumns: updateColumns?.call(Report.t),
      updateWhere: updateWhere?.call(Report.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Report] and returns the resulting row.
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
  /// The returned [Report] will have its `id` field set.
  Future<Report?> upsertRow(
    _is.DatabaseSession session,
    Report row, {
    required _is.ColumnSelections<ReportTable> conflictColumns,
    _is.ColumnSelections<ReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Report>(
      row,
      conflictColumns: conflictColumns(Report.t),
      updateColumns: updateColumns?.call(Report.t),
      updateWhere: updateWhere?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Updates all [Report]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Report>> update(
    _is.DatabaseSession session,
    List<Report> rows, {
    _is.ColumnSelections<ReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Report>(
      rows,
      columns: columns?.call(Report.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Report]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Report> updateRow(
    _is.DatabaseSession session,
    Report row, {
    _is.ColumnSelections<ReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Report>(
      row,
      columns: columns?.call(Report.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Report] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Report?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReportUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Report>(
      id,
      columnValues: columnValues(Report.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Report]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Report>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReportUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Report>(
      columnValues: columnValues(Report.t.updateTable),
      where: where(Report.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Report]s in the list and returns the deleted rows.
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
  Future<List<Report>> delete(
    _is.DatabaseSession session,
    List<Report> rows, {
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Report>(
      rows,
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Report].
  Future<Report> deleteRow(
    _is.DatabaseSession session,
    Report row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Report>(
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
  Future<List<Report>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReportTable> where,
    _is.OrderByBuilder<ReportTable>? orderBy,
    _is.OrderByListBuilder<ReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Report>(
      where: where(Report.t),
      orderBy: orderBy?.call(Report.t),
      orderByList: orderByList?.call(Report.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Report>(
      where: where?.call(Report.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Report] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Report>(
      where: where(Report.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ReportAttachRowRepository {
  const ReportAttachRowRepository._();

  /// Creates a relation between the given [Report] and [AuthUser]
  /// by setting the [Report]'s foreign key `reporterId` to refer to the [AuthUser].
  Future<void> reporter(
    _is.DatabaseSession session,
    Report report,
    _iacs.AuthUser reporter, {
    _is.Transaction? transaction,
  }) async {
    if (report.id == null) {
      throw ArgumentError.notNull('report.id');
    }
    if (reporter.id == null) {
      throw ArgumentError.notNull('reporter.id');
    }

    var $report = report.copyWith(reporterId: reporter.id);
    await session.db.updateRow<Report>(
      $report,
      columns: [Report.t.reporterId],
      transaction: transaction,
    );
  }
}
