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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:treat_client/src/protocol/protocol.dart' as _iu07tsrf;
import 'offer_category.dart' as _iqmyfspq;
import 'student_verification.dart' as _ipqqbskf;

/// A student account. One per auth user.
abstract class StudentProfile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
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
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iu07tsrf.Protocol().deserialize<_iacc.AuthUser>(
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
      categoriesTried: _iu07tsrf.Protocol()
          .deserialize<List<_iqmyfspq.OfferCategory>>(
            jsonSerialization['categoriesTried'],
          ),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

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

  /// Returns a shallow copy of this [StudentProfile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StudentProfile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProfileImpl extends StudentProfile {
  _StudentProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
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
  @_isc.useResult
  @override
  StudentProfile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
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
      authUser: authUser is _iacc.AuthUser?
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
