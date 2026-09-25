/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:treat_server/src/generated/offer_card.dart' as _ipkteuk5;
import 'badge_id.dart' as _i14xwlyb;
import 'claim.dart' as _iywv5oz4;
import 'claim_status.dart' as _i4cqplnc;
import 'eligibility.dart' as _iapxm79h;
import 'eligibility_reason.dart' as _ixt5yy28;
import 'me.dart' as _i22ljs0z;
import 'offer.dart' as _iqlmmtnc;
import 'offer_card.dart' as _irfq3mof;
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_input.dart' as _in0575rn;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'shop.dart' as _isgf2ncs;
import 'shop_input.dart' as _i5vfstp6;
import 'student_profile.dart' as _iovtxv26;
import 'student_verification.dart' as _ipqqbskf;
import 'treat_exception.dart' as _iawcmjml;
import 'user_role.dart' as _ir0y0iu6;
export 'badge_id.dart';
export 'claim.dart';
export 'claim_status.dart';
export 'eligibility.dart';
export 'eligibility_reason.dart';
export 'me.dart';
export 'offer.dart';
export 'offer_card.dart';
export 'offer_category.dart';
export 'offer_frequency.dart';
export 'offer_input.dart';
export 'offer_status.dart';
export 'proof_type.dart';
export 'shop.dart';
export 'shop_input.dart';
export 'student_profile.dart';
export 'student_verification.dart';
export 'treat_exception.dart';
export 'user_role.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'claim',
      dartName: 'Claim',
      schema: 'public',
      module: 'treat',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'offerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'shopId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'studentName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'frequency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferFrequency',
        ),
        _isp.ColumnDefinition(
          name: 'code',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ClaimStatus',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'expiresAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'redeemedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'proofType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ProofType?',
        ),
        _isp.ColumnDefinition(
          name: 'proofPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'proofSubmittedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'decidedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'verdictReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'appealed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'verifyAttempts',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'strikeGiven',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'claim_fk_0',
          columns: ['offerId'],
          referenceTable: 'offer',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'claim_fk_1',
          columns: ['shopId'],
          referenceTable: 'shop',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'claim_fk_2',
          columns: ['studentId'],
          referenceTable: 'student_profile',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'claim_student_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'studentId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'claim_shop_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shopId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'claim_shop_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shopId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'claim_offer_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'offerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'offer',
      dartName: 'Offer',
      schema: 'public',
      module: 'treat',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'shopId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'seedKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferCategory',
        ),
        _isp.ColumnDefinition(
          name: 'frequency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferFrequency',
        ),
        _isp.ColumnDefinition(
          name: 'activeStartMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'activeEndMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'dailyCap',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'totalCap',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferStatus',
          columnDefault: '\'active\'',
        ),
        _isp.ColumnDefinition(
          name: 'featured',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'proofTypes',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:ProofType>',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'offer_fk_0',
          columns: ['shopId'],
          referenceTable: 'shop',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'offer_shop_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'shopId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'offer_status_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'status',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'offer_seed_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'seedKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'shop',
      dartName: 'Shop',
      schema: 'public',
      module: 'treat',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'seedKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferCategory',
        ),
        _isp.ColumnDefinition(
          name: 'district',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'bio',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'instagramHandle',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'verified',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'totalRedeems',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'approvedProofs',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'shop_fk_0',
          columns: ['ownerId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'shop_owner_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'ownerId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'shop_seed_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'seedKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'student_profile',
      dartName: 'StudentProfile',
      schema: 'public',
      module: 'treat',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'email',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'university',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'verification',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:StudentVerification',
        ),
        _isp.ColumnDefinition(
          name: 'strikes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'treats',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'categoriesTried',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<protocol:OfferCategory>',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'student_profile_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'student_profile_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'student_profile_treats_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'treats',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i14xwlyb.BadgeId) {
      return _i14xwlyb.BadgeId.fromJson(data) as T;
    }
    if (t == _iywv5oz4.Claim) {
      return _iywv5oz4.Claim.fromJson(data) as T;
    }
    if (t == _i4cqplnc.ClaimStatus) {
      return _i4cqplnc.ClaimStatus.fromJson(data) as T;
    }
    if (t == _iapxm79h.Eligibility) {
      return _iapxm79h.Eligibility.fromJson(data) as T;
    }
    if (t == _ixt5yy28.EligibilityReason) {
      return _ixt5yy28.EligibilityReason.fromJson(data) as T;
    }
    if (t == _i22ljs0z.Me) {
      return _i22ljs0z.Me.fromJson(data) as T;
    }
    if (t == _iqlmmtnc.Offer) {
      return _iqlmmtnc.Offer.fromJson(data) as T;
    }
    if (t == _irfq3mof.OfferCard) {
      return _irfq3mof.OfferCard.fromJson(data) as T;
    }
    if (t == _iqmyfspq.OfferCategory) {
      return _iqmyfspq.OfferCategory.fromJson(data) as T;
    }
    if (t == _ix7dcs2a.OfferFrequency) {
      return _ix7dcs2a.OfferFrequency.fromJson(data) as T;
    }
    if (t == _in0575rn.OfferInput) {
      return _in0575rn.OfferInput.fromJson(data) as T;
    }
    if (t == _i40dfi1m.OfferStatus) {
      return _i40dfi1m.OfferStatus.fromJson(data) as T;
    }
    if (t == _i671eu65.ProofType) {
      return _i671eu65.ProofType.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _i5vfstp6.ShopInput) {
      return _i5vfstp6.ShopInput.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _ipqqbskf.StudentVerification) {
      return _ipqqbskf.StudentVerification.fromJson(data) as T;
    }
    if (t == _iawcmjml.TreatException) {
      return _iawcmjml.TreatException.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _is.getType<_i14xwlyb.BadgeId?>()) {
      return (data != null ? _i14xwlyb.BadgeId.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iywv5oz4.Claim?>()) {
      return (data != null ? _iywv5oz4.Claim.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4cqplnc.ClaimStatus?>()) {
      return (data != null ? _i4cqplnc.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iapxm79h.Eligibility?>()) {
      return (data != null ? _iapxm79h.Eligibility.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixt5yy28.EligibilityReason?>()) {
      return (data != null ? _ixt5yy28.EligibilityReason.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i22ljs0z.Me?>()) {
      return (data != null ? _i22ljs0z.Me.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqlmmtnc.Offer?>()) {
      return (data != null ? _iqlmmtnc.Offer.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irfq3mof.OfferCard?>()) {
      return (data != null ? _irfq3mof.OfferCard.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqmyfspq.OfferCategory?>()) {
      return (data != null ? _iqmyfspq.OfferCategory.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ix7dcs2a.OfferFrequency?>()) {
      return (data != null ? _ix7dcs2a.OfferFrequency.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_in0575rn.OfferInput?>()) {
      return (data != null ? _in0575rn.OfferInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i40dfi1m.OfferStatus?>()) {
      return (data != null ? _i40dfi1m.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i671eu65.ProofType?>()) {
      return (data != null ? _i671eu65.ProofType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i5vfstp6.ShopInput?>()) {
      return (data != null ? _i5vfstp6.ShopInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iovtxv26.StudentProfile?>()) {
      return (data != null ? _iovtxv26.StudentProfile.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipqqbskf.StudentVerification?>()) {
      return (data != null
              ? _ipqqbskf.StudentVerification.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iawcmjml.TreatException?>()) {
      return (data != null ? _iawcmjml.TreatException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<_i14xwlyb.BadgeId>) {
      return (data as List)
              .map((e) => deserialize<_i14xwlyb.BadgeId>(e))
              .toList()
          as T;
    }
    if (t == List<_i671eu65.ProofType>) {
      return (data as List)
              .map((e) => deserialize<_i671eu65.ProofType>(e))
              .toList()
          as T;
    }
    if (t == List<_iqmyfspq.OfferCategory>) {
      return (data as List)
              .map((e) => deserialize<_iqmyfspq.OfferCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_ipkteuk5.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_ipkteuk5.OfferCard>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i14xwlyb.BadgeId => 'BadgeId',
      _iywv5oz4.Claim => 'Claim',
      _i4cqplnc.ClaimStatus => 'ClaimStatus',
      _iapxm79h.Eligibility => 'Eligibility',
      _ixt5yy28.EligibilityReason => 'EligibilityReason',
      _i22ljs0z.Me => 'Me',
      _iqlmmtnc.Offer => 'Offer',
      _irfq3mof.OfferCard => 'OfferCard',
      _iqmyfspq.OfferCategory => 'OfferCategory',
      _ix7dcs2a.OfferFrequency => 'OfferFrequency',
      _in0575rn.OfferInput => 'OfferInput',
      _i40dfi1m.OfferStatus => 'OfferStatus',
      _i671eu65.ProofType => 'ProofType',
      _isgf2ncs.Shop => 'Shop',
      _i5vfstp6.ShopInput => 'ShopInput',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _ipqqbskf.StudentVerification => 'StudentVerification',
      _iawcmjml.TreatException => 'TreatException',
      _ir0y0iu6.UserRole => 'UserRole',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('treat.', '');
    }

    switch (data) {
      case _i14xwlyb.BadgeId():
        return 'BadgeId';
      case _iywv5oz4.Claim():
        return 'Claim';
      case _i4cqplnc.ClaimStatus():
        return 'ClaimStatus';
      case _iapxm79h.Eligibility():
        return 'Eligibility';
      case _ixt5yy28.EligibilityReason():
        return 'EligibilityReason';
      case _i22ljs0z.Me():
        return 'Me';
      case _iqlmmtnc.Offer():
        return 'Offer';
      case _irfq3mof.OfferCard():
        return 'OfferCard';
      case _iqmyfspq.OfferCategory():
        return 'OfferCategory';
      case _ix7dcs2a.OfferFrequency():
        return 'OfferFrequency';
      case _in0575rn.OfferInput():
        return 'OfferInput';
      case _i40dfi1m.OfferStatus():
        return 'OfferStatus';
      case _i671eu65.ProofType():
        return 'ProofType';
      case _isgf2ncs.Shop():
        return 'Shop';
      case _i5vfstp6.ShopInput():
        return 'ShopInput';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _ipqqbskf.StudentVerification():
        return 'StudentVerification';
      case _iawcmjml.TreatException():
        return 'TreatException';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'BadgeId') {
      return deserialize<_i14xwlyb.BadgeId>(data['data']);
    }
    if (dataClassName == 'Claim') {
      return deserialize<_iywv5oz4.Claim>(data['data']);
    }
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_i4cqplnc.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'Eligibility') {
      return deserialize<_iapxm79h.Eligibility>(data['data']);
    }
    if (dataClassName == 'EligibilityReason') {
      return deserialize<_ixt5yy28.EligibilityReason>(data['data']);
    }
    if (dataClassName == 'Me') {
      return deserialize<_i22ljs0z.Me>(data['data']);
    }
    if (dataClassName == 'Offer') {
      return deserialize<_iqlmmtnc.Offer>(data['data']);
    }
    if (dataClassName == 'OfferCard') {
      return deserialize<_irfq3mof.OfferCard>(data['data']);
    }
    if (dataClassName == 'OfferCategory') {
      return deserialize<_iqmyfspq.OfferCategory>(data['data']);
    }
    if (dataClassName == 'OfferFrequency') {
      return deserialize<_ix7dcs2a.OfferFrequency>(data['data']);
    }
    if (dataClassName == 'OfferInput') {
      return deserialize<_in0575rn.OfferInput>(data['data']);
    }
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i40dfi1m.OfferStatus>(data['data']);
    }
    if (dataClassName == 'ProofType') {
      return deserialize<_i671eu65.ProofType>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName == 'ShopInput') {
      return deserialize<_i5vfstp6.ShopInput>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudentVerification') {
      return deserialize<_ipqqbskf.StudentVerification>(data['data']);
    }
    if (dataClassName == 'TreatException') {
      return deserialize<_iawcmjml.TreatException>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('treat', this);
    _iacs.Protocol().registerHostProtocol('treat', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iywv5oz4.Claim:
        return _iywv5oz4.Claim.t;
      case _iqlmmtnc.Offer:
        return _iqlmmtnc.Offer.t;
      case _isgf2ncs.Shop:
        return _isgf2ncs.Shop.t;
      case _iovtxv26.StudentProfile:
        return _iovtxv26.StudentProfile.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'treat';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
