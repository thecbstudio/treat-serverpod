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
import 'claim_status.dart' as _i4cqplnc;
import 'offer.dart' as _iqlmmtnc;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'proof_type.dart' as _i671eu65;
import 'student_profile.dart' as _iovtxv26;

/// A student's claim on an offer. Caps and frequency locks are computed from
/// these rows (no counters), so an expired claim gives its slot back.
abstract class Claim implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    this.proofPath,
    this.proofSubmittedAt,
    this.decidedAt,
    this.verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    this.postUrl,
    this.stillUpCheckedAt,
    this.thanksNote,
    this.rating,
    this.review,
    this.privateNote,
    this.ratedAt,
    bool? reviewHidden,
    bool? wallHidden,
  }) : fromDrop = fromDrop ?? false,
       createdAt = createdAt ?? DateTime.now(),
       appealed = appealed ?? false,
       verifyAttempts = verifyAttempts ?? 0,
       strikeGiven = strikeGiven ?? false,
       shareOnWall = shareOnWall ?? false,
       reviewHidden = reviewHidden ?? false,
       wallHidden = wallHidden ?? false;

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
    String? proofPath,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? postUrl,
    DateTime? stillUpCheckedAt,
    String? thanksNote,
    int? rating,
    String? review,
    String? privateNote,
    DateTime? ratedAt,
    bool? reviewHidden,
    bool? wallHidden,
  }) = _ClaimImpl;

  factory Claim.fromJson(Map<String, dynamic> jsonSerialization) {
    return Claim(
      id: jsonSerialization['id'] as int?,
      offerId: jsonSerialization['offerId'] as int,
      offer: jsonSerialization['offer'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iqlmmtnc.Offer>(
              jsonSerialization['offer'],
            ),
      shopId: jsonSerialization['shopId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      student: jsonSerialization['student'] == null
          ? null
          : _iegszk5h.Protocol().deserialize<_iovtxv26.StudentProfile>(
              jsonSerialization['student'],
            ),
      studentName: jsonSerialization['studentName'] as String,
      frequency: _ix7dcs2a.OfferFrequency.fromJson(
        (jsonSerialization['frequency'] as String),
      ),
      fromDrop: jsonSerialization['fromDrop'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['fromDrop']),
      code: jsonSerialization['code'] as String,
      status: _i4cqplnc.ClaimStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      redeemedAt: jsonSerialization['redeemedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['redeemedAt']),
      proofType: jsonSerialization['proofType'] == null
          ? null
          : _i671eu65.ProofType.fromJson(
              (jsonSerialization['proofType'] as String),
            ),
      proofPath: jsonSerialization['proofPath'] as String?,
      proofSubmittedAt: jsonSerialization['proofSubmittedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['proofSubmittedAt'],
            ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
      verdictReason: jsonSerialization['verdictReason'] as String?,
      appealed: jsonSerialization['appealed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['appealed']),
      verifyAttempts: jsonSerialization['verifyAttempts'] as int?,
      strikeGiven: jsonSerialization['strikeGiven'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['strikeGiven']),
      shareOnWall: jsonSerialization['shareOnWall'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['shareOnWall']),
      postUrl: jsonSerialization['postUrl'] as String?,
      stillUpCheckedAt: jsonSerialization['stillUpCheckedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['stillUpCheckedAt'],
            ),
      thanksNote: jsonSerialization['thanksNote'] as String?,
      rating: jsonSerialization['rating'] as int?,
      review: jsonSerialization['review'] as String?,
      privateNote: jsonSerialization['privateNote'] as String?,
      ratedAt: jsonSerialization['ratedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['ratedAt']),
      reviewHidden: jsonSerialization['reviewHidden'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['reviewHidden']),
      wallHidden: jsonSerialization['wallHidden'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['wallHidden']),
    );
  }

  static final t = ClaimTable();

  static const db = ClaimRepository._();

  @override
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

  /// Path in private storage.
  String? proofPath;

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

  /// Link to the post for permanent kinds (Instagram feed post / Reel,
  /// TikTok): the place can open it, and TikTok links are re-checked.
  String? postUrl;

  /// When the "is the TikTok still up?" check ran (7 days after approval).
  DateTime? stillUpCheckedAt;

  /// Optional thank-you note to the place, written after approval.
  String? thanksNote;

  /// The visit's rating (1–5), from a student who was scanned in. Never
  /// affects the treat. Public, labelled "verified visit · free treat".
  int? rating;

  /// Optional public short review with the rating.
  String? review;

  /// Optional note only the place sees.
  String? privateNote;

  DateTime? ratedAt;

  /// Hidden from public pages after reports from different users.
  bool reviewHidden;

  bool wallHidden;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    String? proofPath,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? postUrl,
    DateTime? stillUpCheckedAt,
    String? thanksNote,
    int? rating,
    String? review,
    String? privateNote,
    DateTime? ratedAt,
    bool? reviewHidden,
    bool? wallHidden,
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
      if (proofPath != null) 'proofPath': proofPath,
      if (proofSubmittedAt != null)
        'proofSubmittedAt': proofSubmittedAt?.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
      if (verdictReason != null) 'verdictReason': verdictReason,
      'appealed': appealed,
      'verifyAttempts': verifyAttempts,
      'strikeGiven': strikeGiven,
      'shareOnWall': shareOnWall,
      if (postUrl != null) 'postUrl': postUrl,
      if (stillUpCheckedAt != null)
        'stillUpCheckedAt': stillUpCheckedAt?.toJson(),
      if (thanksNote != null) 'thanksNote': thanksNote,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
      if (privateNote != null) 'privateNote': privateNote,
      if (ratedAt != null) 'ratedAt': ratedAt?.toJson(),
      'reviewHidden': reviewHidden,
      'wallHidden': wallHidden,
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
      if (postUrl != null) 'postUrl': postUrl,
      if (stillUpCheckedAt != null)
        'stillUpCheckedAt': stillUpCheckedAt?.toJson(),
      if (thanksNote != null) 'thanksNote': thanksNote,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
      if (privateNote != null) 'privateNote': privateNote,
      if (ratedAt != null) 'ratedAt': ratedAt?.toJson(),
      'reviewHidden': reviewHidden,
      'wallHidden': wallHidden,
    };
  }

  static ClaimInclude include({
    _iqlmmtnc.OfferInclude? offer,
    _iovtxv26.StudentProfileInclude? student,
  }) {
    return ClaimInclude._(
      offer: offer,
      student: student,
    );
  }

  static ClaimIncludeList includeList({
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    ClaimInclude? include,
  }) {
    return ClaimIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    String? proofPath,
    DateTime? proofSubmittedAt,
    DateTime? decidedAt,
    String? verdictReason,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    String? postUrl,
    DateTime? stillUpCheckedAt,
    String? thanksNote,
    int? rating,
    String? review,
    String? privateNote,
    DateTime? ratedAt,
    bool? reviewHidden,
    bool? wallHidden,
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
         proofPath: proofPath,
         proofSubmittedAt: proofSubmittedAt,
         decidedAt: decidedAt,
         verdictReason: verdictReason,
         appealed: appealed,
         verifyAttempts: verifyAttempts,
         strikeGiven: strikeGiven,
         shareOnWall: shareOnWall,
         postUrl: postUrl,
         stillUpCheckedAt: stillUpCheckedAt,
         thanksNote: thanksNote,
         rating: rating,
         review: review,
         privateNote: privateNote,
         ratedAt: ratedAt,
         reviewHidden: reviewHidden,
         wallHidden: wallHidden,
       );

  /// Returns a shallow copy of this [Claim]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? proofPath = _Undefined,
    Object? proofSubmittedAt = _Undefined,
    Object? decidedAt = _Undefined,
    Object? verdictReason = _Undefined,
    bool? appealed,
    int? verifyAttempts,
    bool? strikeGiven,
    bool? shareOnWall,
    Object? postUrl = _Undefined,
    Object? stillUpCheckedAt = _Undefined,
    Object? thanksNote = _Undefined,
    Object? rating = _Undefined,
    Object? review = _Undefined,
    Object? privateNote = _Undefined,
    Object? ratedAt = _Undefined,
    bool? reviewHidden,
    bool? wallHidden,
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
      proofPath: proofPath is String? ? proofPath : this.proofPath,
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
      postUrl: postUrl is String? ? postUrl : this.postUrl,
      stillUpCheckedAt: stillUpCheckedAt is DateTime?
          ? stillUpCheckedAt
          : this.stillUpCheckedAt,
      thanksNote: thanksNote is String? ? thanksNote : this.thanksNote,
      rating: rating is int? ? rating : this.rating,
      review: review is String? ? review : this.review,
      privateNote: privateNote is String? ? privateNote : this.privateNote,
      ratedAt: ratedAt is DateTime? ? ratedAt : this.ratedAt,
      reviewHidden: reviewHidden ?? this.reviewHidden,
      wallHidden: wallHidden ?? this.wallHidden,
    );
  }
}

class ClaimUpdateTable extends _is.UpdateTable<ClaimTable> {
  ClaimUpdateTable(super.table);

  _is.ColumnValue<int, int> offerId(int value) => _is.ColumnValue(
    table.offerId,
    value,
  );

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<int, int> studentId(int value) => _is.ColumnValue(
    table.studentId,
    value,
  );

  _is.ColumnValue<String, String> studentName(String value) => _is.ColumnValue(
    table.studentName,
    value,
  );

  _is.ColumnValue<_ix7dcs2a.OfferFrequency, _ix7dcs2a.OfferFrequency> frequency(
    _ix7dcs2a.OfferFrequency value,
  ) => _is.ColumnValue(
    table.frequency,
    value,
  );

  _is.ColumnValue<bool, bool> fromDrop(bool value) => _is.ColumnValue(
    table.fromDrop,
    value,
  );

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<_i4cqplnc.ClaimStatus, _i4cqplnc.ClaimStatus> status(
    _i4cqplnc.ClaimStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> redeemedAt(DateTime? value) =>
      _is.ColumnValue(
        table.redeemedAt,
        value,
      );

  _is.ColumnValue<_i671eu65.ProofType, _i671eu65.ProofType> proofType(
    _i671eu65.ProofType? value,
  ) => _is.ColumnValue(
    table.proofType,
    value,
  );

  _is.ColumnValue<String, String> proofPath(String? value) => _is.ColumnValue(
    table.proofPath,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> proofSubmittedAt(DateTime? value) =>
      _is.ColumnValue(
        table.proofSubmittedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );

  _is.ColumnValue<String, String> verdictReason(String? value) =>
      _is.ColumnValue(
        table.verdictReason,
        value,
      );

  _is.ColumnValue<bool, bool> appealed(bool value) => _is.ColumnValue(
    table.appealed,
    value,
  );

  _is.ColumnValue<int, int> verifyAttempts(int value) => _is.ColumnValue(
    table.verifyAttempts,
    value,
  );

  _is.ColumnValue<bool, bool> strikeGiven(bool value) => _is.ColumnValue(
    table.strikeGiven,
    value,
  );

  _is.ColumnValue<bool, bool> shareOnWall(bool value) => _is.ColumnValue(
    table.shareOnWall,
    value,
  );

  _is.ColumnValue<String, String> postUrl(String? value) => _is.ColumnValue(
    table.postUrl,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> stillUpCheckedAt(DateTime? value) =>
      _is.ColumnValue(
        table.stillUpCheckedAt,
        value,
      );

  _is.ColumnValue<String, String> thanksNote(String? value) => _is.ColumnValue(
    table.thanksNote,
    value,
  );

  _is.ColumnValue<int, int> rating(int? value) => _is.ColumnValue(
    table.rating,
    value,
  );

  _is.ColumnValue<String, String> review(String? value) => _is.ColumnValue(
    table.review,
    value,
  );

  _is.ColumnValue<String, String> privateNote(String? value) => _is.ColumnValue(
    table.privateNote,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> ratedAt(DateTime? value) =>
      _is.ColumnValue(
        table.ratedAt,
        value,
      );

  _is.ColumnValue<bool, bool> reviewHidden(bool value) => _is.ColumnValue(
    table.reviewHidden,
    value,
  );

  _is.ColumnValue<bool, bool> wallHidden(bool value) => _is.ColumnValue(
    table.wallHidden,
    value,
  );
}

class ClaimTable extends _is.Table<int?> {
  ClaimTable({super.tableRelation}) : super(tableName: 'claim') {
    updateTable = ClaimUpdateTable(this);
    offerId = _is.ColumnInt(
      'offerId',
      this,
    );
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    studentId = _is.ColumnInt(
      'studentId',
      this,
    );
    studentName = _is.ColumnString(
      'studentName',
      this,
    );
    frequency = _is.ColumnEnum(
      'frequency',
      this,
      _is.EnumSerialization.byName,
    );
    fromDrop = _is.ColumnBool(
      'fromDrop',
      this,
      hasDefault: true,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    redeemedAt = _is.ColumnDateTime(
      'redeemedAt',
      this,
    );
    proofType = _is.ColumnEnum(
      'proofType',
      this,
      _is.EnumSerialization.byName,
    );
    proofPath = _is.ColumnString(
      'proofPath',
      this,
    );
    proofSubmittedAt = _is.ColumnDateTime(
      'proofSubmittedAt',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
    verdictReason = _is.ColumnString(
      'verdictReason',
      this,
    );
    appealed = _is.ColumnBool(
      'appealed',
      this,
      hasDefault: true,
    );
    verifyAttempts = _is.ColumnInt(
      'verifyAttempts',
      this,
      hasDefault: true,
    );
    strikeGiven = _is.ColumnBool(
      'strikeGiven',
      this,
      hasDefault: true,
    );
    shareOnWall = _is.ColumnBool(
      'shareOnWall',
      this,
      hasDefault: true,
    );
    postUrl = _is.ColumnString(
      'postUrl',
      this,
    );
    stillUpCheckedAt = _is.ColumnDateTime(
      'stillUpCheckedAt',
      this,
    );
    thanksNote = _is.ColumnString(
      'thanksNote',
      this,
    );
    rating = _is.ColumnInt(
      'rating',
      this,
    );
    review = _is.ColumnString(
      'review',
      this,
    );
    privateNote = _is.ColumnString(
      'privateNote',
      this,
    );
    ratedAt = _is.ColumnDateTime(
      'ratedAt',
      this,
    );
    reviewHidden = _is.ColumnBool(
      'reviewHidden',
      this,
      hasDefault: true,
    );
    wallHidden = _is.ColumnBool(
      'wallHidden',
      this,
      hasDefault: true,
    );
  }

  late final ClaimUpdateTable updateTable;

  late final _is.ColumnInt offerId;

  _iqlmmtnc.OfferTable? _offer;

  late final _is.ColumnInt shopId;

  late final _is.ColumnInt studentId;

  _iovtxv26.StudentProfileTable? _student;

  late final _is.ColumnString studentName;

  late final _is.ColumnEnum<_ix7dcs2a.OfferFrequency> frequency;

  /// Claimed from a drop: doesn't count toward the place's weekly/monthly
  /// limit on regular offers.
  late final _is.ColumnBool fromDrop;

  /// 6 chars; unique among the shop's active claims.
  late final _is.ColumnString code;

  late final _is.ColumnEnum<_i4cqplnc.ClaimStatus> status;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime redeemedAt;

  late final _is.ColumnEnum<_i671eu65.ProofType> proofType;

  /// Path in private storage.
  late final _is.ColumnString proofPath;

  late final _is.ColumnDateTime proofSubmittedAt;

  /// When the proof was approved or rejected (streaks count approvals by this).
  late final _is.ColumnDateTime decidedAt;

  /// no_mention | not_a_post | unreadable
  late final _is.ColumnString verdictReason;

  late final _is.ColumnBool appealed;

  late final _is.ColumnInt verifyAttempts;

  /// A claim can cost at most one strike; returned if an appeal is approved.
  late final _is.ColumnBool strikeGiven;

  /// Student agreed to show the approved post on the place's public page.
  late final _is.ColumnBool shareOnWall;

  /// Link to the post for permanent kinds (Instagram feed post / Reel,
  /// TikTok): the place can open it, and TikTok links are re-checked.
  late final _is.ColumnString postUrl;

  /// When the "is the TikTok still up?" check ran (7 days after approval).
  late final _is.ColumnDateTime stillUpCheckedAt;

  /// Optional thank-you note to the place, written after approval.
  late final _is.ColumnString thanksNote;

  /// The visit's rating (1–5), from a student who was scanned in. Never
  /// affects the treat. Public, labelled "verified visit · free treat".
  late final _is.ColumnInt rating;

  /// Optional public short review with the rating.
  late final _is.ColumnString review;

  /// Optional note only the place sees.
  late final _is.ColumnString privateNote;

  late final _is.ColumnDateTime ratedAt;

  /// Hidden from public pages after reports from different users.
  late final _is.ColumnBool reviewHidden;

  late final _is.ColumnBool wallHidden;

  _iqlmmtnc.OfferTable get offer {
    if (_offer != null) return _offer!;
    _offer = _is.createRelationTable(
      relationFieldName: 'offer',
      field: Claim.t.offerId,
      foreignField: _iqlmmtnc.Offer.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iqlmmtnc.OfferTable(tableRelation: foreignTableRelation),
    );
    return _offer!;
  }

  _iovtxv26.StudentProfileTable get student {
    if (_student != null) return _student!;
    _student = _is.createRelationTable(
      relationFieldName: 'student',
      field: Claim.t.studentId,
      foreignField: _iovtxv26.StudentProfile.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iovtxv26.StudentProfileTable(tableRelation: foreignTableRelation),
    );
    return _student!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    offerId,
    shopId,
    studentId,
    studentName,
    frequency,
    fromDrop,
    code,
    status,
    createdAt,
    expiresAt,
    redeemedAt,
    proofType,
    proofPath,
    proofSubmittedAt,
    decidedAt,
    verdictReason,
    appealed,
    verifyAttempts,
    strikeGiven,
    shareOnWall,
    postUrl,
    stillUpCheckedAt,
    thanksNote,
    rating,
    review,
    privateNote,
    ratedAt,
    reviewHidden,
    wallHidden,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'offer') {
      return offer;
    }
    if (relationField == 'student') {
      return student;
    }
    return null;
  }
}

class ClaimInclude extends _is.IncludeObject {
  ClaimInclude._({
    _iqlmmtnc.OfferInclude? offer,
    _iovtxv26.StudentProfileInclude? student,
  }) {
    _offer = offer;
    _student = student;
  }

  _iqlmmtnc.OfferInclude? _offer;

  _iovtxv26.StudentProfileInclude? _student;

  @override
  Map<String, _is.Include?> get includes => {
    'offer': _offer,
    'student': _student,
  };

  @override
  _is.Table<int?> get table => Claim.t;
}

class ClaimIncludeList extends _is.IncludeList {
  ClaimIncludeList._({
    _is.WhereExpressionBuilder<ClaimTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Claim.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Claim.t;
}

class ClaimRepository {
  const ClaimRepository._();

  final attachRow = const ClaimAttachRowRepository._();

  /// Returns a list of [Claim]s matching the given query parameters.
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
  Future<List<Claim>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    ClaimInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Claim>(
      where: where?.call(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Claim] matching the given query parameters.
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
  Future<Claim?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    ClaimInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Claim>(
      where: where?.call(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Claim] by its [id] or null if no such row exists.
  Future<Claim?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ClaimInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Claim>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Claim]s in the list and returns the inserted rows.
  ///
  /// The returned [Claim]s will have their `id` fields set.
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
  Future<List<Claim>> insert(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Claim>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Claim] and returns the inserted row.
  ///
  /// The returned [Claim] will have its `id` field set.
  Future<Claim> insertRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Claim>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Claim]s in the list and returns the resulting rows.
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
  /// The returned [Claim]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> upsert(
    _is.DatabaseSession session,
    List<Claim> rows, {
    required _is.ColumnSelections<ClaimTable> conflictColumns,
    _is.ColumnSelections<ClaimTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Claim>(
      rows,
      conflictColumns: conflictColumns(Claim.t),
      updateColumns: updateColumns?.call(Claim.t),
      updateWhere: updateWhere?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Claim] and returns the resulting row.
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
  /// The returned [Claim] will have its `id` field set.
  Future<Claim?> upsertRow(
    _is.DatabaseSession session,
    Claim row, {
    required _is.ColumnSelections<ClaimTable> conflictColumns,
    _is.ColumnSelections<ClaimTable>? updateColumns,
    _is.WhereExpressionBuilder<ClaimTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Claim>(
      row,
      conflictColumns: conflictColumns(Claim.t),
      updateColumns: updateColumns?.call(Claim.t),
      updateWhere: updateWhere?.call(Claim.t),
      transaction: transaction,
    );
  }

  /// Updates all [Claim]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> update(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.ColumnSelections<ClaimTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Claim>(
      rows,
      columns: columns?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Claim]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Claim> updateRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.ColumnSelections<ClaimTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Claim>(
      row,
      columns: columns?.call(Claim.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Claim] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Claim?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClaimUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Claim>(
      id,
      columnValues: columnValues(Claim.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Claim]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Claim>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClaimUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ClaimTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Claim>(
      columnValues: columnValues(Claim.t.updateTable),
      where: where(Claim.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Claim]s in the list and returns the deleted rows.
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
  Future<List<Claim>> delete(
    _is.DatabaseSession session,
    List<Claim> rows, {
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Claim>(
      rows,
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Claim].
  Future<Claim> deleteRow(
    _is.DatabaseSession session,
    Claim row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Claim>(
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
  Future<List<Claim>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimTable> where,
    _is.OrderByBuilder<ClaimTable>? orderBy,
    _is.OrderByListBuilder<ClaimTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Claim>(
      where: where(Claim.t),
      orderBy: orderBy?.call(Claim.t),
      orderByList: orderByList?.call(Claim.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClaimTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Claim>(
      where: where?.call(Claim.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Claim] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClaimTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Claim>(
      where: where(Claim.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ClaimAttachRowRepository {
  const ClaimAttachRowRepository._();

  /// Creates a relation between the given [Claim] and [Offer]
  /// by setting the [Claim]'s foreign key `offerId` to refer to the [Offer].
  Future<void> offer(
    _is.DatabaseSession session,
    Claim claim,
    _iqlmmtnc.Offer offer, {
    _is.Transaction? transaction,
  }) async {
    if (claim.id == null) {
      throw ArgumentError.notNull('claim.id');
    }
    if (offer.id == null) {
      throw ArgumentError.notNull('offer.id');
    }

    var $claim = claim.copyWith(offerId: offer.id);
    await session.db.updateRow<Claim>(
      $claim,
      columns: [Claim.t.offerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Claim] and [StudentProfile]
  /// by setting the [Claim]'s foreign key `studentId` to refer to the [StudentProfile].
  Future<void> student(
    _is.DatabaseSession session,
    Claim claim,
    _iovtxv26.StudentProfile student, {
    _is.Transaction? transaction,
  }) async {
    if (claim.id == null) {
      throw ArgumentError.notNull('claim.id');
    }
    if (student.id == null) {
      throw ArgumentError.notNull('student.id');
    }

    var $claim = claim.copyWith(studentId: student.id);
    await session.db.updateRow<Claim>(
      $claim,
      columns: [Claim.t.studentId],
      transaction: transaction,
    );
  }
}
