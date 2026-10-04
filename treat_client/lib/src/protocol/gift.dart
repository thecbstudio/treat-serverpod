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
import 'gift_status.dart' as _igcewz2w;
import 'shop.dart' as _isgf2ncs;
import 'student_profile.dart' as _iovtxv26;

/// A paid treat one student gives another, to collect at a place. The sender
/// pays through iyzico; the place hands it over against a QR/code; treat keeps
/// 15 % (the rest is the place's, shown as "to pay out"). Closed gifts are
/// refunded. Rows stay after an account is deleted (accounting), without names.
abstract class Gift
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    DateTime? refundedAt,
    int? refundAttempts,
  }) = _GiftImpl;

  factory Gift.fromJson(Map<String, dynamic> jsonSerialization) {
    return Gift(
      id: jsonSerialization['id'] as int?,
      senderId: jsonSerialization['senderId'] as int?,
      sender: jsonSerialization['sender'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['sender'],
            ),
      recipientId: jsonSerialization['recipientId'] as int?,
      recipient: jsonSerialization['recipient'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['recipient'],
            ),
      shopId: jsonSerialization['shopId'] as int?,
      shop: jsonSerialization['shop'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_isgf2ncs.Shop>(
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      redeemedAt: jsonSerialization['redeemedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['redeemedAt'],
            ),
      closedAt: jsonSerialization['closedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['closedAt']),
      refundedAt: jsonSerialization['refundedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['refundedAt'],
            ),
      refundAttempts: jsonSerialization['refundAttempts'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Set once the money is back with the sender (cancelled/expired gifts).
  DateTime? refundedAt;

  int refundAttempts;

  /// Returns a shallow copy of this [Gift]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
         refundedAt: refundedAt,
         refundAttempts: refundAttempts,
       );

  /// Returns a shallow copy of this [Gift]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
      refundedAt: refundedAt is DateTime? ? refundedAt : this.refundedAt,
      refundAttempts: refundAttempts ?? this.refundAttempts,
    );
  }
}
