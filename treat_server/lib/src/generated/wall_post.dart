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
import 'package:serverpod/serverpod.dart' as _is;
import 'proof_type.dart' as _i671eu65;

/// An approved post a student chose to show publicly.
abstract class WallPost
    implements _is.SerializableModel, _is.ProtocolSerialization {
  WallPost._({
    required this.claimId,
    required this.studentId,
    required this.studentName,
    required this.university,
    required this.shopId,
    required this.shopName,
    required this.offerTitle,
    required this.proofType,
    this.thanksNote,
    required this.approvedAt,
    required this.imageUrl,
  });

  factory WallPost({
    required int claimId,
    required int studentId,
    required String studentName,
    required String university,
    required int shopId,
    required String shopName,
    required String offerTitle,
    required _i671eu65.ProofType proofType,
    String? thanksNote,
    required DateTime approvedAt,
    required String imageUrl,
  }) = _WallPostImpl;

  factory WallPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return WallPost(
      claimId: jsonSerialization['claimId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      university: jsonSerialization['university'] as String,
      shopId: jsonSerialization['shopId'] as int,
      shopName: jsonSerialization['shopName'] as String,
      offerTitle: jsonSerialization['offerTitle'] as String,
      proofType: _i671eu65.ProofType.fromJson(
        (jsonSerialization['proofType'] as String),
      ),
      thanksNote: jsonSerialization['thanksNote'] as String?,
      approvedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['approvedAt'],
      ),
      imageUrl: jsonSerialization['imageUrl'] as String,
    );
  }

  int claimId;

  int studentId;

  String studentName;

  String university;

  int shopId;

  String shopName;

  String offerTitle;

  _i671eu65.ProofType proofType;

  String? thanksNote;

  DateTime approvedAt;

  /// Short-lived link to the screenshot.
  String imageUrl;

  /// Returns a shallow copy of this [WallPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  WallPost copyWith({
    int? claimId,
    int? studentId,
    String? studentName,
    String? university,
    int? shopId,
    String? shopName,
    String? offerTitle,
    _i671eu65.ProofType? proofType,
    String? thanksNote,
    DateTime? approvedAt,
    String? imageUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WallPost',
      'claimId': claimId,
      'studentId': studentId,
      'studentName': studentName,
      'university': university,
      'shopId': shopId,
      'shopName': shopName,
      'offerTitle': offerTitle,
      'proofType': proofType.toJson(),
      if (thanksNote != null) 'thanksNote': thanksNote,
      'approvedAt': approvedAt.toJson(),
      'imageUrl': imageUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WallPost',
      'claimId': claimId,
      'studentId': studentId,
      'studentName': studentName,
      'university': university,
      'shopId': shopId,
      'shopName': shopName,
      'offerTitle': offerTitle,
      'proofType': proofType.toJson(),
      if (thanksNote != null) 'thanksNote': thanksNote,
      'approvedAt': approvedAt.toJson(),
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WallPostImpl extends WallPost {
  _WallPostImpl({
    required int claimId,
    required int studentId,
    required String studentName,
    required String university,
    required int shopId,
    required String shopName,
    required String offerTitle,
    required _i671eu65.ProofType proofType,
    String? thanksNote,
    required DateTime approvedAt,
    required String imageUrl,
  }) : super._(
         claimId: claimId,
         studentId: studentId,
         studentName: studentName,
         university: university,
         shopId: shopId,
         shopName: shopName,
         offerTitle: offerTitle,
         proofType: proofType,
         thanksNote: thanksNote,
         approvedAt: approvedAt,
         imageUrl: imageUrl,
       );

  /// Returns a shallow copy of this [WallPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  WallPost copyWith({
    int? claimId,
    int? studentId,
    String? studentName,
    String? university,
    int? shopId,
    String? shopName,
    String? offerTitle,
    _i671eu65.ProofType? proofType,
    Object? thanksNote = _Undefined,
    DateTime? approvedAt,
    String? imageUrl,
  }) {
    return WallPost(
      claimId: claimId ?? this.claimId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      university: university ?? this.university,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      offerTitle: offerTitle ?? this.offerTitle,
      proofType: proofType ?? this.proofType,
      thanksNote: thanksNote is String? ? thanksNote : this.thanksNote,
      approvedAt: approvedAt ?? this.approvedAt,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
