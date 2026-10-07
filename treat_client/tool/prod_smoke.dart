// Smoke test of a deployed treat server through the generated client:
//   dart run tool/prod_smoke.dart https://treat-app.api.serverpod.space/
// Uses only the one-tap demo sign-ins (server must be in demo mode) and the
// real AI + iyzico sandbox. It does NOT pay: the card step is a browser flow.
import 'dart:async';

import 'package:treat_client/treat_client.dart';

class _Key implements ClientAuthKeyProvider {
  String? token;
  @override
  Future<String?> get authHeaderValue async =>
      token == null ? null : wrapAsBearerAuthHeaderValue(token!);
}

var _failures = 0;

void check(String name, bool ok, [String detail = '']) {
  if (!ok) _failures++;
  print('${ok ? 'PASS' : 'FAIL'}  $name${detail.isEmpty ? '' : '  ($detail)'}');
}

Client _client(String api, _Key key) =>
    Client(api, connectionTimeout: const Duration(seconds: 60))
      ..authKeyProvider = key;

Future<T> eventually<T>(
  Future<T> Function() read,
  bool Function(T) done, {
  int seconds = 90,
}) async {
  final end = DateTime.now().add(Duration(seconds: seconds));
  while (true) {
    final v = await read();
    if (done(v) || DateTime.now().isAfter(end)) return v;
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}

Future<void> main(List<String> args) async {
  final api = args.isEmpty ? 'https://treat-app.api.serverpod.space/' : args[0];
  final studentKey = _Key();
  final shopKey = _Key();
  final student = _client(api, studentKey);
  final shop = _client(api, shopKey);

  check('demo mode is on', await student.demo.enabled());
  final s = await student.demo.signInAsGuestStudent();
  studentKey.token = s.token;
  final meS = await student.profile.getMe();
  check(
    'guest student signs in and is verified',
    meS.role == UserRole.student &&
        meS.student!.verification == StudentVerification.verified,
  );
  final b = await shop.demo.signInAsDemoShop();
  shopKey.token = b.token;
  final meB = await shop.profile.getMe();
  check('demo business signs in', meB.role == UserRole.shop);

  // Claim the live drop, watch it live, redeem it.
  final cards = await student.offer.listActive();
  final drops = await student.offer.watchDrops().first;
  check('a live drop exists', drops.isNotEmpty, '${drops.length}');
  final drop = drops.first;
  final claimView = await student.claim.create(drop.offer.id!);
  final claim = claimView.claim;
  check('claim created with a 6-char code', claim.code.length == 6);
  final updates = <ClaimStatus>[];
  final sub = student.claim.watch(claim.id!).listen((v) {
    updates.add(v.claim.status);
  });
  await Future<void>.delayed(const Duration(seconds: 2));
  final redeemed = await shop.shop.redeem(claim.code);
  check(
    'business scans the code',
    redeemed.view?.claim.status == ClaimStatus.redeemed,
  );
  await eventually(
    () async => updates,
    (u) => u.contains(ClaimStatus.redeemed),
    seconds: 15,
  );
  check(
    'student stream pushes "redeemed" through the cloud (WebSocket)',
    updates.contains(ClaimStatus.redeemed),
    '$updates',
  );
  await sub.cancel();

  // Real AI check on the compliant sample (in-process job on Starter).
  await student.claim.submitSampleProof(claim.id!, SampleProof.tagsPlace);
  final verdict = await eventually(
    () => student.claim.get(claim.id!),
    (v) =>
        v.claim.status == ClaimStatus.approved ||
        v.claim.status == ClaimStatus.rejected,
    seconds: 120,
  );
  check(
    'Claude approves the compliant sample',
    verdict.claim.status == ClaimStatus.approved,
    '${verdict.claim.status} ${verdict.claim.verdictReason ?? ''}',
  );

  // Student card check with the sample cards.
  final unverifiedKey = _Key();
  final unverified = _client(api, unverifiedKey);
  unverifiedKey.token =
      (await unverified.demo.signInAsUnverifiedStudent()).token;
  var check1 = await unverified.verification.submitSample(
    SampleCard.someoneElse,
  );
  check1 = (await eventually(
    () async => (await unverified.verification.latest())!,
    (c) => c.status != CheckStatus.pending,
    seconds: 120,
  ));
  check(
    'Claude rejects someone else\'s card',
    check1.status == CheckStatus.rejected,
    '${check1.status} ${check1.reason ?? ''}',
  );
  await unverified.verification.submitSample(SampleCard.matching);
  final ok = await eventually(
    () async => (await unverified.verification.latest())!,
    (c) => c.status == CheckStatus.approved || c.status == CheckStatus.rejected,
    seconds: 120,
  );
  check(
    'Claude approves the matching card',
    ok.status == CheckStatus.approved,
    '${ok.status} ${ok.reason ?? ''}',
  );

  // Gifting: payments configured, places listed, a checkout can be opened.
  final mode = await student.gift.mode();
  check('payments run in iyzico sandbox mode', mode == 'sandbox', mode);
  final places = await student.gift.places();
  check('verified places can receive gifts', places.isNotEmpty);
  final pixel = places.firstWhere((p) => p.name.contains('Pixel'));
  final checkout = await student.gift.send(
    GiftInput(
      shopId: pixel.id!,
      amountTl: 20,
      recipientEmail: meS.student!.email,
    ),
  );
  check(
    'iyzico checkout page opens for a self-gift (demo)',
    checkout.paymentPageUrl.startsWith('https://sandbox-'),
    checkout.paymentPageUrl.split('?').first,
  );
  final dropped = await student.gift.cancel(checkout.gift.id!);
  check(
    'an unpaid gift can be discarded',
    dropped.gift.status == GiftStatus.paymentFailed,
  );

  // Business panel numbers load.
  final dash = await shop.shop.dashboard();
  check('business panel loads', dash.shop.id == pixel.id);

  print(
    '\n${cards.length} offers listed. ${_failures == 0 ? 'ALL PASSED' : '$_failures FAILED'}',
  );
  student.close();
  shop.close();
  unverified.close();
  if (_failures > 0) throw StateError('$_failures checks failed');
}
