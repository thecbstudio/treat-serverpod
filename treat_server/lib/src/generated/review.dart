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

/// One rated visit. Public on the place page; the place's own panel also
/// gets [privateNote].
abstract class Review
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Review._({
    required this.claimId,
    required this.studentId,
    required this.studentName,
    required this.university,
    required this.rating,
    this.review,
    this.privateNote,
    required this.offerTitle,
    required this.ratedAt,
  });

  factory Review({
    required int claimId,
    required int studentId,
    required String studentName,
    required String university,
    required int rating,
    String? review,
    String? privateNote,
    required String offerTitle,
    required DateTime ratedAt,
  }) = _ReviewImpl;

  factory Review.fromJson(Map<String, dynamic> jsonSerialization) {
    return Review(
      claimId: jsonSerialization['claimId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      university: jsonSerialization['university'] as String,
      rating: jsonSerialization['rating'] as int,
      review: jsonSerialization['review'] as String?,
      privateNote: jsonSerialization['privateNote'] as String?,
      offerTitle: jsonSerialization['offerTitle'] as String,
      ratedAt: _is.DateTimeJsonExtension.fromJson(jsonSerialization['ratedAt']),
    );
  }

  int claimId;

  int studentId;

  String studentName;

  String university;

  int rating;

  String? review;

  /// Only filled for the place itself.
  String? privateNote;

  String offerTitle;

  DateTime ratedAt;

  /// Returns a shallow copy of this [Review]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Review copyWith({
    int? claimId,
    int? studentId,
    String? studentName,
    String? university,
    int? rating,
    String? review,
    String? privateNote,
    String? offerTitle,
    DateTime? ratedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Review',
      'claimId': claimId,
      'studentId': studentId,
      'studentName': studentName,
      'university': university,
      'rating': rating,
      if (review != null) 'review': review,
      if (privateNote != null) 'privateNote': privateNote,
      'offerTitle': offerTitle,
      'ratedAt': ratedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Review',
      'claimId': claimId,
      'studentId': studentId,
      'studentName': studentName,
      'university': university,
      'rating': rating,
      if (review != null) 'review': review,
      if (privateNote != null) 'privateNote': privateNote,
      'offerTitle': offerTitle,
      'ratedAt': ratedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReviewImpl extends Review {
  _ReviewImpl({
    required int claimId,
    required int studentId,
    required String studentName,
    required String university,
    required int rating,
    String? review,
    String? privateNote,
    required String offerTitle,
    required DateTime ratedAt,
  }) : super._(
         claimId: claimId,
         studentId: studentId,
         studentName: studentName,
         university: university,
         rating: rating,
         review: review,
         privateNote: privateNote,
         offerTitle: offerTitle,
         ratedAt: ratedAt,
       );

  /// Returns a shallow copy of this [Review]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Review copyWith({
    int? claimId,
    int? studentId,
    String? studentName,
    String? university,
    int? rating,
    Object? review = _Undefined,
    Object? privateNote = _Undefined,
    String? offerTitle,
    DateTime? ratedAt,
  }) {
    return Review(
      claimId: claimId ?? this.claimId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      university: university ?? this.university,
      rating: rating ?? this.rating,
      review: review is String? ? review : this.review,
      privateNote: privateNote is String? ? privateNote : this.privateNote,
      offerTitle: offerTitle ?? this.offerTitle,
      ratedAt: ratedAt ?? this.ratedAt,
    );
  }
}
