import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

TreatException treatError(String code, [String? message]) =>
    TreatException(code: code, message: message ?? code);

UuidValue requireAuthUserId(Session session) {
  final id = session.authenticated?.authUserId;
  if (id == null) throw treatError('not_signed_in', 'Sign in first.');
  return id;
}

Future<StudentProfile?> findStudent(
  Session session,
  UuidValue authUserId, {
  Transaction? transaction,
}) => StudentProfile.db.findFirstRow(
  session,
  where: (t) => t.authUserId.equals(authUserId),
  transaction: transaction,
);

Future<Shop?> findShopOf(
  Session session,
  UuidValue authUserId, {
  Transaction? transaction,
}) => Shop.db.findFirstRow(
  session,
  where: (t) => t.ownerId.equals(authUserId),
  transaction: transaction,
);

Future<StudentProfile> requireStudent(
  Session session, {
  Transaction? transaction,
}) async {
  final student = await findStudent(
    session,
    requireAuthUserId(session),
    transaction: transaction,
  );
  if (student == null) {
    throw treatError('not_a_student', 'Only students can do this.');
  }
  return student;
}

Future<Shop> requireShop(Session session, {Transaction? transaction}) async {
  final shop = await findShopOf(
    session,
    requireAuthUserId(session),
    transaction: transaction,
  );
  if (shop == null) {
    throw treatError('not_a_shop', 'Only businesses can do this.');
  }
  return shop;
}

/// The login email of an auth user (lower-case), or null for non-email users.
Future<String?> emailOf(Session session, UuidValue authUserId) async {
  final account = await EmailAccount.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId),
  );
  return account?.email;
}
