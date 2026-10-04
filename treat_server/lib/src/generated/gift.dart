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
import 'gift_status.dart' as _igcewz2w;
import 'shop.dart' as _isgf2ncs;
import 'student_profile.dart' as _iovtxv26;

/// A paid treat one student gives another, to collect at a place. The sender
/// pays through iyzico; the place hands it over against a QR/code; treat keeps
/// 15 % (the rest is the place's, shown as "to pay out"). Closed gifts are
/// refunded. Rows stay after an account is deleted (accounting), without names.
abstract class Gift implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Gift._({
    this.id,
    this.senderId,
    this.sender,
    this.recipientId,
    this.recipient,
    this.shopId,
    this.shop,
    required this.senderName,
    required this.recipientName,
    required this.shopName,
    required this.amountTl,
    required this.commissionKurus,
    required this.netKurus,
    this.message,
    required this.status,
    this.code,
    DateTime? createdAt,
    this.paidAt,
    this.expiresAt,
    this.redeemedAt,
    this.closedAt,
    this.conversationId,
    this.paymentToken,
    this.paymentId,
    this.paymentTransactionId,
    this.refundedAt,
    int? refundAttempts,
  }) : createdAt = createdAt ?? DateTime.now(),
       refundAttempts = refundAttempts ?? 0;

  factory Gift({
    int? id,
    int? senderId,
    _iovtxv26.StudentProfile? sender,
    int? recipientId,
    _iovtxv26.StudentProfile? recipient,
    int? shopId,
    _isgf2ncs.Shop? shop,
    required String senderName,
    required String recipientName,
    required String shopName,
    required int amountTl,
    required int commissionKurus,
    required int netKurus,
    String? message,
    required _igcewz2w.GiftStatus status,
    String? code,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? expiresAt,
    DateTime? redeemedAt,
    DateTime? closedAt,
    String? conversationId,
    String? paymentToken,
    String? paymentId,
    String? paymentTransactionId,
    DateTime? refundedAt,
    int? refundAttempts,
  }) = _GiftImpl;

  factory Gift.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gift(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as int?,
      sender: jsonSerialization['sender'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['sender'],
            ),
      recipientId: jsonSerialization['recipientId'] as int?,
      recipient: jsonSerialization['recipient'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['recipient'],
            ),
      shopId: jsonSerialization['shopId'] as int?,
      shop: jsonSerialization['shop'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_isgf2ncs.Shop>(
              jsonSerialization['shop'],
            ),
      senderName: jsonSerialization['senderName'] as String,
      recipientName: jsonSerialization['recipientName'] as String,
      shopName: jsonSerialization['shopName'] as String,
      amountTl: jsonSerialization['amountTl'] as int,
      commissionKurus: jsonSerialization['commissionKurus'] as int,
      netKurus: jsonSerialization['netKurus'] as int,
      message: jsonSerialization['message'] as String?,
      status: _igcewz2w.GiftStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      code: jsonSerialization['code'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      redeemedAt: jsonSerialization['redeemedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['redeemedAt']),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      conversationId: jsonSerialization['conversationId'] as String?,
      paymentToken: jsonSerialization['paymentToken'] as String?,
      paymentId: jsonSerialization['paymentId'] as String?,
      paymentTransactionId:
          jsonSerialization['paymentTransactionId'] as String?,
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['refundedAt']),
      refundAttempts: jsonSerialization['refundAttempts'] as int?,
    );
  }

  static final t = GiftTable();

  static const db = GiftRepository._();

  @override
  int? id;

  int? senderId;

  _iovtxv26.StudentProfile? sender;

  int? recipientId;

  _iovtxv26.StudentProfile? recipient;

  int? shopId;

  _isgf2ncs.Shop? shop;

  /// Blanked when the person deletes their account.
  String senderName;

  String recipientName;

  String shopName;

  /// Whole TL, 20–1000.
  int amountTl;

  int commissionKurus;

  /// What the place earns: amount minus commission.
  int netKurus;

  String? message;

  _igcewz2w.GiftStatus status;

  /// 6 chars, only shown to the recipient. QR: GIFT:<id>:<code>.
  String? code;

  DateTime createdAt;

  DateTime? paidAt;

  DateTime? expiresAt;

  DateTime? redeemedAt;

  DateTime? closedAt;

  /// iyzico bookkeeping, never sent to a client.
  String? conversationId;

  String? paymentToken;

  String? paymentId;

  String? paymentTransactionId;

  /// Set once the money is back with the sender (cancelled/expired gifts).
  DateTime? refundedAt;

  int refundAttempts;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Gift]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Gift copyWith({
    int? id,
    int? senderId,
    _iovtxv26.StudentProfile? sender,
    int? recipientId,
    _iovtxv26.StudentProfile? recipient,
    int? shopId,
    _isgf2ncs.Shop? shop,
    String? senderName,
    String? recipientName,
    String? shopName,
    int? amountTl,
    int? commissionKurus,
    int? netKurus,
    String? message,
    _igcewz2w.GiftStatus? status,
    String? code,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? expiresAt,
    DateTime? redeemedAt,
    DateTime? closedAt,
    String? conversationId,
    String? paymentToken,
    String? paymentId,
    String? paymentTransactionId,
    DateTime? refundedAt,
    int? refundAttempts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Gift',
      if (id != null) 'id': id,
      if (senderId != null) 'senderId': senderId,
      if (sender != null) 'sender': sender?.toJson(),
      if (recipientId != null) 'recipientId': recipientId,
      if (recipient != null) 'recipient': recipient?.toJson(),
      if (shopId != null) 'shopId': shopId,
      if (shop != null) 'shop': shop?.toJson(),
      'senderName': senderName,
      'recipientName': recipientName,
      'shopName': shopName,
      'amountTl': amountTl,
      'commissionKurus': commissionKurus,
      'netKurus': netKurus,
      if (message != null) 'message': message,
      'status': status.toJson(),
      if (code != null) 'code': code,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (redeemedAt != null) 'redeemedAt': redeemedAt?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (conversationId != null) 'conversationId': conversationId,
      if (paymentToken != null) 'paymentToken': paymentToken,
      if (paymentId != null) 'paymentId': paymentId,
      if (paymentTransactionId != null)
        'paymentTransactionId': paymentTransactionId,
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
      'refundAttempts': refundAttempts,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Gift',
      if (id != null) 'id': id,
      if (senderId != null) 'senderId': senderId,
      if (sender != null) 'sender': sender?.toJsonForProtocol(),
      if (recipientId != null) 'recipientId': recipientId,
      if (recipient != null) 'recipient': recipient?.toJsonForProtocol(),
      if (shopId != null) 'shopId': shopId,
      if (shop != null) 'shop': shop?.toJsonForProtocol(),
      'senderName': senderName,
      'recipientName': recipientName,
      'shopName': shopName,
      'amountTl': amountTl,
      'commissionKurus': commissionKurus,
      'netKurus': netKurus,
      if (message != null) 'message': message,
      'status': status.toJson(),
      if (code != null) 'code': code,
      'createdAt': createdAt.toJson(),
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      if (redeemedAt != null) 'redeemedAt': redeemedAt?.toJson(),
      if (closedAt != null) 'closedAt': closedAt?.toJson(),
      if (refundedAt != null) 'refundedAt': refundedAt?.toJson(),
      'refundAttempts': refundAttempts,
    };
  }

  static GiftInclude include({
    _iovtxv26.StudentProfileInclude? sender,
    _iovtxv26.StudentProfileInclude? recipient,
    _isgf2ncs.ShopInclude? shop,
  }) {
    return GiftInclude._(
      sender: sender,
      recipient: recipient,
      shop: shop,
    );
  }

  static GiftIncludeList includeList({
    _is.WhereExpressionBuilder<GiftTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    GiftInclude? include,
  }) {
    return GiftIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GiftImpl extends Gift {
  _GiftImpl({
    int? id,
    int? senderId,
    _iovtxv26.StudentProfile? sender,
    int? recipientId,
    _iovtxv26.StudentProfile? recipient,
    int? shopId,
    _isgf2ncs.Shop? shop,
    required String senderName,
    required String recipientName,
    required String shopName,
    required int amountTl,
    required int commissionKurus,
    required int netKurus,
    String? message,
    required _igcewz2w.GiftStatus status,
    String? code,
    DateTime? createdAt,
    DateTime? paidAt,
    DateTime? expiresAt,
    DateTime? redeemedAt,
    DateTime? closedAt,
    String? conversationId,
    String? paymentToken,
    String? paymentId,
    String? paymentTransactionId,
    DateTime? refundedAt,
    int? refundAttempts,
  }) : super._(
         id: id,
         senderId: senderId,
         sender: sender,
         recipientId: recipientId,
         recipient: recipient,
         shopId: shopId,
         shop: shop,
         senderName: senderName,
         recipientName: recipientName,
         shopName: shopName,
         amountTl: amountTl,
         commissionKurus: commissionKurus,
         netKurus: netKurus,
         message: message,
         status: status,
         code: code,
         createdAt: createdAt,
         paidAt: paidAt,
         expiresAt: expiresAt,
         redeemedAt: redeemedAt,
         closedAt: closedAt,
         conversationId: conversationId,
         paymentToken: paymentToken,
         paymentId: paymentId,
         paymentTransactionId: paymentTransactionId,
         refundedAt: refundedAt,
         refundAttempts: refundAttempts,
       );

  /// Returns a shallow copy of this [Gift]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Gift copyWith({
    Object? id = _Undefined,
    Object? senderId = _Undefined,
    Object? sender = _Undefined,
    Object? recipientId = _Undefined,
    Object? recipient = _Undefined,
    Object? shopId = _Undefined,
    Object? shop = _Undefined,
    String? senderName,
    String? recipientName,
    String? shopName,
    int? amountTl,
    int? commissionKurus,
    int? netKurus,
    Object? message = _Undefined,
    _igcewz2w.GiftStatus? status,
    Object? code = _Undefined,
    DateTime? createdAt,
    Object? paidAt = _Undefined,
    Object? expiresAt = _Undefined,
    Object? redeemedAt = _Undefined,
    Object? closedAt = _Undefined,
    Object? conversationId = _Undefined,
    Object? paymentToken = _Undefined,
    Object? paymentId = _Undefined,
    Object? paymentTransactionId = _Undefined,
    Object? refundedAt = _Undefined,
    int? refundAttempts,
  }) {
    return Gift(
      id: id is int? ? id : this.id,
      senderId: senderId is int? ? senderId : this.senderId,
      sender: sender is _iovtxv26.StudentProfile?
          ? sender
          : this.sender?.copyWith(),
      recipientId: recipientId is int? ? recipientId : this.recipientId,
      recipient: recipient is _iovtxv26.StudentProfile?
          ? recipient
          : this.recipient?.copyWith(),
      shopId: shopId is int? ? shopId : this.shopId,
      shop: shop is _isgf2ncs.Shop? ? shop : this.shop?.copyWith(),
      senderName: senderName ?? this.senderName,
      recipientName: recipientName ?? this.recipientName,
      shopName: shopName ?? this.shopName,
      amountTl: amountTl ?? this.amountTl,
      commissionKurus: commissionKurus ?? this.commissionKurus,
      netKurus: netKurus ?? this.netKurus,
      message: message is String? ? message : this.message,
      status: status ?? this.status,
      code: code is String? ? code : this.code,
      createdAt: createdAt ?? this.createdAt,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      redeemedAt: redeemedAt is DateTime? ? redeemedAt : this.redeemedAt,
      closedAt: closedAt is DateTime? ? closedAt : this.closedAt,
      conversationId: conversationId is String?
          ? conversationId
          : this.conversationId,
      paymentToken: paymentToken is String? ? paymentToken : this.paymentToken,
      paymentId: paymentId is String? ? paymentId : this.paymentId,
      paymentTransactionId: paymentTransactionId is String?
          ? paymentTransactionId
          : this.paymentTransactionId,
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
      refundAttempts: refundAttempts ?? this.refundAttempts,
    );
  }
}

