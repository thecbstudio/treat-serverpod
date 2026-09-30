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

/// A business account. `owner` is null only for seeded shops without a login.
abstract class Shop implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Shop._({
    this.id,
    this.ownerId,
    this.owner,
    this.seedKey,
    required this.name,
    required this.category,
    required this.district,
    required this.address,
    required this.bio,
    this.instagramHandle,
    this.googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) : verified = verified ?? false,
       totalRedeems = totalRedeems ?? 0,
       approvedProofs = approvedProofs ?? 0,
       createdAt = createdAt ?? DateTime.now();

  factory Shop({
    int? id,
    _is.UuidValue? ownerId,
    _iacs.AuthUser? owner,
    String? seedKey,
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) = _ShopImpl;

  factory Shop.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shop(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['ownerId']),
      owner: jsonSerialization['owner'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['owner'],
            ),
      seedKey: jsonSerialization['seedKey'] as String?,
      name: jsonSerialization['name'] as String,
      category: _iqmyfspq.OfferCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      district: jsonSerialization['district'] as String,
      address: jsonSerialization['address'] as String,
      bio: jsonSerialization['bio'] as String,
      instagramHandle: jsonSerialization['instagramHandle'] as String?,
      googleReviewUrl: jsonSerialization['googleReviewUrl'] as String?,
      verified: jsonSerialization['verified'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['verified']),
      totalRedeems: jsonSerialization['totalRedeems'] as int?,
      approvedProofs: jsonSerialization['approvedProofs'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ShopTable();

  static const db = ShopRepository._();

  @override
  int? id;

  _is.UuidValue? ownerId;

  _iacs.AuthUser? owner;

  /// Stable key for idempotent seeding; null for real sign-ups.
  String? seedKey;

  String name;

  _iqmyfspq.OfferCategory category;

  String district;

  String address;

  String bio;

  /// Without "@". Used by the AI proof verifier.
  String? instagramHandle;

  /// The place's own Google "ask for reviews" link, printed as a QR on its
  /// counter card for every customer. Never shown to students in the treat
  /// flow and never rewarded.
  String? googleReviewUrl;

  bool verified;

  int totalRedeems;

  int approvedProofs;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Shop copyWith({
    int? id,
    _is.UuidValue? ownerId,
    _iacs.AuthUser? owner,
    String? seedKey,
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
      if (googleReviewUrl != null) 'googleReviewUrl': googleReviewUrl,
      'verified': verified,
      'totalRedeems': totalRedeems,
      'approvedProofs': approvedProofs,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      if (ownerId != null) 'ownerId': ownerId?.toJson(),
      if (owner != null) 'owner': owner?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'name': name,
      'category': category.toJson(),
      'district': district,
      'address': address,
      'bio': bio,
      if (instagramHandle != null) 'instagramHandle': instagramHandle,
      if (googleReviewUrl != null) 'googleReviewUrl': googleReviewUrl,
      'verified': verified,
      'totalRedeems': totalRedeems,
      'approvedProofs': approvedProofs,
      'createdAt': createdAt.toJson(),
    };
  }

  static ShopInclude include({_iacs.AuthUserInclude? owner}) {
    return ShopInclude._(owner: owner);
  }

  static ShopIncludeList includeList({
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    ShopInclude? include,
  }) {
    return ShopIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopImpl extends Shop {
  _ShopImpl({
    int? id,
    _is.UuidValue? ownerId,
    _iacs.AuthUser? owner,
    String? seedKey,
    required String name,
    required _iqmyfspq.OfferCategory category,
    required String district,
    required String address,
    required String bio,
    String? instagramHandle,
    String? googleReviewUrl,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         owner: owner,
         seedKey: seedKey,
         name: name,
         category: category,
         district: district,
         address: address,
         bio: bio,
         instagramHandle: instagramHandle,
         googleReviewUrl: googleReviewUrl,
         verified: verified,
         totalRedeems: totalRedeems,
         approvedProofs: approvedProofs,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Shop copyWith({
    Object? id = _Undefined,
    Object? ownerId = _Undefined,
    Object? owner = _Undefined,
    Object? seedKey = _Undefined,
    String? name,
    _iqmyfspq.OfferCategory? category,
    String? district,
    String? address,
    String? bio,
    Object? instagramHandle = _Undefined,
    Object? googleReviewUrl = _Undefined,
    bool? verified,
    int? totalRedeems,
    int? approvedProofs,
    DateTime? createdAt,
  }) {
    return Shop(
      id: id is int? ? id : this.id,
      ownerId: ownerId is _is.UuidValue? ? ownerId : this.ownerId,
      owner: owner is _iacs.AuthUser? ? owner : this.owner?.copyWith(),
      seedKey: seedKey is String? ? seedKey : this.seedKey,
      name: name ?? this.name,
      category: category ?? this.category,
      district: district ?? this.district,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      instagramHandle: instagramHandle is String?
          ? instagramHandle
          : this.instagramHandle,
      googleReviewUrl: googleReviewUrl is String?
          ? googleReviewUrl
          : this.googleReviewUrl,
      verified: verified ?? this.verified,
      totalRedeems: totalRedeems ?? this.totalRedeems,
      approvedProofs: approvedProofs ?? this.approvedProofs,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ShopUpdateTable extends _is.UpdateTable<ShopTable> {
  ShopUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> ownerId(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<String, String> seedKey(String? value) => _is.ColumnValue(
    table.seedKey,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_iqmyfspq.OfferCategory, _iqmyfspq.OfferCategory> category(
    _iqmyfspq.OfferCategory value,
  ) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<String, String> district(String value) => _is.ColumnValue(
    table.district,
    value,
  );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<String, String> bio(String value) => _is.ColumnValue(
    table.bio,
    value,
  );

  _is.ColumnValue<String, String> instagramHandle(String? value) =>
      _is.ColumnValue(
        table.instagramHandle,
        value,
      );

  _is.ColumnValue<String, String> googleReviewUrl(String? value) =>
      _is.ColumnValue(
        table.googleReviewUrl,
        value,
      );

  _is.ColumnValue<bool, bool> verified(bool value) => _is.ColumnValue(
    table.verified,
    value,
  );

  _is.ColumnValue<int, int> totalRedeems(int value) => _is.ColumnValue(
    table.totalRedeems,
    value,
  );

  _is.ColumnValue<int, int> approvedProofs(int value) => _is.ColumnValue(
    table.approvedProofs,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ShopTable extends _is.Table<int?> {
  ShopTable({super.tableRelation}) : super(tableName: 'shop') {
    updateTable = ShopUpdateTable(this);
    ownerId = _is.ColumnUuid(
      'ownerId',
      this,
    );
    seedKey = _is.ColumnString(
      'seedKey',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    category = _is.ColumnEnum(
      'category',
      this,
      _is.EnumSerialization.byName,
    );
    district = _is.ColumnString(
      'district',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    bio = _is.ColumnString(
      'bio',
      this,
    );
    instagramHandle = _is.ColumnString(
      'instagramHandle',
      this,
    );
    googleReviewUrl = _is.ColumnString(
      'googleReviewUrl',
      this,
    );
    verified = _is.ColumnBool(
      'verified',
      this,
      hasDefault: true,
    );
    totalRedeems = _is.ColumnInt(
      'totalRedeems',
      this,
      hasDefault: true,
    );
    approvedProofs = _is.ColumnInt(
      'approvedProofs',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ShopUpdateTable updateTable;

  late final _is.ColumnUuid ownerId;

  _iacs.AuthUserTable? _owner;

  /// Stable key for idempotent seeding; null for real sign-ups.
  late final _is.ColumnString seedKey;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_iqmyfspq.OfferCategory> category;

  late final _is.ColumnString district;

  late final _is.ColumnString address;

  late final _is.ColumnString bio;

  /// Without "@". Used by the AI proof verifier.
  late final _is.ColumnString instagramHandle;

  /// The place's own Google "ask for reviews" link, printed as a QR on its
  /// counter card for every customer. Never shown to students in the treat
  /// flow and never rewarded.
  late final _is.ColumnString googleReviewUrl;

  late final _is.ColumnBool verified;

  late final _is.ColumnInt totalRedeems;

  late final _is.ColumnInt approvedProofs;

  late final _is.ColumnDateTime createdAt;

  _iacs.AuthUserTable get owner {
    if (_owner != null) return _owner!;
    _owner = _is.createRelationTable(
      relationFieldName: 'owner',
      field: Shop.t.ownerId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _owner!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    seedKey,
    name,
    category,
    district,
    address,
    bio,
    instagramHandle,
    googleReviewUrl,
    verified,
    totalRedeems,
    approvedProofs,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'owner') {
      return owner;
    }
    return null;
  }
}

class ShopInclude extends _is.IncludeObject {
  ShopInclude._({_iacs.AuthUserInclude? owner}) {
    _owner = owner;
  }

  _iacs.AuthUserInclude? _owner;

  @override
  Map<String, _is.Include?> get includes => {'owner': _owner};

  @override
  _is.Table<int?> get table => Shop.t;
}

class ShopIncludeList extends _is.IncludeList {
  ShopIncludeList._({
    _is.WhereExpressionBuilder<ShopTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Shop.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Shop.t;
}

class ShopRepository {
  const ShopRepository._();

  final attachRow = const ShopAttachRowRepository._();

  final detachRow = const ShopDetachRowRepository._();

  /// Returns a list of [Shop]s matching the given query parameters.
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
  Future<List<Shop>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    ShopInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Shop>(
      where: where?.call(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Shop] matching the given query parameters.
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
  Future<Shop?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    ShopInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Shop>(
      where: where?.call(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Shop] by its [id] or null if no such row exists.
  Future<Shop?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ShopInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Shop>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Shop]s in the list and returns the inserted rows.
  ///
  /// The returned [Shop]s will have their `id` fields set.
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
  Future<List<Shop>> insert(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Shop>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Shop] and returns the inserted row.
  ///
  /// The returned [Shop] will have its `id` field set.
  Future<Shop> insertRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Shop>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Shop]s in the list and returns the resulting rows.
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
  /// The returned [Shop]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> upsert(
    _is.DatabaseSession session,
    List<Shop> rows, {
    required _is.ColumnSelections<ShopTable> conflictColumns,
    _is.ColumnSelections<ShopTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Shop>(
      rows,
      conflictColumns: conflictColumns(Shop.t),
      updateColumns: updateColumns?.call(Shop.t),
      updateWhere: updateWhere?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Shop] and returns the resulting row.
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
  /// The returned [Shop] will have its `id` field set.
  Future<Shop?> upsertRow(
    _is.DatabaseSession session,
    Shop row, {
    required _is.ColumnSelections<ShopTable> conflictColumns,
    _is.ColumnSelections<ShopTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Shop>(
      row,
      conflictColumns: conflictColumns(Shop.t),
      updateColumns: updateColumns?.call(Shop.t),
      updateWhere: updateWhere?.call(Shop.t),
      transaction: transaction,
    );
  }

  /// Updates all [Shop]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> update(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.ColumnSelections<ShopTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Shop>(
      rows,
      columns: columns?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Shop]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Shop> updateRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.ColumnSelections<ShopTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Shop>(
      row,
      columns: columns?.call(Shop.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Shop] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Shop?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ShopUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Shop>(
      id,
      columnValues: columnValues(Shop.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Shop]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShopUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShopTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Shop>(
      columnValues: columnValues(Shop.t.updateTable),
      where: where(Shop.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Shop]s in the list and returns the deleted rows.
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
  Future<List<Shop>> delete(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Shop>(
      rows,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Shop].
  Future<Shop> deleteRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Shop>(
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
  Future<List<Shop>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopTable> where,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Shop>(
      where: where(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Shop>(
      where: where?.call(Shop.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Shop] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Shop>(
      where: where(Shop.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ShopAttachRowRepository {
  const ShopAttachRowRepository._();

  /// Creates a relation between the given [Shop] and [AuthUser]
  /// by setting the [Shop]'s foreign key `ownerId` to refer to the [AuthUser].
  Future<void> owner(
    _is.DatabaseSession session,
    Shop shop,
    _iacs.AuthUser owner, {
    _is.Transaction? transaction,
  }) async {
    if (shop.id == null) {
      throw ArgumentError.notNull('shop.id');
    }
    if (owner.id == null) {
      throw ArgumentError.notNull('owner.id');
    }

    var $shop = shop.copyWith(ownerId: owner.id);
    await session.db.updateRow<Shop>(
      $shop,
      columns: [Shop.t.ownerId],
      transaction: transaction,
    );
  }
}

class ShopDetachRowRepository {
  const ShopDetachRowRepository._();

  /// Detaches the relation between this [Shop] and the [AuthUser] set in `owner`
  /// by setting the [Shop]'s foreign key `ownerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> owner(
    _is.DatabaseSession session,
    Shop shop, {
    _is.Transaction? transaction,
  }) async {
    if (shop.id == null) {
      throw ArgumentError.notNull('shop.id');
    }

    var $shop = shop.copyWith(ownerId: null);
    await session.db.updateRow<Shop>(
      $shop,
      columns: [Shop.t.ownerId],
      transaction: transaction,
    );
  }
}
