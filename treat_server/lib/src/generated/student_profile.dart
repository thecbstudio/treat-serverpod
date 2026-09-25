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
import 'offer_category.dart' as _iqmyfspq;
import 'student_verification.dart' as _ipqqbskf;

/// A student account. One per auth user.
abstract class StudentProfile
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  StudentProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.name,
    required this.email,
    required this.university,
    required this.verification,
    int? strikes,
    int? treats,
    required this.categoriesTried,
    DateTime? joinedAt,
  }) : strikes = strikes ?? 0,
       treats = treats ?? 0,
       joinedAt = joinedAt ?? DateTime.now();

  factory StudentProfile({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String name,
    required String email,
    required String university,
    required _ipqqbskf.StudentVerification verification,
    int? strikes,
    int? treats,
    required List<_iqmyfspq.OfferCategory> categoriesTried,
    DateTime? joinedAt,
  }) = _StudentProfileImpl;

  factory StudentProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProfile(
      id: jsonSerialization['id'] as int?,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      name: jsonSerialization['name'] as String,
      email: jsonSerialization['email'] as String,
      university: jsonSerialization['university'] as String,
      verification: _ipqqbskf.StudentVerification.fromJson(
        (jsonSerialization['verification'] as String),
      ),
      strikes: jsonSerialization['strikes'] as int?,
      treats: jsonSerialization['treats'] as int?,
      categoriesTried: _iegszk5h.Protocol()
          .deserialize<List<_iqmyfspq.OfferCategory>>(
            jsonSerialization['categoriesTried'],
          ),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  static final t = StudentProfileTable();

  static const db = StudentProfileRepository._();

  @override
  int? id;

  _is.UuidValue authUserId;

  _iacs.AuthUser? authUser;

  String name;

  /// Only ever returned to the student themselves.
  String email;

  String university;

  _ipqqbskf.StudentVerification verification;

  int strikes;

  /// Approved claims.
  int treats;

  List<_iqmyfspq.OfferCategory> categoriesTried;

  DateTime joinedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudentProfile copyWith({
    int? id,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? name,
    String? email,
    String? university,
    _ipqqbskf.StudentVerification? verification,
    int? strikes,
    int? treats,
    List<_iqmyfspq.OfferCategory>? categoriesTried,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'name': name,
      'email': email,
      'university': university,
      'verification': verification.toJson(),
      'strikes': strikes,
      'treats': treats,
      'categoriesTried': categoriesTried.toJson(valueToJson: (v) => v.toJson()),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProfile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'name': name,
      'email': email,
      'university': university,
      'verification': verification.toJson(),
      'strikes': strikes,
      'treats': treats,
      'categoriesTried': categoriesTried.toJson(valueToJson: (v) => v.toJson()),
      'joinedAt': joinedAt.toJson(),
    };
  }

  static StudentProfileInclude include({_iacs.AuthUserInclude? authUser}) {
    return StudentProfileInclude._(authUser: authUser);
  }

  static StudentProfileIncludeList includeList({
    _is.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    StudentProfileInclude? include,
  }) {
    return StudentProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _is.UuidValue authUserId,
    _iacs.AuthUser? authUser,
    required String name,
    required String email,
    required String university,
    required _ipqqbskf.StudentVerification verification,
    int? strikes,
    int? treats,
    required List<_iqmyfspq.OfferCategory> categoriesTried,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         name: name,
         email: email,
         university: university,
         verification: verification,
         strikes: strikes,
         treats: treats,
         categoriesTried: categoriesTried,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _is.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? name,
    String? email,
    String? university,
    _ipqqbskf.StudentVerification? verification,
    int? strikes,
    int? treats,
    List<_iqmyfspq.OfferCategory>? categoriesTried,
    DateTime? joinedAt,
  }) {
    return StudentProfile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      name: name ?? this.name,
      email: email ?? this.email,
      university: university ?? this.university,
      verification: verification ?? this.verification,
      strikes: strikes ?? this.strikes,
      treats: treats ?? this.treats,
      categoriesTried:
          categoriesTried ?? this.categoriesTried.map((e0) => e0).toList(),
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}