class GiftUpdateTable extends _is.UpdateTable<GiftTable> {
  GiftUpdateTable(super.table);

  _is.ColumnValue<int, int> senderId(int? value) => _is.ColumnValue(
    table.senderId,
    value,
  );

  _is.ColumnValue<int, int> recipientId(int? value) => _is.ColumnValue(
    table.recipientId,
    value,
  );

  _is.ColumnValue<int, int> shopId(int? value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<String, String> senderName(String value) => _is.ColumnValue(
    table.senderName,
    value,
  );

  _is.ColumnValue<String, String> recipientName(String value) =>
      _is.ColumnValue(
        table.recipientName,
        value,
      );

  _is.ColumnValue<String, String> shopName(String value) => _is.ColumnValue(
    table.shopName,
    value,
  );

  _is.ColumnValue<int, int> amountTl(int value) => _is.ColumnValue(
    table.amountTl,
    value,
  );

  _is.ColumnValue<int, int> commissionKurus(int value) => _is.ColumnValue(
    table.commissionKurus,
    value,
  );

  _is.ColumnValue<int, int> netKurus(int value) => _is.ColumnValue(
    table.netKurus,
    value,
  );

  _is.ColumnValue<String, String> message(String? value) => _is.ColumnValue(
    table.message,
    value,
  );

  _is.ColumnValue<_igcewz2w.GiftStatus, _igcewz2w.GiftStatus> status(
    _igcewz2w.GiftStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> code(String? value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> paidAt(DateTime? value) =>
      _is.ColumnValue(
        table.paidAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime? value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> redeemedAt(DateTime? value) =>
      _is.ColumnValue(
        table.redeemedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> closedAt(DateTime? value) =>
      _is.ColumnValue(
        table.closedAt,
        value,
      );

  _is.ColumnValue<String, String> conversationId(String? value) =>
      _is.ColumnValue(
        table.conversationId,
        value,
      );

  _is.ColumnValue<String, String> paymentToken(String? value) =>
      _is.ColumnValue(
        table.paymentToken,
        value,
      );

  _is.ColumnValue<String, String> paymentId(String? value) => _is.ColumnValue(
    table.paymentId,
    value,
  );

  _is.ColumnValue<String, String> paymentTransactionId(String? value) =>
      _is.ColumnValue(
        table.paymentTransactionId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> refundedAt(DateTime? value) =>
      _is.ColumnValue(
        table.refundedAt,
        value,
      );

  _is.ColumnValue<int, int> refundAttempts(int value) => _is.ColumnValue(
    table.refundAttempts,
    value,
  );
}

class GiftTable extends _is.Table<int?> {
  GiftTable({super.tableRelation}) : super(tableName: 'gift') {
    updateTable = GiftUpdateTable(this);
    senderId = _is.ColumnInt(
      'senderId',
      this,
    );
    recipientId = _is.ColumnInt(
      'recipientId',
      this,
    );
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    senderName = _is.ColumnString(
      'senderName',
      this,
    );
    recipientName = _is.ColumnString(
      'recipientName',
      this,
    );
    shopName = _is.ColumnString(
      'shopName',
      this,
    );
    amountTl = _is.ColumnInt(
      'amountTl',
      this,
    );
    commissionKurus = _is.ColumnInt(
      'commissionKurus',
      this,
    );
    netKurus = _is.ColumnInt(
      'netKurus',
      this,
    );
    message = _is.ColumnString(
      'message',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    paidAt = _is.ColumnDateTime(
      'paidAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    redeemedAt = _is.ColumnDateTime(
      'redeemedAt',
      this,
    );
    closedAt = _is.ColumnDateTime(
      'closedAt',
      this,
    );
    conversationId = _is.ColumnString(
      'conversationId',
      this,
    );
    paymentToken = _is.ColumnString(
      'paymentToken',
      this,
    );
    paymentId = _is.ColumnString(
      'paymentId',
      this,
    );
    paymentTransactionId = _is.ColumnString(
      'paymentTransactionId',
      this,
    );
    refundedAt = _is.ColumnDateTime(
      'refundedAt',
      this,
    );
    refundAttempts = _is.ColumnInt(
      'refundAttempts',
      this,
      hasDefault: true,
    );
  }

  late final GiftUpdateTable updateTable;

  late final _is.ColumnInt senderId;

  _iovtxv26.StudentProfileTable? _sender;

  late final _is.ColumnInt recipientId;

  _iovtxv26.StudentProfileTable? _recipient;

  late final _is.ColumnInt shopId;

  _isgf2ncs.ShopTable? _shop;

  /// Blanked when the person deletes their account.
  late final _is.ColumnString senderName;

  late final _is.ColumnString recipientName;

  late final _is.ColumnString shopName;

  /// Whole TL, 20–1000.
  late final _is.ColumnInt amountTl;

  late final _is.ColumnInt commissionKurus;

  /// What the place earns: amount minus commission.
  late final _is.ColumnInt netKurus;

  late final _is.ColumnString message;

  late final _is.ColumnEnum<_igcewz2w.GiftStatus> status;

  /// 6 chars, only shown to the recipient. QR: GIFT:<id>:<code>.
  late final _is.ColumnString code;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime paidAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime redeemedAt;

  late final _is.ColumnDateTime closedAt;

  /// iyzico bookkeeping, never sent to a client.
  late final _is.ColumnString conversationId;

  late final _is.ColumnString paymentToken;

  late final _is.ColumnString paymentId;

  late final _is.ColumnString paymentTransactionId;

  /// Set once the money is back with the sender (cancelled/expired gifts).
  late final _is.ColumnDateTime refundedAt;

  late final _is.ColumnInt refundAttempts;

  _iovtxv26.StudentProfileTable get sender {
    if (_sender != null) return _sender!;
    _sender = _is.createRelationTable(
      relationFieldName: 'sender',
      field: Gift.t.senderId,
      foreignField: _iovtxv26.StudentProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iovtxv26.StudentProfileTable(tableRelation: foreignTableRelation),
    );
    return _sender!;
  }

  _iovtxv26.StudentProfileTable get recipient {
    if (_recipient != null) return _recipient!;
    _recipient = _is.createRelationTable(
      relationFieldName: 'recipient',
      field: Gift.t.recipientId,
      foreignField: _iovtxv26.StudentProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iovtxv26.StudentProfileTable(tableRelation: foreignTableRelation),
    );
    return _recipient!;
  }

  _isgf2ncs.ShopTable get shop {
    if (_shop != null) return _shop!;
    _shop = _is.createRelationTable(
      relationFieldName: 'shop',
      field: Gift.t.shopId,
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
    senderId,
    recipientId,
    shopId,
    senderName,
    recipientName,
    shopName,
    amountTl,
    commissionKurus,
    netKurus,
    message,
    status,
    code,
    createdAt,
    paidAt,
    expiresAt,
    redeemedAt,
    closedAt,
    conversationId,
    paymentToken,
    paymentId,
    paymentTransactionId,
    refundedAt,
    refundAttempts,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'sender') {
      return sender;
    }
    if (relationField == 'recipient') {
      return recipient;
    }
    if (relationField == 'shop') {
      return shop;
    }
    return null;
  }
}

class GiftInclude extends _is.IncludeObject {
  GiftInclude._({
    _iovtxv26.StudentProfileInclude? sender,
    _iovtxv26.StudentProfileInclude? recipient,
    _isgf2ncs.ShopInclude? shop,
  }) {
    _sender = sender;
    _recipient = recipient;
    _shop = shop;
  }

  _iovtxv26.StudentProfileInclude? _sender;

  _iovtxv26.StudentProfileInclude? _recipient;

  _isgf2ncs.ShopInclude? _shop;

  @override
  Map<String, _is.Include?> get includes => {
    'sender': _sender,
    'recipient': _recipient,
    'shop': _shop,
  };

  @override
  _is.Table<int?> get table => Gift.t;
}

class GiftIncludeList extends _is.IncludeList {
  GiftIncludeList._({
    _is.WhereExpressionBuilder<GiftTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Gift.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Gift.t;
}

class GiftRepository {
  const GiftRepository._();

  final attachRow = const GiftAttachRowRepository._();

  final detachRow = const GiftDetachRowRepository._();

  /// Returns a list of [Gift]s matching the given query parameters.
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
  Future<List<Gift>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GiftTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    _is.Transaction? transaction,
    GiftInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Gift>(
      where: where?.call(Gift.t),
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Gift] matching the given query parameters.
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
  Future<Gift?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GiftTable>? where,
    int? offset,
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    _is.Transaction? transaction,
    GiftInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Gift>(
      where: where?.call(Gift.t),
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Gift] by its [id] or null if no such row exists.
  Future<Gift?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    GiftInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Gift>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Gift]s in the list and returns the inserted rows.
  ///
  /// The returned [Gift]s will have their `id` fields set.
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
  Future<List<Gift>> insert(
    _is.DatabaseSession session,
    List<Gift> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Gift>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Gift] and returns the inserted row.
  ///
  /// The returned [Gift] will have its `id` field set.
  Future<Gift> insertRow(
    _is.DatabaseSession session,
    Gift row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Gift>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Gift]s in the list and returns the resulting rows.
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
  /// The returned [Gift]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Gift>> upsert(
    _is.DatabaseSession session,
    List<Gift> rows, {
    required _is.ColumnSelections<GiftTable> conflictColumns,
    _is.ColumnSelections<GiftTable>? updateColumns,
    _is.WhereExpressionBuilder<GiftTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Gift>(
      rows,
      conflictColumns: conflictColumns(Gift.t),
      updateColumns: updateColumns?.call(Gift.t),
      updateWhere: updateWhere?.call(Gift.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Gift] and returns the resulting row.
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
  /// The returned [Gift] will have its `id` field set.
  Future<Gift?> upsertRow(
    _is.DatabaseSession session,
    Gift row, {
    required _is.ColumnSelections<GiftTable> conflictColumns,
    _is.ColumnSelections<GiftTable>? updateColumns,
    _is.WhereExpressionBuilder<GiftTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Gift>(
      row,
      conflictColumns: conflictColumns(Gift.t),
      updateColumns: updateColumns?.call(Gift.t),
      updateWhere: updateWhere?.call(Gift.t),
      transaction: transaction,
    );
  }

  /// Updates all [Gift]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Gift>> update(
    _is.DatabaseSession session,
    List<Gift> rows, {
    _is.ColumnSelections<GiftTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Gift>(
      rows,
      columns: columns?.call(Gift.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Gift]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Gift> updateRow(
    _is.DatabaseSession session,
    Gift row, {
    _is.ColumnSelections<GiftTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Gift>(
      row,
      columns: columns?.call(Gift.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Gift] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Gift?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<GiftUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Gift>(
      id,
      columnValues: columnValues(Gift.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Gift]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Gift>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<GiftUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<GiftTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Gift>(
      columnValues: columnValues(Gift.t.updateTable),
      where: where(Gift.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Gift]s in the list and returns the deleted rows.
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
  Future<List<Gift>> delete(
    _is.DatabaseSession session,
    List<Gift> rows, {
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Gift>(
      rows,
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Gift].
  Future<Gift> deleteRow(
    _is.DatabaseSession session,
    Gift row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Gift>(
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
  Future<List<Gift>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GiftTable> where,
    _is.OrderByBuilder<GiftTable>? orderBy,
    _is.OrderByListBuilder<GiftTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Gift>(
      where: where(Gift.t),
      orderBy: orderBy?.call(Gift.t),
      orderByList: orderByList?.call(Gift.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<GiftTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Gift>(
      where: where?.call(Gift.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Gift] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<GiftTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Gift>(
      where: where(Gift.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class GiftAttachRowRepository {
  const GiftAttachRowRepository._();

  /// Creates a relation between the given [Gift] and [StudentProfile]
  /// by setting the [Gift]'s foreign key `senderId` to refer to the [StudentProfile].
  Future<void> sender(
    _is.DatabaseSession session,
    Gift gift,
    _iovtxv26.StudentProfile sender, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }
    if (sender.id == null) {
      throw ArgumentError.notNull('sender.id');
    }

    var $gift = gift.copyWith(senderId: sender.id);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.senderId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Gift] and [StudentProfile]
  /// by setting the [Gift]'s foreign key `recipientId` to refer to the [StudentProfile].
  Future<void> recipient(
    _is.DatabaseSession session,
    Gift gift,
    _iovtxv26.StudentProfile recipient, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }
    if (recipient.id == null) {
      throw ArgumentError.notNull('recipient.id');
    }

    var $gift = gift.copyWith(recipientId: recipient.id);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.recipientId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Gift] and [Shop]
  /// by setting the [Gift]'s foreign key `shopId` to refer to the [Shop].
  Future<void> shop(
    _is.DatabaseSession session,
    Gift gift,
    _isgf2ncs.Shop shop, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }
    if (shop.id == null) {
      throw ArgumentError.notNull('shop.id');
    }

    var $gift = gift.copyWith(shopId: shop.id);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.shopId],
      transaction: transaction,
    );
  }
}

class GiftDetachRowRepository {
  const GiftDetachRowRepository._();

  /// Detaches the relation between this [Gift] and the [StudentProfile] set in `sender`
  /// by setting the [Gift]'s foreign key `senderId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> sender(
    _is.DatabaseSession session,
    Gift gift, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }

    var $gift = gift.copyWith(senderId: null);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.senderId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Gift] and the [StudentProfile] set in `recipient`
  /// by setting the [Gift]'s foreign key `recipientId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> recipient(
    _is.DatabaseSession session,
    Gift gift, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }

    var $gift = gift.copyWith(recipientId: null);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.recipientId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [Gift] and the [Shop] set in `shop`
  /// by setting the [Gift]'s foreign key `shopId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> shop(
    _is.DatabaseSession session,
    Gift gift, {
    _is.Transaction? transaction,
  }) async {
    if (gift.id == null) {
      throw ArgumentError.notNull('gift.id');
    }

    var $gift = gift.copyWith(shopId: null);
    await session.db.updateRow<Gift>(
      $gift,
      columns: [Gift.t.shopId],
      transaction: transaction,
    );
  }
}
