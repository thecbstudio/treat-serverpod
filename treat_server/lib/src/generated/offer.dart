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
import 'package:treat_server/src/generated/protocol.dart' as _iegszk5h;
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'shop.dart' as _isgf2ncs;

/// A free treat a shop gives in exchange for a social-media proof.
abstract class Offer implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Offer._({
    this.id,
    required this.shopId,
    this.shop,
    this.seedKey,
    required this.title,
    required this.description,
    required this.category,
    required this.frequency,
    required this.activeStartMin,
    required this.activeEndMin,
    this.dailyCap,
    this.totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required this.proofTypes,
    DateTime? createdAt,
  }) : status = status ?? _i40dfi1m.OfferStatus.active,
       featured = featured ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Offer({
    int? id,
    required int shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    required String title,
    required String description,
    required _iqmyfspq.OfferCategory category,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required List<_i671eu65.ProofType> proofTypes,
    DateTime? createdAt,
  }) = _OfferImpl;

  factory Offer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Offer(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      shop: jsonSerialization['shop'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_isgf2ncs.Shop>(
              jsonSerialization['shop'],
            ),
      seedKey: jsonSerialization['seedKey'] as String?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      category: _iqmyfspq.OfferCategory.fromJson(
        (jsonSerialization['category'] as String),
      ),
      frequency: _ix7dcs2a.OfferFrequency.fromJson(
        (jsonSerialization['frequency'] as String),
      ),
      activeStartMin: jsonSerialization['activeStartMin'] as int,
      activeEndMin: jsonSerialization['activeEndMin'] as int,
      dailyCap: jsonSerialization['dailyCap'] as int?,
      totalCap: jsonSerialization['totalCap'] as int?,
      status: jsonSerialization['status'] == null
          ? null
          : _i40dfi1m.OfferStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      featured: jsonSerialization['featured'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['featured']),
      proofTypes: _iegszk5h.Protocol().deserialize<List<_i671eu65.ProofType>>(
        jsonSerialization['proofTypes'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OfferTable();

  static const db = OfferRepository._();

  @override
  int? id;

  int shopId;

  _isgf2ncs.Shop? shop;

  String? seedKey;

  String title;

  String description;

  /// Copied from the shop at creation.
  _iqmyfspq.OfferCategory category;

  _ix7dcs2a.OfferFrequency frequency;

  /// Minutes after midnight, Europe/Istanbul. start < end.
  int activeStartMin;

  int activeEndMin;

  int? dailyCap;

  int? totalCap;

  _i40dfi1m.OfferStatus status;

  bool featured;

  /// At least one.
  List<_i671eu65.ProofType> proofTypes;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Offer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Offer copyWith({
    int? id,
    int? shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    String? title,
    String? description,
    _iqmyfspq.OfferCategory? category,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    List<_i671eu65.ProofType>? proofTypes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Offer',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (shop != null) 'shop': shop?.toJson(),
      if (seedKey != null) 'seedKey': seedKey,
      'title': title,
      'description': description,
      'category': category.toJson(),
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'status': status.toJson(),
      'featured': featured,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Offer',
      if (id != null) 'id': id,
      'shopId': shopId,
      if (shop != null) 'shop': shop?.toJsonForProtocol(),
      if (seedKey != null) 'seedKey': seedKey,
      'title': title,
      'description': description,
      'category': category.toJson(),
      'frequency': frequency.toJson(),
      'activeStartMin': activeStartMin,
      'activeEndMin': activeEndMin,
      if (dailyCap != null) 'dailyCap': dailyCap,
      if (totalCap != null) 'totalCap': totalCap,
      'status': status.toJson(),
      'featured': featured,
      'proofTypes': proofTypes.toJson(valueToJson: (v) => v.toJson()),
      'createdAt': createdAt.toJson(),
    };
  }

  static OfferInclude include({_isgf2ncs.ShopInclude? shop}) {
    return OfferInclude._(shop: shop);
  }

  static OfferIncludeList includeList({
    _is.WhereExpressionBuilder<OfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    OfferInclude? include,
  }) {
    return OfferIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OfferImpl extends Offer {
  _OfferImpl({
    int? id,
    required int shopId,
    _isgf2ncs.Shop? shop,
    String? seedKey,
    required String title,
    required String description,
    required _iqmyfspq.OfferCategory category,
    required _ix7dcs2a.OfferFrequency frequency,
    required int activeStartMin,
    required int activeEndMin,
    int? dailyCap,
    int? totalCap,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    required List<_i671eu65.ProofType> proofTypes,
    DateTime? createdAt,
  }) : super._(
         id: id,
         shopId: shopId,
         shop: shop,
         seedKey: seedKey,
         title: title,
         description: description,
         category: category,
         frequency: frequency,
         activeStartMin: activeStartMin,
         activeEndMin: activeEndMin,
         dailyCap: dailyCap,
         totalCap: totalCap,
         status: status,
         featured: featured,
         proofTypes: proofTypes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Offer]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Offer copyWith({
    Object? id = _Undefined,
    int? shopId,
    Object? shop = _Undefined,
    Object? seedKey = _Undefined,
    String? title,
    String? description,
    _iqmyfspq.OfferCategory? category,
    _ix7dcs2a.OfferFrequency? frequency,
    int? activeStartMin,
    int? activeEndMin,
    Object? dailyCap = _Undefined,
    Object? totalCap = _Undefined,
    _i40dfi1m.OfferStatus? status,
    bool? featured,
    List<_i671eu65.ProofType>? proofTypes,
    DateTime? createdAt,
  }) {
    return Offer(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      shop: shop is _isgf2ncs.Shop? ? shop : this.shop?.copyWith(),
      seedKey: seedKey is String? ? seedKey : this.seedKey,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      frequency: frequency ?? this.frequency,
      activeStartMin: activeStartMin ?? this.activeStartMin,
      activeEndMin: activeEndMin ?? this.activeEndMin,
      dailyCap: dailyCap is int? ? dailyCap : this.dailyCap,
      totalCap: totalCap is int? ? totalCap : this.totalCap,
      status: status ?? this.status,
      featured: featured ?? this.featured,
      proofTypes: proofTypes ?? this.proofTypes.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OfferUpdateTable extends _is.UpdateTable<OfferTable> {
  OfferUpdateTable(super.table);

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<String, String> seedKey(String? value) => _is.ColumnValue(
    table.seedKey,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<_iqmyfspq.OfferCategory, _iqmyfspq.OfferCategory> category(
    _iqmyfspq.OfferCategory value,
  ) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<_ix7dcs2a.OfferFrequency, _ix7dcs2a.OfferFrequency> frequency(
    _ix7dcs2a.OfferFrequency value,
  ) => _is.ColumnValue(
    table.frequency,
    value,
  );

  _is.ColumnValue<int, int> activeStartMin(int value) => _is.ColumnValue(
    table.activeStartMin,
    value,
  );

  _is.ColumnValue<int, int> activeEndMin(int value) => _is.ColumnValue(
    table.activeEndMin,
    value,
  );

  _is.ColumnValue<int, int> dailyCap(int? value) => _is.ColumnValue(
    table.dailyCap,
    value,
  );

  _is.ColumnValue<int, int> totalCap(int? value) => _is.ColumnValue(
    table.totalCap,
    value,
  );

  _is.ColumnValue<_i40dfi1m.OfferStatus, _i40dfi1m.OfferStatus> status(
    _i40dfi1m.OfferStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<bool, bool> featured(bool value) => _is.ColumnValue(
    table.featured,
    value,
  );

  _is.ColumnValue<List<_i671eu65.ProofType>, List<_i671eu65.ProofType>>
  proofTypes(List<_i671eu65.ProofType> value) => _is.ColumnValue(
    table.proofTypes,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class OfferTable extends _is.Table<int?> {
  OfferTable({super.tableRelation}) : super(tableName: 'offer') {
    updateTable = OfferUpdateTable(this);
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    seedKey = _is.ColumnString(
      'seedKey',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    category = _is.ColumnEnum(
      'category',
      this,
      _is.EnumSerialization.byName,
    );
    frequency = _is.ColumnEnum(
      'frequency',
      this,
      _is.EnumSerialization.byName,
    );
    activeStartMin = _is.ColumnInt(
      'activeStartMin',
      this,
    );
    activeEndMin = _is.ColumnInt(
      'activeEndMin',
      this,
    );
    dailyCap = _is.ColumnInt(
      'dailyCap',
      this,
    );
    totalCap = _is.ColumnInt(
      'totalCap',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    featured = _is.ColumnBool(
      'featured',
      this,
      hasDefault: true,
    );
    proofTypes = _is.ColumnSerializable<List<_i671eu65.ProofType>>(
      'proofTypes',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final OfferUpdateTable updateTable;

  late final _is.ColumnInt shopId;

  _isgf2ncs.ShopTable? _shop;

  late final _is.ColumnString seedKey;

  late final _is.ColumnString title;

  late final _is.ColumnString description;

  /// Copied from the shop at creation.
  late final _is.ColumnEnum<_iqmyfspq.OfferCategory> category;

  late final _is.ColumnEnum<_ix7dcs2a.OfferFrequency> frequency;

  /// Minutes after midnight, Europe/Istanbul. start < end.
  late final _is.ColumnInt activeStartMin;

  late final _is.ColumnInt activeEndMin;

  late final _is.ColumnInt dailyCap;

  late final _is.ColumnInt totalCap;

  late final _is.ColumnEnum<_i40dfi1m.OfferStatus> status;

  late final _is.ColumnBool featured;

  /// At least one.
  late final _is.ColumnSerializable<List<_i671eu65.ProofType>> proofTypes;

  late final _is.ColumnDateTime createdAt;

  _isgf2ncs.ShopTable get shop {
    if (_shop != null) return _shop!;
    _shop = _is.createRelationTable(
      relationFieldName: 'shop',
      field: Offer.t.shopId,
      foreignField: _isgf2ncs.Shop.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _isgf2ncs.ShopTable(tableRelation: foreignTableRelation),
    );
    return _shop!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    shopId,
    seedKey,
    title,
    description,
    category,
    frequency,
    activeStartMin,
    activeEndMin,
    dailyCap,
    totalCap,
    status,
    featured,
    proofTypes,
    createdAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'shop') {
      return shop;
    }
    return null;
  }
}

class OfferInclude extends _is.IncludeObject {
  OfferInclude._({_isgf2ncs.ShopInclude? shop}) {
    _shop = shop;
  }

  _isgf2ncs.ShopInclude? _shop;

  @override
  Map<String, _is.Include?> get includes => {'shop': _shop};

  @override
  _is.Table<int?> get table => Offer.t;
}

class OfferIncludeList extends _is.IncludeList {
  OfferIncludeList._({
    _is.WhereExpressionBuilder<OfferTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Offer.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Offer.t;
}

class OfferRepository {
  const OfferRepository._();

  final attachRow = const OfferAttachRowRepository._();

  /// Returns a list of [Offer]s matching the given query parameters.
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
  Future<List<Offer>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfferTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    _is.Transaction? transaction,
    OfferInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Offer>(
      where: where?.call(Offer.t),
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Offer] matching the given query parameters.
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
  Future<Offer?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfferTable>? where,
    int? offset,
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    _is.Transaction? transaction,
    OfferInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Offer>(
      where: where?.call(Offer.t),
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Offer] by its [id] or null if no such row exists.
  Future<Offer?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    OfferInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Offer>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Offer]s in the list and returns the inserted rows.
  ///
  /// The returned [Offer]s will have their `id` fields set.
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
  Future<List<Offer>> insert(
    _is.DatabaseSession session,
    List<Offer> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Offer>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Offer] and returns the inserted row.
  ///
  /// The returned [Offer] will have its `id` field set.
  Future<Offer> insertRow(
    _is.DatabaseSession session,
    Offer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Offer>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Offer]s in the list and returns the resulting rows.
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
  /// The returned [Offer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Offer>> upsert(
    _is.DatabaseSession session,
    List<Offer> rows, {
    required _is.ColumnSelections<OfferTable> conflictColumns,
    _is.ColumnSelections<OfferTable>? updateColumns,
    _is.WhereExpressionBuilder<OfferTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Offer>(
      rows,
      conflictColumns: conflictColumns(Offer.t),
      updateColumns: updateColumns?.call(Offer.t),
      updateWhere: updateWhere?.call(Offer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Offer] and returns the resulting row.
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
  /// The returned [Offer] will have its `id` field set.
  Future<Offer?> upsertRow(
    _is.DatabaseSession session,
    Offer row, {
    required _is.ColumnSelections<OfferTable> conflictColumns,
    _is.ColumnSelections<OfferTable>? updateColumns,
    _is.WhereExpressionBuilder<OfferTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Offer>(
      row,
      conflictColumns: conflictColumns(Offer.t),
      updateColumns: updateColumns?.call(Offer.t),
      updateWhere: updateWhere?.call(Offer.t),
      transaction: transaction,
    );
  }

  /// Updates all [Offer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Offer>> update(
    _is.DatabaseSession session,
    List<Offer> rows, {
    _is.ColumnSelections<OfferTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Offer>(
      rows,
      columns: columns?.call(Offer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Offer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Offer> updateRow(
    _is.DatabaseSession session,
    Offer row, {
    _is.ColumnSelections<OfferTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Offer>(
      row,
      columns: columns?.call(Offer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Offer] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Offer?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<OfferUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Offer>(
      id,
      columnValues: columnValues(Offer.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Offer]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Offer>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<OfferUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<OfferTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Offer>(
      columnValues: columnValues(Offer.t.updateTable),
      where: where(Offer.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Offer]s in the list and returns the deleted rows.
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
  Future<List<Offer>> delete(
    _is.DatabaseSession session,
    List<Offer> rows, {
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Offer>(
      rows,
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Offer].
  Future<Offer> deleteRow(
    _is.DatabaseSession session,
    Offer row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Offer>(
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
  Future<List<Offer>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfferTable> where,
    _is.OrderByBuilder<OfferTable>? orderBy,
    _is.OrderByListBuilder<OfferTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Offer>(
      where: where(Offer.t),
      orderBy: orderBy?.call(Offer.t),
      orderByList: orderByList?.call(Offer.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<OfferTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Offer>(
      where: where?.call(Offer.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Offer] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<OfferTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Offer>(
      where: where(Offer.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OfferAttachRowRepository {
  const OfferAttachRowRepository._();

  /// Creates a relation between the given [Offer] and [Shop]
  /// by setting the [Offer]'s foreign key `shopId` to refer to the [Shop].
  Future<void> shop(
    _is.DatabaseSession session,
    Offer offer,
    _isgf2ncs.Shop shop, {
    _is.Transaction? transaction,
  }) async {
    if (offer.id == null) {
      throw ArgumentError.notNull('offer.id');
    }
    if (shop.id == null) {
      throw ArgumentError.notNull('shop.id');
    }

    var $offer = offer.copyWith(shopId: shop.id);
    await session.db.updateRow<Offer>(
      $offer,
      columns: [Offer.t.shopId],
      transaction: transaction,
    );
  }
}