class StudentProfileUpdateTable extends _is.UpdateTable<StudentProfileTable> {
  StudentProfileUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> email(String value) => _is.ColumnValue(
    table.email,
    value,
  );

  _is.ColumnValue<String, String> university(String value) => _is.ColumnValue(
    table.university,
    value,
  );

  _is.ColumnValue<_ipqqbskf.StudentVerification, _ipqqbskf.StudentVerification>
  verification(_ipqqbskf.StudentVerification value) => _is.ColumnValue(
    table.verification,
    value,
  );

  _is.ColumnValue<int, int> strikes(int value) => _is.ColumnValue(
    table.strikes,
    value,
  );

  _is.ColumnValue<int, int> treats(int value) => _is.ColumnValue(
    table.treats,
    value,
  );

  _is.ColumnValue<List<_iqmyfspq.OfferCategory>, List<_iqmyfspq.OfferCategory>>
  categoriesTried(List<_iqmyfspq.OfferCategory> value) => _is.ColumnValue(
    table.categoriesTried,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _is.ColumnValue(
        table.joinedAt,
        value,
      );
}

class StudentProfileTable extends _is.Table<int?> {
  StudentProfileTable({super.tableRelation})
    : super(tableName: 'student_profile') {
    updateTable = StudentProfileUpdateTable(this);
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    email = _is.ColumnString(
      'email',
      this,
    );
    university = _is.ColumnString(
      'university',
      this,
    );
    verification = _is.ColumnEnum(
      'verification',
      this,
      _is.EnumSerialization.byName,
    );
    strikes = _is.ColumnInt(
      'strikes',
      this,
      hasDefault: true,
    );
    treats = _is.ColumnInt(
      'treats',
      this,
      hasDefault: true,
    );
    categoriesTried = _is.ColumnSerializable<List<_iqmyfspq.OfferCategory>>(
      'categoriesTried',
      this,
    );
    joinedAt = _is.ColumnDateTime(
      'joinedAt',
      this,
      hasDefault: true,
    );
  }

  late final StudentProfileUpdateTable updateTable;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString name;

  /// Only ever returned to the student themselves.
  late final _is.ColumnString email;

  late final _is.ColumnString university;

  late final _is.ColumnEnum<_ipqqbskf.StudentVerification> verification;

  late final _is.ColumnInt strikes;

  /// Approved claims.
  late final _is.ColumnInt treats;

  late final _is.ColumnSerializable<List<_iqmyfspq.OfferCategory>>
  categoriesTried;

