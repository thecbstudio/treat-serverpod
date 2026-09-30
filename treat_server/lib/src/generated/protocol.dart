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
import 'package:treat_server/src/generated/claim_view.dart' as _iuhj4d1o;
import 'package:treat_server/src/generated/leaderboard_entry.dart' as _ikcio32l;
import 'package:treat_server/src/generated/offer_card.dart' as _ipkteuk5;
import 'package:treat_server/src/generated/wall_post.dart' as _ikxwgva9;
import 'badge_id.dart' as _i14xwlyb;
import 'claim.dart' as _iywv5oz4;
import 'claim_proof.dart' as _iiz71frh;
import 'claim_status.dart' as _i4cqplnc;
import 'claim_view.dart' as _i48lh927;
import 'drop_input.dart' as _ippz03u2;
import 'drop_signal.dart' as _i1c14r0n;
import 'eligibility.dart' as _iapxm79h;
import 'eligibility_reason.dart' as _ixt5yy28;
import 'future_calls_generated_models/expire_claim_call_expire_model.dart'
    as _iizahf83;
import 'future_calls_generated_models/verify_proof_call_verify_model.dart'
    as _idz7zgl8;
import 'leaderboard_entry.dart' as _ikawkn1p;
import 'me.dart' as _i22ljs0z;
import 'offer.dart' as _iqlmmtnc;
import 'offer_card.dart' as _irfq3mof;
import 'offer_category.dart' as _iqmyfspq;
import 'offer_frequency.dart' as _ix7dcs2a;
import 'offer_input.dart' as _in0575rn;
import 'offer_kind.dart' as _ijq1l2tf;
import 'offer_status.dart' as _i40dfi1m;
import 'proof_type.dart' as _i671eu65;
import 'proof_upload.dart' as _idi75cqx;
import 'public_student.dart' as _i377gh4k;
import 'redeem_result.dart' as _iggnnz44;
import 'report.dart' as _i2t8i3ij;
import 'report_kind.dart' as _imx1jrz0;
import 'report_reason.dart' as _ijgj7dn0;
import 'review.dart' as _itqm5y01;
import 'sample_proof.dart' as _iyeld2s2;
import 'shop.dart' as _isgf2ncs;
import 'shop_dashboard.dart' as _iqgdamt7;
import 'shop_input.dart' as _i5vfstp6;
import 'shop_page.dart' as _iv7ebkk1;
import 'shop_rating.dart' as _i7zra0pp;
import 'student_profile.dart' as _iovtxv26;
import 'student_verification.dart' as _ipqqbskf;
import 'top_student.dart' as _iub4wqas;
import 'treat_exception.dart' as _iawcmjml;
import 'user_role.dart' as _ir0y0iu6;
import 'wall_post.dart' as _i6mr85kx;
export 'badge_id.dart';
export 'claim.dart';
export 'claim_proof.dart';
export 'claim_status.dart';
export 'claim_view.dart';
export 'drop_input.dart';
export 'drop_signal.dart';
export 'eligibility.dart';
export 'eligibility_reason.dart';
export 'leaderboard_entry.dart';
export 'me.dart';
export 'offer.dart';
export 'offer_card.dart';
export 'offer_category.dart';
export 'offer_frequency.dart';
export 'offer_input.dart';
export 'offer_kind.dart';
export 'offer_status.dart';
export 'proof_type.dart';
export 'proof_upload.dart';
export 'public_student.dart';
export 'redeem_result.dart';
export 'report.dart';
export 'report_kind.dart';
export 'report_reason.dart';
export 'review.dart';
export 'sample_proof.dart';
export 'shop.dart';
export 'shop_dashboard.dart';
export 'shop_input.dart';
export 'shop_page.dart';
export 'shop_rating.dart';
export 'student_profile.dart';
export 'student_verification.dart';
export 'top_student.dart';
export 'treat_exception.dart';
export 'user_role.dart';
export 'wall_post.dart';

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
          name: 'fromDrop',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
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
        _isp.ColumnDefinition(
          name: 'shareOnWall',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'postUrl',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'stillUpCheckedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'thanksNote',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'rating',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'review',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'privateNote',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ratedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'reviewHidden',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'wallHidden',
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
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OfferKind',
          columnDefault: '\'regular\'',
        ),
        _isp.ColumnDefinition(
          name: 'endsAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
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
      name: 'report',
      dartName: 'Report',
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
          name: 'reporterId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ReportKind',
        ),
        _isp.ColumnDefinition(
          name: 'targetId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ReportReason',
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
          constraintName: 'report_fk_0',
          columns: ['reporterId'],
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
          indexName: 'report_target_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'kind',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'report_once_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'reporterId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'kind',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetId',
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
          name: 'googleReviewUrl',
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
    if (t == _iiz71frh.ProofLink) {
      return _iiz71frh.ProofLink.fromJson(data) as T;
    }
    if (t == _i4cqplnc.ClaimStatus) {
      return _i4cqplnc.ClaimStatus.fromJson(data) as T;
    }
    if (t == _i48lh927.ClaimView) {
      return _i48lh927.ClaimView.fromJson(data) as T;
    }
    if (t == _ippz03u2.DropInput) {
      return _ippz03u2.DropInput.fromJson(data) as T;
    }
    if (t == _i1c14r0n.DropSignal) {
      return _i1c14r0n.DropSignal.fromJson(data) as T;
    }
    if (t == _iapxm79h.Eligibility) {
      return _iapxm79h.Eligibility.fromJson(data) as T;
    }
    if (t == _ixt5yy28.EligibilityReason) {
      return _ixt5yy28.EligibilityReason.fromJson(data) as T;
    }
    if (t == _iizahf83.ExpireClaimCallExpireModel) {
      return _iizahf83.ExpireClaimCallExpireModel.fromJson(data) as T;
    }
    if (t == _idz7zgl8.VerifyProofCallVerifyModel) {
      return _idz7zgl8.VerifyProofCallVerifyModel.fromJson(data) as T;
    }
    if (t == _ikawkn1p.LeaderboardEntry) {
      return _ikawkn1p.LeaderboardEntry.fromJson(data) as T;
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
    if (t == _ijq1l2tf.OfferKind) {
      return _ijq1l2tf.OfferKind.fromJson(data) as T;
    }
    if (t == _i40dfi1m.OfferStatus) {
      return _i40dfi1m.OfferStatus.fromJson(data) as T;
    }
    if (t == _i671eu65.ProofType) {
      return _i671eu65.ProofType.fromJson(data) as T;
    }
    if (t == _idi75cqx.ProofUpload) {
      return _idi75cqx.ProofUpload.fromJson(data) as T;
    }
    if (t == _i377gh4k.PublicStudent) {
      return _i377gh4k.PublicStudent.fromJson(data) as T;
    }
    if (t == _iggnnz44.RedeemResult) {
      return _iggnnz44.RedeemResult.fromJson(data) as T;
    }
    if (t == _i2t8i3ij.Report) {
      return _i2t8i3ij.Report.fromJson(data) as T;
    }
    if (t == _imx1jrz0.ReportKind) {
      return _imx1jrz0.ReportKind.fromJson(data) as T;
    }
    if (t == _ijgj7dn0.ReportReason) {
      return _ijgj7dn0.ReportReason.fromJson(data) as T;
    }
    if (t == _itqm5y01.Review) {
      return _itqm5y01.Review.fromJson(data) as T;
    }
    if (t == _iyeld2s2.SampleProof) {
      return _iyeld2s2.SampleProof.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _iqgdamt7.ShopDashboard) {
      return _iqgdamt7.ShopDashboard.fromJson(data) as T;
    }
    if (t == _i5vfstp6.ShopInput) {
      return _i5vfstp6.ShopInput.fromJson(data) as T;
    }
    if (t == _iv7ebkk1.ShopPage) {
      return _iv7ebkk1.ShopPage.fromJson(data) as T;
    }
    if (t == _i7zra0pp.ShopRating) {
      return _i7zra0pp.ShopRating.fromJson(data) as T;
    }
    if (t == _iovtxv26.StudentProfile) {
      return _iovtxv26.StudentProfile.fromJson(data) as T;
    }
    if (t == _ipqqbskf.StudentVerification) {
      return _ipqqbskf.StudentVerification.fromJson(data) as T;
    }
    if (t == _iub4wqas.TopStudent) {
      return _iub4wqas.TopStudent.fromJson(data) as T;
    }
    if (t == _iawcmjml.TreatException) {
      return _iawcmjml.TreatException.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _i6mr85kx.WallPost) {
      return _i6mr85kx.WallPost.fromJson(data) as T;
    }
    if (t == _is.getType<_i14xwlyb.BadgeId?>()) {
      return (data != null ? _i14xwlyb.BadgeId.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iywv5oz4.Claim?>()) {
      return (data != null ? _iywv5oz4.Claim.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iiz71frh.ProofLink?>()) {
      return (data != null ? _iiz71frh.ProofLink.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4cqplnc.ClaimStatus?>()) {
      return (data != null ? _i4cqplnc.ClaimStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i48lh927.ClaimView?>()) {
      return (data != null ? _i48lh927.ClaimView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ippz03u2.DropInput?>()) {
      return (data != null ? _ippz03u2.DropInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1c14r0n.DropSignal?>()) {
      return (data != null ? _i1c14r0n.DropSignal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iapxm79h.Eligibility?>()) {
      return (data != null ? _iapxm79h.Eligibility.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixt5yy28.EligibilityReason?>()) {
      return (data != null ? _ixt5yy28.EligibilityReason.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iizahf83.ExpireClaimCallExpireModel?>()) {
      return (data != null
              ? _iizahf83.ExpireClaimCallExpireModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idz7zgl8.VerifyProofCallVerifyModel?>()) {
      return (data != null
              ? _idz7zgl8.VerifyProofCallVerifyModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikawkn1p.LeaderboardEntry?>()) {
      return (data != null ? _ikawkn1p.LeaderboardEntry.fromJson(data) : null)
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
    if (t == _is.getType<_ijq1l2tf.OfferKind?>()) {
      return (data != null ? _ijq1l2tf.OfferKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i40dfi1m.OfferStatus?>()) {
      return (data != null ? _i40dfi1m.OfferStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i671eu65.ProofType?>()) {
      return (data != null ? _i671eu65.ProofType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idi75cqx.ProofUpload?>()) {
      return (data != null ? _idi75cqx.ProofUpload.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i377gh4k.PublicStudent?>()) {
      return (data != null ? _i377gh4k.PublicStudent.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iggnnz44.RedeemResult?>()) {
      return (data != null ? _iggnnz44.RedeemResult.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2t8i3ij.Report?>()) {
      return (data != null ? _i2t8i3ij.Report.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imx1jrz0.ReportKind?>()) {
      return (data != null ? _imx1jrz0.ReportKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijgj7dn0.ReportReason?>()) {
      return (data != null ? _ijgj7dn0.ReportReason.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itqm5y01.Review?>()) {
      return (data != null ? _itqm5y01.Review.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iyeld2s2.SampleProof?>()) {
      return (data != null ? _iyeld2s2.SampleProof.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqgdamt7.ShopDashboard?>()) {
      return (data != null ? _iqgdamt7.ShopDashboard.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5vfstp6.ShopInput?>()) {
      return (data != null ? _i5vfstp6.ShopInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv7ebkk1.ShopPage?>()) {
      return (data != null ? _iv7ebkk1.ShopPage.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7zra0pp.ShopRating?>()) {
      return (data != null ? _i7zra0pp.ShopRating.fromJson(data) : null) as T;
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
    if (t == _is.getType<_iub4wqas.TopStudent?>()) {
      return (data != null ? _iub4wqas.TopStudent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iawcmjml.TreatException?>()) {
      return (data != null ? _iawcmjml.TreatException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6mr85kx.WallPost?>()) {
      return (data != null ? _i6mr85kx.WallPost.fromJson(data) : null) as T;
    }
    if (t == List<_i671eu65.ProofType>) {
      return (data as List)
              .map((e) => deserialize<_i671eu65.ProofType>(e))
              .toList()
          as T;
    }
    if (t == List<_i14xwlyb.BadgeId>) {
      return (data as List)
              .map((e) => deserialize<_i14xwlyb.BadgeId>(e))
              .toList()
          as T;
    }
    if (t == List<_i6mr85kx.WallPost>) {
      return (data as List)
              .map((e) => deserialize<_i6mr85kx.WallPost>(e))
              .toList()
          as T;
    }
    if (t == List<_i48lh927.ClaimView>) {
      return (data as List)
              .map((e) => deserialize<_i48lh927.ClaimView>(e))
              .toList()
          as T;
    }
    if (t == List<_iub4wqas.TopStudent>) {
      return (data as List)
              .map((e) => deserialize<_iub4wqas.TopStudent>(e))
              .toList()
          as T;
    }
    if (t == List<_itqm5y01.Review>) {
      return (data as List)
              .map((e) => deserialize<_itqm5y01.Review>(e))
              .toList()
          as T;
    }
    if (t == List<_irfq3mof.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_irfq3mof.OfferCard>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_iqmyfspq.OfferCategory>) {
      return (data as List)
              .map((e) => deserialize<_iqmyfspq.OfferCategory>(e))
              .toList()
          as T;
    }
    if (t == List<_iuhj4d1o.ClaimView>) {
      return (data as List)
              .map((e) => deserialize<_iuhj4d1o.ClaimView>(e))
              .toList()
          as T;
    }
    if (t == List<_ikcio32l.LeaderboardEntry>) {
      return (data as List)
              .map((e) => deserialize<_ikcio32l.LeaderboardEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_ipkteuk5.OfferCard>) {
      return (data as List)
              .map((e) => deserialize<_ipkteuk5.OfferCard>(e))
              .toList()
          as T;
    }
    if (t == List<_ikxwgva9.WallPost>) {
      return (data as List)
              .map((e) => deserialize<_ikxwgva9.WallPost>(e))
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
      _iiz71frh.ProofLink => 'ProofLink',
      _i4cqplnc.ClaimStatus => 'ClaimStatus',
      _i48lh927.ClaimView => 'ClaimView',
      _ippz03u2.DropInput => 'DropInput',
      _i1c14r0n.DropSignal => 'DropSignal',
      _iapxm79h.Eligibility => 'Eligibility',
      _ixt5yy28.EligibilityReason => 'EligibilityReason',
      _iizahf83.ExpireClaimCallExpireModel => 'ExpireClaimCallExpireModel',
      _idz7zgl8.VerifyProofCallVerifyModel => 'VerifyProofCallVerifyModel',
      _ikawkn1p.LeaderboardEntry => 'LeaderboardEntry',
      _i22ljs0z.Me => 'Me',
      _iqlmmtnc.Offer => 'Offer',
      _irfq3mof.OfferCard => 'OfferCard',
      _iqmyfspq.OfferCategory => 'OfferCategory',
      _ix7dcs2a.OfferFrequency => 'OfferFrequency',
      _in0575rn.OfferInput => 'OfferInput',
      _ijq1l2tf.OfferKind => 'OfferKind',
      _i40dfi1m.OfferStatus => 'OfferStatus',
      _i671eu65.ProofType => 'ProofType',
      _idi75cqx.ProofUpload => 'ProofUpload',
      _i377gh4k.PublicStudent => 'PublicStudent',
      _iggnnz44.RedeemResult => 'RedeemResult',
      _i2t8i3ij.Report => 'Report',
      _imx1jrz0.ReportKind => 'ReportKind',
      _ijgj7dn0.ReportReason => 'ReportReason',
      _itqm5y01.Review => 'Review',
      _iyeld2s2.SampleProof => 'SampleProof',
      _isgf2ncs.Shop => 'Shop',
      _iqgdamt7.ShopDashboard => 'ShopDashboard',
      _i5vfstp6.ShopInput => 'ShopInput',
      _iv7ebkk1.ShopPage => 'ShopPage',
      _i7zra0pp.ShopRating => 'ShopRating',
      _iovtxv26.StudentProfile => 'StudentProfile',
      _ipqqbskf.StudentVerification => 'StudentVerification',
      _iub4wqas.TopStudent => 'TopStudent',
      _iawcmjml.TreatException => 'TreatException',
      _ir0y0iu6.UserRole => 'UserRole',
      _i6mr85kx.WallPost => 'WallPost',
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
      case _iiz71frh.ProofLink():
        return 'ProofLink';
      case _i4cqplnc.ClaimStatus():
        return 'ClaimStatus';
      case _i48lh927.ClaimView():
        return 'ClaimView';
      case _ippz03u2.DropInput():
        return 'DropInput';
      case _i1c14r0n.DropSignal():
        return 'DropSignal';
      case _iapxm79h.Eligibility():
        return 'Eligibility';
      case _ixt5yy28.EligibilityReason():
        return 'EligibilityReason';
      case _iizahf83.ExpireClaimCallExpireModel():
        return 'ExpireClaimCallExpireModel';
      case _idz7zgl8.VerifyProofCallVerifyModel():
        return 'VerifyProofCallVerifyModel';
      case _ikawkn1p.LeaderboardEntry():
        return 'LeaderboardEntry';
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
      case _ijq1l2tf.OfferKind():
        return 'OfferKind';
      case _i40dfi1m.OfferStatus():
        return 'OfferStatus';
      case _i671eu65.ProofType():
        return 'ProofType';
      case _idi75cqx.ProofUpload():
        return 'ProofUpload';
      case _i377gh4k.PublicStudent():
        return 'PublicStudent';
      case _iggnnz44.RedeemResult():
        return 'RedeemResult';
      case _i2t8i3ij.Report():
        return 'Report';
      case _imx1jrz0.ReportKind():
        return 'ReportKind';
      case _ijgj7dn0.ReportReason():
        return 'ReportReason';
      case _itqm5y01.Review():
        return 'Review';
      case _iyeld2s2.SampleProof():
        return 'SampleProof';
      case _isgf2ncs.Shop():
        return 'Shop';
      case _iqgdamt7.ShopDashboard():
        return 'ShopDashboard';
      case _i5vfstp6.ShopInput():
        return 'ShopInput';
      case _iv7ebkk1.ShopPage():
        return 'ShopPage';
      case _i7zra0pp.ShopRating():
        return 'ShopRating';
      case _iovtxv26.StudentProfile():
        return 'StudentProfile';
      case _ipqqbskf.StudentVerification():
        return 'StudentVerification';
      case _iub4wqas.TopStudent():
        return 'TopStudent';
      case _iawcmjml.TreatException():
        return 'TreatException';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
      case _i6mr85kx.WallPost():
        return 'WallPost';
    }
    if (data is List<_ipkteuk5.OfferCard>) {
      return 'List<OfferCard>';
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
    if (dataClassName == 'ProofLink') {
      return deserialize<_iiz71frh.ProofLink>(data['data']);
    }
    if (dataClassName == 'ClaimStatus') {
      return deserialize<_i4cqplnc.ClaimStatus>(data['data']);
    }
    if (dataClassName == 'ClaimView') {
      return deserialize<_i48lh927.ClaimView>(data['data']);
    }
    if (dataClassName == 'DropInput') {
      return deserialize<_ippz03u2.DropInput>(data['data']);
    }
    if (dataClassName == 'DropSignal') {
      return deserialize<_i1c14r0n.DropSignal>(data['data']);
    }
    if (dataClassName == 'Eligibility') {
      return deserialize<_iapxm79h.Eligibility>(data['data']);
    }
    if (dataClassName == 'EligibilityReason') {
      return deserialize<_ixt5yy28.EligibilityReason>(data['data']);
    }
    if (dataClassName == 'ExpireClaimCallExpireModel') {
      return deserialize<_iizahf83.ExpireClaimCallExpireModel>(data['data']);
    }
    if (dataClassName == 'VerifyProofCallVerifyModel') {
      return deserialize<_idz7zgl8.VerifyProofCallVerifyModel>(data['data']);
    }
    if (dataClassName == 'LeaderboardEntry') {
      return deserialize<_ikawkn1p.LeaderboardEntry>(data['data']);
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
    if (dataClassName == 'OfferKind') {
      return deserialize<_ijq1l2tf.OfferKind>(data['data']);
    }
    if (dataClassName == 'OfferStatus') {
      return deserialize<_i40dfi1m.OfferStatus>(data['data']);
    }
    if (dataClassName == 'ProofType') {
      return deserialize<_i671eu65.ProofType>(data['data']);
    }
    if (dataClassName == 'ProofUpload') {
      return deserialize<_idi75cqx.ProofUpload>(data['data']);
    }
    if (dataClassName == 'PublicStudent') {
      return deserialize<_i377gh4k.PublicStudent>(data['data']);
    }
    if (dataClassName == 'RedeemResult') {
      return deserialize<_iggnnz44.RedeemResult>(data['data']);
    }
    if (dataClassName == 'Report') {
      return deserialize<_i2t8i3ij.Report>(data['data']);
    }
    if (dataClassName == 'ReportKind') {
      return deserialize<_imx1jrz0.ReportKind>(data['data']);
    }
    if (dataClassName == 'ReportReason') {
      return deserialize<_ijgj7dn0.ReportReason>(data['data']);
    }
    if (dataClassName == 'Review') {
      return deserialize<_itqm5y01.Review>(data['data']);
    }
    if (dataClassName == 'SampleProof') {
      return deserialize<_iyeld2s2.SampleProof>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName == 'ShopDashboard') {
      return deserialize<_iqgdamt7.ShopDashboard>(data['data']);
    }
    if (dataClassName == 'ShopInput') {
      return deserialize<_i5vfstp6.ShopInput>(data['data']);
    }
    if (dataClassName == 'ShopPage') {
      return deserialize<_iv7ebkk1.ShopPage>(data['data']);
    }
    if (dataClassName == 'ShopRating') {
      return deserialize<_i7zra0pp.ShopRating>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_iovtxv26.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudentVerification') {
      return deserialize<_ipqqbskf.StudentVerification>(data['data']);
    }
    if (dataClassName == 'TopStudent') {
      return deserialize<_iub4wqas.TopStudent>(data['data']);
    }
    if (dataClassName == 'TreatException') {
      return deserialize<_iawcmjml.TreatException>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName == 'WallPost') {
      return deserialize<_i6mr85kx.WallPost>(data['data']);
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
    if (dataClassName == 'List<OfferCard>') {
      return deserialize<List<_ipkteuk5.OfferCard>>(data['data']);
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
      case _i2t8i3ij.Report:
        return _i2t8i3ij.Report.t;
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
