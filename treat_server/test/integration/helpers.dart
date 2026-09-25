import 'package:test/test.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:treat_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Creates an auth user with an email login and returns a session builder
/// authenticated as that user.
Future<TestSessionBuilder> signedInAs(
  TestSessionBuilder sessionBuilder,
  String email,
) async {
  final session = sessionBuilder.build();
  final authUser = await AuthUser.db.insertRow(
    session,
    AuthUser(scopeNames: {}),
  );
  await EmailAccount.db.insertRow(
    session,
    EmailAccount(authUserId: authUser.id!, email: email, passwordHash: 'x'),
  );
  return sessionBuilder.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(
      authUser.id!.uuid,
      {},
    ),
  );
}

ShopInput shopInput({String name = 'Test Café'}) => ShopInput(
  name: name,
  category: OfferCategory.coffee,
  district: 'Odunpazarı',
  address: 'Street 1',
  bio: 'Nice coffee',
  instagramHandle: '@testcafe',
);

OfferInput offerInput({
  int startMin = 0,
  int endMin = 24 * 60,
  int? dailyCap,
  int? totalCap,
}) => OfferInput(
  title: 'Filter coffee',
  description: 'One cup',
  frequency: OfferFrequency.weekly,
  activeStartMin: startMin,
  activeEndMin: endMin,
  dailyCap: dailyCap,
  totalCap: totalCap,
  proofTypes: [ProofType.igStory, ProofType.igStory, ProofType.googleReview],
);

Matcher throwsTreat(String code) =>
    throwsA(isA<TreatException>().having((e) => e.code, 'code', code));