  late final _is.ColumnDateTime joinedAt;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: StudentProfile.t.authUserId,
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
    name,
    email,
    university,
    verification,
    strikes,
    treats,
    categoriesTried,
    joinedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class StudentProfileInclude extends _is.IncludeObject {
  StudentProfileInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => StudentProfile.t;
}

class StudentProfileIncludeList extends _is.IncludeList {
  StudentProfileIncludeList._({
    _is.WhereExpressionBuilder<StudentProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StudentProfile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => StudentProfile.t;
}

class StudentProfileRepository {
  const StudentProfileRepository._();

  final attachRow = const StudentProfileAttachRowRepository._();

  /// Returns a list of [StudentProfile]s matching the given query parameters.
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
  Future<List<StudentProfile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    _is.Transaction? transaction,
    StudentProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<StudentProfile>(
      where: where?.call(StudentProfile.t),
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [StudentProfile] matching the given query parameters.
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
  Future<StudentProfile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentProfileTable>? where,
    int? offset,
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    _is.Transaction? transaction,
    StudentProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<StudentProfile>(
      where: where?.call(StudentProfile.t),
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [StudentProfile] by its [id] or null if no such row exists.
  Future<StudentProfile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    StudentProfileInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<StudentProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [StudentProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [StudentProfile]s will have their `id` fields set.
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
  Future<List<StudentProfile>> insert(
    _is.DatabaseSession session,
    List<StudentProfile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<StudentProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [StudentProfile] and returns the inserted row.
  ///
  /// The returned [StudentProfile] will have its `id` field set.
  Future<StudentProfile> insertRow(
    _is.DatabaseSession session,
    StudentProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<StudentProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [StudentProfile]s in the list and returns the resulting rows.
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
  /// The returned [StudentProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentProfile>> upsert(
    _is.DatabaseSession session,
    List<StudentProfile> rows, {
    required _is.ColumnSelections<StudentProfileTable> conflictColumns,
    _is.ColumnSelections<StudentProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentProfileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<StudentProfile>(
      rows,
      conflictColumns: conflictColumns(StudentProfile.t),
      updateColumns: updateColumns?.call(StudentProfile.t),
      updateWhere: updateWhere?.call(StudentProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [StudentProfile] and returns the resulting row.
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
  /// The returned [StudentProfile] will have its `id` field set.
  Future<StudentProfile?> upsertRow(
    _is.DatabaseSession session,
    StudentProfile row, {
    required _is.ColumnSelections<StudentProfileTable> conflictColumns,
    _is.ColumnSelections<StudentProfileTable>? updateColumns,
    _is.WhereExpressionBuilder<StudentProfileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<StudentProfile>(
      row,
      conflictColumns: conflictColumns(StudentProfile.t),
      updateColumns: updateColumns?.call(StudentProfile.t),
      updateWhere: updateWhere?.call(StudentProfile.t),
      transaction: transaction,
    );
  }

  /// Updates all [StudentProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentProfile>> update(
    _is.DatabaseSession session,
    List<StudentProfile> rows, {
    _is.ColumnSelections<StudentProfileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<StudentProfile>(
      rows,
      columns: columns?.call(StudentProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [StudentProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StudentProfile> updateRow(
    _is.DatabaseSession session,
    StudentProfile row, {
    _is.ColumnSelections<StudentProfileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<StudentProfile>(
      row,
      columns: columns?.call(StudentProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StudentProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<StudentProfile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<StudentProfileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<StudentProfile>(
      id,
      columnValues: columnValues(StudentProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [StudentProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<StudentProfile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<StudentProfileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<StudentProfileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<StudentProfile>(
      columnValues: columnValues(StudentProfile.t.updateTable),
      where: where(StudentProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [StudentProfile]s in the list and returns the deleted rows.
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
  Future<List<StudentProfile>> delete(
    _is.DatabaseSession session,
    List<StudentProfile> rows, {
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<StudentProfile>(
      rows,
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [StudentProfile].
  Future<StudentProfile> deleteRow(
    _is.DatabaseSession session,
    StudentProfile row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StudentProfile>(
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
  Future<List<StudentProfile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentProfileTable> where,
    _is.OrderByBuilder<StudentProfileTable>? orderBy,
    _is.OrderByListBuilder<StudentProfileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<StudentProfile>(
      where: where(StudentProfile.t),
      orderBy: orderBy?.call(StudentProfile.t),
      orderByList: orderByList?.call(StudentProfile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<StudentProfileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<StudentProfile>(
      where: where?.call(StudentProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [StudentProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<StudentProfileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<StudentProfile>(
      where: where(StudentProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class StudentProfileAttachRowRepository {
  const StudentProfileAttachRowRepository._();

  /// Creates a relation between the given [StudentProfile] and [AuthUser]
  /// by setting the [StudentProfile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    StudentProfile studentProfile,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (studentProfile.id == null) {
      throw ArgumentError.notNull('studentProfile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $studentProfile = studentProfile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<StudentProfile>(
      $studentProfile,
      columns: [StudentProfile.t.authUserId],
      transaction: transaction,
    );
  }
}
