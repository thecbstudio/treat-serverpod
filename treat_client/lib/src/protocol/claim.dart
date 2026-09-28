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
import 'claim_status.dart' as _i4cqplnc;
import 'offer.dart' as _iqlmmtnc;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'proof_type.dart' as _i671eu65;
import 'student_profile.dart' as _iovtxv26;

/// A student's claim on an offer. Caps and frequency locks are computed from
/// these rows (no counters), so an expired claim gives its slot back.
abstract class Claim
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Claim._({
    this.id,
    required this.offerId,
    this.offer,
    required this.shopId,
    required this.studentId,
    this.student,
    required this.studentName,
    required this.frequency,
    bool? fromDrop,
    required this.code,
    required this.status,
    DateTime? createdAt,
    required this.expiresAt,
    this.redeemedAt,
    this.proofType,
    this.proofSubmittedAt,
    this.decidedAt,
    this.verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    this.thanksNote,
  }) : fromDrop = fromDrop ?? false,
       createdAt = createdAt ?? DateTime.now(),
       appealed = appealed ?? false,
       verifyAttempts = verifyAttempts ?? 0,
       strikeGiven = strikeGiven ?? false,
       shareOnWall = shareOnWall ?? false;

  factory Claim({
    int? id,
    required int offerId,
    _iqlmmtnc.Offer? offer,
    required int shopId,
    required int studentId,
    _iovtxv26.StudentProfile? student,
    required String studentName,
    required _ix7dcs2a.OfferFrequency frequency,
    bool? fromDrop,
    required String code,
    required _i4cqplnc.ClaimStatus status,
    DateTime? createdAt,
    required DateTime expiresAt,
    DateTime? redeemedAt,
    _i671eu65.ProofType? proofType,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? thanksNote,
  }) = _ClaimImpl;

  factory Claim.fromJson(Map<String, dynamic> jsonSerialization) {
    return Claim(
      id: jsonSerialization['id'] as int?,
      offerId: jsonSerialization['offerId'] as int,
      offer: jsonSerialization['offer'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iqlmmtnc.Offer>(
              jsonSerialization['offer'],
            ),
      shopId: jsonSerialization['shopId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      student: jsonSerialization['student'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['student'],
            ),
      studentName: jsonSerialization['studentName'] as String,
      frequency: _ix7dcs2a.OfferFrequency.fromJson(
        (jsonSerialization['frequency'] as String),
      ),
      fromDrop: jsonSerialization['fromDrop'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['fromDrop']),
      code: jsonSerialization['code'] as String,
      status: _i4cqplnc.ClaimStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      redeemedAt: jsonSerialization['redeemedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['redeemedAt'],
            ),
      proofType: jsonSerialization['proofType'] == null
          ? null
          : _i671eu65.ProofType.fromJson(
              (jsonSerialization['proofType'] as String),
            ),
      proofSubmittedAt: jsonSerialization['proofSubmittedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['proofSubmittedAt'],
            ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
      verdictReason: jsonSerialization['verdictReason'] as String?,
      appealed: jsonSerialization['appealed'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['appealed']),
      verifyAttempts: jsonSerialization['verifyAttempts'] as int?,
      strikeGiven: jsonSerialization['strikeGiven'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['strikeGiven']),
      shareOnWall: jsonSerialization['shareOnWall'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['shareOnWall']),
      thanksNote: jsonSerialization['thanksNote'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offerId;

  _iqlmmtnc.Offer? offer;

  int shopId;

  int studentId;

  _iovtxv26.StudentProfile? student;

  String studentName;

  _ix7dcs2a.OfferFrequency frequency;

  /// Claimed from a drop: doesn't count toward the place's weekly/monthly
  /// limit on regular offers.
  bool fromDrop;

  /// 6 chars; unique among the shop's active claims.
  String code;

  _i4cqplnc.ClaimStatus status;

  DateTime createdAt;

  DateTime expiresAt;

  DateTime? redeemedAt;

  _i671eu65.ProofType? proofType;

  DateTime? proofSubmittedAt;

  /// When the proof was approved or rejected (streaks count approvals by this).
  DateTime? decidedAt;

  /// no_mention | not_a_post | unreadable
  String? verdictReason;

  bool appealed;

  int verifyAttempts;

  /// A claim can cost at most one strike; returned if an appeal is approved.
  bool strikeGiven;

  /// Student agreed to show the approved post on the place's public page.
  bool shareOnWall;

  /// Optional thank-you note to the place, written after approval.
  String? thanksNote;

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Claim copyWith({
    int? id,
    int? offerId,
    _iqlmmtnc.Offer? offer,
    int? shopId,
    int? studentId,
    _iovtxv26.StudentProfile? student,
    String? studentName,
    _ix7dcs2a.OfferFrequency? frequency,
    bool? fromDrop,
    String? code,
    _i4cqplnc.ClaimStatus? status,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? redeemedAt,
    _i671eu65.ProofType? proofType,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? thanksNote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Claim',
      if (id != null) 'id': id,
      'offerId': offerId,
      if (offer != null) 'offer': offer?.toJson(),
      'shopId': shopId,
      'studentId': studentId,
      if (student != null) 'student': student?.toJson(),
      'studentName': studentName,
      'frequency': frequency.toJson(),
      'fromDrop': fromDrop,
      'code': code,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (redeemedAt != null) 'redeemedAt': redeemedAt?.toJson(),
      if (proofType != null) 'proofType': proofType?.toJson(),
      if (proofSubmittedAt != null)
        'proofSubmittedAt': proofSubmittedAt?.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
      if (verdictReason != null) 'verdictReason': verdictReason,
      'appealed': appealed,
      'verifyAttempts': verifyAttempts,
      'strikeGiven': strikeGiven,
      'shareOnWall': shareOnWall,
      if (thanksNote != null) 'thanksNote': thanksNote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Claim',
      if (id != null) 'id': id,
      'offerId': offerId,
      if (offer != null) 'offer': offer?.toJsonForProtocol(),
      'shopId': shopId,
      'studentId': studentId,
      if (student != null) 'student': student?.toJsonForProtocol(),
      'studentName': studentName,
      'frequency': frequency.toJson(),
      'fromDrop': fromDrop,
      'code': code,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (redeemedAt != null) 'redeemedAt': redeemedAt?.toJson(),
      if (proofType != null) 'proofType': proofType?.toJson(),
      if (proofSubmittedAt != null)
        'proofSubmittedAt': proofSubmittedAt?.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
      if (verdictReason != null) 'verdictReason': verdictReason,
      'appealed': appealed,
      'verifyAttempts': verifyAttempts,
      'strikeGiven': strikeGiven,
      'shareOnWall': shareOnWall,
      if (thanksNote != null) 'thanksNote': thanksNote,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClaimImpl extends Claim {
  _ClaimImpl({
    int? id,
    required int offerId,
    _iqlmmtnc.Offer? offer,
    required int shopId,
    required int studentId,
    _iovtxv26.StudentProfile? student,
    required String studentName,
    required _ix7dcs2a.OfferFrequency frequency,
    bool? fromDrop,
    required String code,
    required _i4cqplnc.ClaimStatus status,
    DateTime? createdAt,
    required DateTime expiresAt,
    DateTime? redeemedAt,
    _i671eu65.ProofType? proofType,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? thanksNote,
  }) : super._(
         id: id,
         offerId: offerId,
         offer: offer,
         shopId: shopId,
         studentId: studentId,
         student: student,
         studentName: studentName,
         frequency: frequency,
         fromDrop: fromDrop,
         code: code,
         status: status,
         createdAt: createdAt,
         expiresAt: expiresAt,
         redeemedAt: redeemedAt,
         proofType: proofType,
         proofSubmittedAt: proofSubmittedAt,
         decidedAt: decidedAt,
         verdictReason: verdictReason,
         appealed: appealed,
         verifyAttempts: verifyAttempts,
         strikeGiven: strikeGiven,
         shareOnWall: shareOnWall,
         thanksNote: thanksNote,
       );

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Claim copyWith({
    Object? id = _Undefined,
    int? offerId,
    Object? offer = _Undefined,
    int? shopId,
    int? studentId,
    Object? student = _Undefined,
    String? studentName,
    _ix7dcs2a.OfferFrequency? frequency,
    bool? fromDrop,
    String? code,
    _i4cqplnc.ClaimStatus? status,
    DateTime? createdAt,
    DateTime? expiresAt,
    Object? redeemedAt = _Undefined,
    Object? proofType = _Undefined,
    Object? proofSubmittedAt = _Undefined,
    Object? decidedAt = _Undefined,
    Object? verdictReason = _Undefined,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    Object? thanksNote = _Undefined,
  }) {
    return Claim(
      id: id is int? ? id : this.id,
      offerId: offerId ?? this.offerId,
      offer: offer is _iqlmmtnc.Offer? ? offer : this.offer?.copyWith(),
      shopId: shopId ?? this.shopId,
      studentId: studentId ?? this.studentId,
      student: student is _iovtxv26.StudentProfile?
          ? student
          : this.student?.copyWith(),
      studentName: studentName ?? this.studentName,
      frequency: frequency ?? this.frequency,
      fromDrop: fromDrop ?? this.fromDrop,
      code: code ?? this.code,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      redeemedAt: redeemedAt is DateTime? ? redeemedAt : this.redeemedAt,
      proofType: proofType is _i671eu65.ProofType? ? proofType : this.proofType,
      proofSubmittedAt: proofSubmittedAt is DateTime?
          ? proofSubmittedAt
          : this.proofSubmittedAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
      verdictReason: verdictReason is String?
          ? verdictReason
          : this.verdictReason,
      appealed: appealed ?? this.appealed,
      verifyAttempts: verifyAttempts ?? this.verifyAttempts,
      strikeGiven: strikeGiven ?? this.strikeGiven,
      shareOnWall: shareOnWall ?? this.shareOnWall,
      thanksNote: thanksNote is String? ? thanksNote : this.thanksNote,
    );
  }
}
