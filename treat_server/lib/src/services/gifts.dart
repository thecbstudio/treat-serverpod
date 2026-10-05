import 'dart:async';
import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../domain/clock.dart';
import '../domain/gift_rules.dart';
import '../domain/rules.dart';
import '../generated/protocol.dart';
import '../payments/iyzico.dart';
import 'accounts.dart';
import 'demo.dart';

/// Swappable for tests. Built from `iyzicoApiKey` / `iyzicoSecretKey` (and
/// optionally `iyzicoBaseUrl`, default the iyzico sandbox) in passwords.yaml.
PaymentGateway? paymentGatewayOverride;

bool paymentsConfigured(Session session) =>
    paymentGatewayOverride != null ||
    ((session.passwords['iyzicoApiKey'] ?? '').isNotEmpty &&
        (session.passwords['iyzicoSecretKey'] ?? '').isNotEmpty);

/// 'off' (no keys), 'sandbox' (iyzico's test environment, play-money cards)
/// or 'live'. The app shows test-card hints only in sandbox.
String paymentMode(Session session) {
  if (paymentGatewayOverride != null) return 'sandbox';
  if (!paymentsConfigured(session)) return 'off';
  final base = session.passwords['iyzicoBaseUrl'] ?? IyzicoGateway.sandboxUrl;
  return base.contains('sandbox') ? 'sandbox' : 'live';
}

PaymentGateway _gateway(Session session) {
  final override = paymentGatewayOverride;
  if (override != null) return override;
  if (!paymentsConfigured(session)) {
    throw treatError(
      'payments_unavailable',
      'Payments are not set up on this server.',
    );
  }
  return IyzicoGateway(
    apiKey: session.passwords['iyzicoApiKey']!,
    secretKey: session.passwords['iyzicoSecretKey']!,
    baseUrl: session.passwords['iyzicoBaseUrl'] ?? IyzicoGateway.sandboxUrl,
  );
}

/// Where iyzico sends the browser back after the payment page.
String publicBaseUrl(Session session) {
  final web = session.serverpod.config.webServer;
  if (web == null) return 'http://localhost:8082';
  final port = web.publicPort;
  final standard =
      (web.publicScheme == 'https' && port == 443) ||
      (web.publicScheme == 'http' && port == 80);
  return '${web.publicScheme}://${web.publicHost}${standard ? '' : ':$port'}';
}

const fallbackIp = '85.34.78.112';

/// iyzico wants an IPv4 address of the payer.
String clientIp(Session session) {
  if (session is MethodCallSession) {
    final forwarded = session.request.headers['x-forwarded-for']?.firstOrNull;
    final first = forwarded?.split(',').first.trim();
    if (first != null && RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(first)) {
      return first;
    }
  }
  return fallbackIp;
}

String _randomId() {
  final r = Random.secure();
  return List.generate(16, (_) => r.nextInt(16).toRadixString(16)).join();
}

String? _cleanMessage(String? m) {
  final t = m?.trim();
  if (t == null || t.isEmpty) return null;
  if (t.length > giftMessageMax) throw treatError('note_too_long');
  return t;
}

/// What a viewer may see: the code only to the recipient (also when they
/// gifted themselves, in demo mode), never iyzico ids.
GiftView presentGift(
  Gift g, {
  required bool viewerIsSender,
  bool viewerIsRecipient = false,
}) => GiftView(
  gift: g.copyWith(
    code: viewerIsRecipient && g.status == GiftStatus.pending ? g.code : null,
  ),
  viewerIsSender: viewerIsSender,
  refundPending:
      (g.status == GiftStatus.cancelled || g.status == GiftStatus.expired) &&
      g.paymentId != null &&
      g.refundedAt == null,
);

/// Places a gift can be sent to: only places with the verified badge (a
/// document check passed), because the money goes to them.
Future<List<Shop>> giftableShops(Session session) => Shop.db.find(
  session,
  where: (t) => t.verified.equals(true),
  orderBy: (t) => t.name,
);

/// Looking friends up by e-mail tells whether an address belongs to a
/// student, so it is rate-limited per sender (per server instance).
const _maxLookupsPerHour = 20;
final _lookups = <int, List<DateTime>>{};

void _throttleLookups(int studentId) {
  final now = clock();
  final recent = _lookups[studentId] ??= [];
  recent.removeWhere((t) => now.difference(t) > const Duration(hours: 1));
  if (recent.length >= _maxLookupsPerHour) {
    throw treatError(
      'too_many_lookups',
      'Too many e-mail lookups. Try again later.',
    );
  }
  recent.add(now);
}

Future<StudentProfile> _recipientOf(
  Session session,
  GiftInput input,
  StudentProfile sender,
) async {
  final email = input.recipientEmail?.trim().toLowerCase();
  final byEmail = email != null && email.isNotEmpty;
  if (byEmail == (input.recipientStudentId != null)) {
    throw treatError('invalid_recipient');
  }
  if (byEmail) _throttleLookups(sender.id!);
  final recipient = byEmail
      ? await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.email.equals(email),
        )
      : await StudentProfile.db.findById(session, input.recipientStudentId!);
  // One answer for "unknown" and "not verified": no hint which e-mails exist.
  if (recipient == null ||
      recipient.verification != StudentVerification.verified) {
    throw treatError(
      'recipient_not_found',
      'No verified student with that e-mail on treat.',
    );
  }
  // Demo guests may gift themselves, so a judge can try pay → QR → scan alone.
  final demoSelf = demoModeOn(session) && isGuest(sender);
  if (recipient.id == sender.id && !demoSelf) {
    throw treatError('gift_to_self');
  }
  return recipient;
}

/// Creates the gift and opens iyzico's hosted payment page for it.
Future<GiftCheckout> startGift(Session session, GiftInput input) async {
  final sender = await requireStudent(session);
  if (sender.verification != StudentVerification.verified) {
    throw treatError('not_verified', 'Verify your student status first.');
  }
  if (input.amountTl < giftMinTl || input.amountTl > giftMaxTl) {
    throw treatError('invalid_amount', 'Gifts are $giftMinTl–$giftMaxTl TL.');
  }
  final message = _cleanMessage(input.message);
  final gateway = _gateway(session);
  final recipient = await _recipientOf(session, input, sender);
  final shop = await Shop.db.findById(session, input.shopId);
  if (shop == null || !shop.verified) {
    throw treatError('shop_not_giftable', 'Gifts go to verified places only.');
  }
  final split = giftSplit(input.amountTl);

  final gift = await session.db.transaction((tx) async {
    // Lock the sender so two taps can't both pass the daily cap.
    await StudentProfile.db.findById(
      session,
      sender.id!,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    final today = await Gift.db.count(
      session,
      where: (t) =>
          t.senderId.equals(sender.id!) &
          (t.createdAt >= istanbulDayStart(clock())),
      transaction: tx,
    );
    if (today >= giftDailySendCap) {
      throw treatError(
        'daily_gift_cap',
        'You can send $giftDailySendCap gifts a day.',
      );
    }
    return Gift.db.insertRow(
      session,
      Gift(
        senderId: sender.id,
        recipientId: recipient.id,
        shopId: shop.id,
        senderName: sender.name,
        recipientName: recipient.name,
        shopName: shop.name,
        amountTl: input.amountTl,
        commissionKurus: split.commissionKurus,
        netKurus: split.netKurus,
        message: message,
        status: GiftStatus.awaitingPayment,
        createdAt: clock(),
        conversationId: 'gift-${_randomId()}',
      ),
      transaction: tx,
    );
  });

  try {
    final start = await gateway.startCheckout(
      CheckoutRequest(
        conversationId: gift.conversationId!,
        basketId: 'gift-${gift.id}',
        amountTl: gift.amountTl,
        itemName: 'Treat gift at ${shop.name}',
        buyerId: 'student-${sender.id}',
        buyerName: sender.name,
        // iyzico validates e-mail domains: demo guests (@demo.treat) have none.
        buyerEmail: isDemoStudent(sender)
            ? 'demo-student@example.com'
            : sender.email,
        buyerIp: clientIp(session),
        callbackUrl: '${publicBaseUrl(session)}/pay/iyzico/${gift.id}',
      ),
    );
    final saved = await Gift.db.updateRow(
      session,
      gift.copyWith(paymentToken: start.token),
      columns: (t) => [t.paymentToken],
    );
    return GiftCheckout(
      gift: presentGift(saved, viewerIsSender: true).gift,
      paymentPageUrl: start.paymentPageUrl,
    );
  } catch (e, st) {
    session.log(
      'Could not open the payment page for gift ${gift.id}',
      level: LogLevel.warning,
      exception: e,
      stackTrace: st,
    );
    await Gift.db.updateRow(
      session,
      gift.copyWith(status: GiftStatus.paymentFailed, closedAt: clock()),
      columns: (t) => [t.status, t.closedAt],
    );
    throw treatError(
      'payment_unavailable',
      'The payment page is not available right now. Try again in a moment.',
    );
  }
}

/// Asks iyzico what happened to an `awaitingPayment` gift and applies it.
/// Idempotent: safe from the browser callback, the sender's own app and the
/// sweep. With [definitive], "not paid" closes the gift instead of waiting.
Future<Gift> settleGift(
  Session session,
  int giftId, {
  bool definitive = false,
}) async {
  final gift = await Gift.db.findById(session, giftId);
  if (gift == null) throw treatError('not_found', 'Gift not found.');
  final token = gift.paymentToken;
  if (gift.status != GiftStatus.awaitingPayment || token == null) return gift;

  CheckoutResult result;
  try {
    result = await _gateway(session).fetchResult(token, gift.conversationId!);
  } on PaymentException catch (e) {
    session.log(
      'Gift $giftId: no payment result yet: $e',
      level: e.code == 'signature' ? LogLevel.error : LogLevel.debug,
    );
    // An error is not "unpaid": the money may have moved. Only give up on
    // gifts that never got an answer for days.
    final stale = clock().difference(gift.createdAt) > const Duration(days: 3);
    return definitive && stale ? _closeUnpaid(session, gift) : gift;
  }
  if (!result.paid) {
    return definitive ? _closeUnpaid(session, gift) : gift;
  }

  // Paid. Make sure it is this gift and this much money.
  final matches =
      result.conversationId == gift.conversationId &&
      result.paidKurus == gift.amountTl * 100 &&
      result.paymentId != null;
  final now = clock();
  final updated = await session.db.transaction((tx) async {
    final g = await Gift.db.findById(
      session,
      giftId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (g == null || g.status != GiftStatus.awaitingPayment) return g;
    if (!matches) {
      // Money arrived but not what we asked for: close it, give it back.
      return Gift.db.updateRow(
        session,
        g.copyWith(
          status: GiftStatus.cancelled,
          closedAt: now,
          paidAt: now,
          paymentId: result.paymentId,
          paymentTransactionId: result.paymentTransactionId,
        ),
        transaction: tx,
      );
    }
    return Gift.db.updateRow(
      session,
      g.copyWith(
        status: GiftStatus.pending,
        paidAt: now,
        expiresAt: now.add(giftTtl),
        code: await _newGiftCode(session, g.shopId!, tx),
        paymentId: result.paymentId,
        paymentTransactionId: result.paymentTransactionId,
      ),
      transaction: tx,
    );
  });
  if (updated != null && updated.status == GiftStatus.cancelled) {
    await refundGift(session, updated.id!);
  }
  return updated ?? gift;
}

Future<Gift> _closeUnpaid(Session session, Gift gift) => Gift.db.updateRow(
  session,
  gift.copyWith(status: GiftStatus.paymentFailed, closedAt: clock()),
  columns: (t) => [t.status, t.closedAt],
);

Future<String> _newGiftCode(Session session, int shopId, Transaction tx) async {
  for (var i = 0; i < 20; i++) {
    final code = newClaimCode();
    final clash = await Gift.db.findFirstRow(
      session,
      where: (t) =>
          t.shopId.equals(shopId) &
          t.code.equals(code) &
          t.status.equals(GiftStatus.pending),
      transaction: tx,
    );
    if (clash == null) return code;
  }
  throw treatError('code_generation_failed');
}

/// One of the signed-in student's gifts (sent or received).
Future<GiftView> giftFor(Session session, int giftId) async {
  final student = await requireStudent(session);
  final gift = await Gift.db.findById(session, giftId);
  if (gift == null ||
      (gift.senderId != student.id && gift.recipientId != student.id)) {
    throw treatError('not_found', 'Gift not found.');
  }
  return presentGift(
    gift,
    viewerIsSender: gift.senderId == student.id,
    viewerIsRecipient: gift.recipientId == student.id,
  );
}

/// The sender asks for the payment state of their gift (the browser may not
/// have come back from the payment page).
Future<GiftView> confirmGift(Session session, int giftId) async {
  final view = await giftFor(session, giftId);
  if (!view.viewerIsSender) throw treatError('not_found', 'Gift not found.');
  final settled = await settleGift(session, giftId);
  final student = await requireStudent(session);
  return presentGift(
    settled,
    viewerIsSender: true,
    viewerIsRecipient: settled.recipientId == student.id,
  );
}

Future<List<GiftView>> sentGifts(Session session) async {
  final student = await requireStudent(session);
  final gifts = await Gift.db.find(
    session,
    where: (t) =>
        t.senderId.equals(student.id!) &
        t.status.notEquals(GiftStatus.paymentFailed),
    orderBy: (t) => t.createdAt.desc(),
    limit: 50,
  );
  return [
    for (final g in gifts)
      presentGift(
        g,
        viewerIsSender: true,
        viewerIsRecipient: g.recipientId == student.id,
      ),
  ];
}

Future<List<GiftView>> receivedGifts(Session session) async {
  final student = await requireStudent(session);
  final gifts = await Gift.db.find(
    session,
    where: (t) =>
        t.recipientId.equals(student.id!) &
        t.status.inSet({GiftStatus.pending, GiftStatus.redeemed}),
    orderBy: (t) => t.createdAt.desc(),
    limit: 50,
  );
  return [
    for (final g in gifts)
      presentGift(
        g,
        viewerIsSender: g.senderId == student.id,
        viewerIsRecipient: true,
      ),
  ];
}

/// The sender takes a gift back while the place hasn't handed it over. The
/// gift closes at once (so it can't be redeemed any more); the refund
/// follows and is retried until it goes through.
Future<GiftView> cancelGift(Session session, int giftId) async {
  final student = await requireStudent(session);
  final cancelled = await session.db.transaction((tx) async {
    final g = await Gift.db.findById(
      session,
      giftId,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    if (g == null || g.senderId != student.id) {
      throw treatError('not_found', 'Gift not found.');
    }
    switch (g.status) {
      case GiftStatus.awaitingPayment:
        return Gift.db.updateRow(
          session,
          g.copyWith(status: GiftStatus.paymentFailed, closedAt: clock()),
          transaction: tx,
        );
      case GiftStatus.pending:
        return Gift.db.updateRow(
          session,
          g.copyWith(status: GiftStatus.cancelled, closedAt: clock()),
          transaction: tx,
        );
      case GiftStatus.redeemed:
        throw treatError('gift_redeemed', 'The place already handed it over.');
      case GiftStatus.cancelled:
      case GiftStatus.expired:
      case GiftStatus.paymentFailed:
        throw treatError('gift_closed', 'This gift is already closed.');
    }
  });
  if (cancelled.status == GiftStatus.cancelled) {
    await refundGift(session, giftId, ip: clientIp(session));
  }
  return presentGift(
    await Gift.db.findById(session, giftId) ?? cancelled,
    viewerIsSender: true,
  );
}

/// Gives the money of a closed gift back to the sender. Same-day payments
/// are cancelled, older ones refunded; if one way fails the other is tried.
/// A failure only logs and counts: the sweep retries.
Future<void> refundGift(
  Session session,
  int giftId, {
  String ip = fallbackIp,
}) async {
  // Cancel button and sweep must not both call iyzico for the same gift.
  if (!_refunding.add(giftId)) return;
  try {
    await _refundGift(session, giftId, ip);
  } finally {
    _refunding.remove(giftId);
  }
}

final _refunding = <int>{};

Future<void> _refundGift(Session session, int giftId, String ip) async {
  final gift = await Gift.db.findById(session, giftId);
  if (gift == null ||
      gift.refundedAt != null ||
      gift.paymentId == null ||
      (gift.status != GiftStatus.cancelled &&
          gift.status != GiftStatus.expired)) {
    return;
  }
  final gateway = _gateway(session);
  final sameDay =
      gift.paidAt != null &&
      istanbulDayStart(gift.paidAt!) == istanbulDayStart(clock());
  Future<void> cancel() => gateway.cancelPayment(gift.paymentId!, ip: ip);
  Future<void> refund() => gift.paymentTransactionId == null
      ? Future.error(PaymentException('no payment transaction to refund'))
      : gateway.refundTransaction(
          gift.paymentTransactionId!,
          kurus: gift.amountTl * 100,
          ip: ip,
        );
  try {
    try {
      await (sameDay ? cancel() : refund());
    } on PaymentException {
      await (sameDay ? refund() : cancel());
    }
    await Gift.db.updateRow(
      session,
      gift.copyWith(
        refundedAt: clock(),
        refundAttempts: gift.refundAttempts + 1,
      ),
      columns: (t) => [t.refundedAt, t.refundAttempts],
    );
  } catch (e, st) {
    session.log(
      'Refund of gift $giftId failed (attempt ${gift.refundAttempts + 1})',
      level: LogLevel.warning,
      exception: e,
      stackTrace: st,
    );
    await Gift.db.updateRow(
      session,
      gift.copyWith(refundAttempts: gift.refundAttempts + 1),
      columns: (t) => [t.refundAttempts],
    );
  }
}

/// Scanned at the counter: the place hands the treat over and the recipient
/// gets +1 treat (a gift counts like any treat). Idempotent per gift.
Future<RedeemResult> redeemGift(Session session, String input) async {
  final raw = input.trim().toUpperCase();
  final qr = RegExp(r'^GIFT:(\d+):([A-Z0-9]{6})$').firstMatch(raw);
  final typed = raw.replaceAll(RegExp(r'[\s-]'), '');
  if (qr == null && !RegExp(r'^[A-Z0-9]{6}$').hasMatch(typed)) {
    throw treatError('not_found', 'No such code.');
  }
  final code = qr?.group(2) ?? typed;
  final now = clock();

  final result = await session.db.transaction((tx) async {
    final shop = await requireShop(session, transaction: tx);
    Gift? gift;
    if (qr != null) {
      gift = await Gift.db.findById(
        session,
        int.parse(qr.group(1)!),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (gift != null && gift.code != code) gift = null;
    } else {
      gift = await Gift.db.findFirstRow(
        session,
        where: (t) =>
            t.shopId.equals(shop.id!) &
            t.code.equals(code) &
            // Redeemed too, so a second scan of a typed code is a no-op.
            t.status.inSet({GiftStatus.pending, GiftStatus.redeemed}),
        orderBy: (t) => t.createdAt.desc(),
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
    }
    if (gift == null) throw treatError('not_found', 'No such code.');
    if (gift.shopId != shop.id) {
      throw treatError(
        'wrong_shop',
        "This code belongs to another business's gift.",
      );
    }
    switch (gift.status) {
      case GiftStatus.redeemed:
        return (gift: gift, already: true);
      case GiftStatus.pending:
        break;
      default:
        throw treatError('gift_closed', 'This gift is no longer valid.');
    }
    if (!now.isBefore(gift.expiresAt!)) {
      throw treatError('expired', 'This gift has expired.');
    }

    final recipient = await StudentProfile.db.findById(
      session,
      gift.recipientId!,
      lockMode: LockMode.forUpdate,
      transaction: tx,
    );
    await StudentProfile.db.updateRow(
      session,
      recipient!.copyWith(
        treats: recipient.treats + 1,
        categoriesTried: {...recipient.categoriesTried, shop.category}.toList(),
      ),
      columns: (t) => [t.treats, t.categoriesTried],
      transaction: tx,
    );
    final redeemed = await Gift.db.updateRow(
      session,
      gift.copyWith(
        status: GiftStatus.redeemed,
        redeemedAt: now,
        closedAt: now,
      ),
      transaction: tx,
    );
    return (gift: redeemed, already: false);
  });
  return RedeemResult(
    gift: result.gift.copyWith(code: null),
    alreadyRedeemed: result.already,
  );
}

Future<GiftShopStats> giftStatsFor(Session session, int shopId) async {
  final gifts = await Gift.db.find(
    session,
    where: (t) =>
        t.shopId.equals(shopId) &
        t.status.inSet({GiftStatus.pending, GiftStatus.redeemed}),
  );
  int kurus(Iterable<Gift> g) => g.fold(0, (a, b) => a + b.netKurus);
  final redeemed = gifts.where((g) => g.status == GiftStatus.redeemed);
  final waiting = gifts.where((g) => g.status == GiftStatus.pending);
  return GiftShopStats(
    redeemed: redeemed.length,
    netRedeemedTl: kurus(redeemed) / 100,
    waiting: waiting.length,
    waitingNetTl: kurus(waiting) / 100,
  );
}

/// Closes the gifts of a person or place that is leaving: pending ones are
/// cancelled for refund, names are blanked (the rows stay for accounting).
/// Returns the ids to refund once the deletion has been committed.
Future<List<int>> closeGiftsOf(
  Session session, {
  StudentProfile? student,
  Shop? shop,
  required Transaction tx,
}) async {
  final gifts = [
    if (student != null)
      ...await Gift.db.find(
        session,
        where: (t) =>
            t.senderId.equals(student.id!) | t.recipientId.equals(student.id!),
        transaction: tx,
        lockMode: LockMode.forUpdate,
      ),
    if (shop != null)
      ...await Gift.db.find(
        session,
        where: (t) => t.shopId.equals(shop.id!),
        transaction: tx,
        lockMode: LockMode.forUpdate,
      ),
  ];
  final toRefund = <int>[];
  for (final g in gifts) {
    var next = g;
    if (g.status == GiftStatus.pending) {
      next = next.copyWith(status: GiftStatus.cancelled, closedAt: clock());
      toRefund.add(g.id!);
    } else if (g.status == GiftStatus.awaitingPayment) {
      next = next.copyWith(status: GiftStatus.paymentFailed, closedAt: clock());
    } else if ((g.status == GiftStatus.cancelled ||
            g.status == GiftStatus.expired) &&
        g.refundedAt == null &&
        g.paymentId != null) {
      toRefund.add(g.id!);
    }
    if (student != null) {
      next = next.copyWith(
        senderName: g.senderId == student.id ? '' : next.senderName,
        recipientName: g.recipientId == student.id ? '' : next.recipientName,
      );
    }
    if (shop != null) next = next.copyWith(shopName: '');
    await Gift.db.updateRow(
      session,
      next.copyWith(message: null),
      transaction: tx,
    );
  }
  return toRefund;
}

/// Periodic housekeeping: finish payments whose browser never came back,
/// expire old gifts, drop abandoned checkouts and retry refunds.
Future<void> sweepGifts(Session session) async {
  if (!paymentsConfigured(session)) return;
  final now = clock();

  final waiting = await Gift.db.find(
    session,
    where: (t) => t.status.equals(GiftStatus.awaitingPayment),
  );
  for (final g in waiting) {
    final age = now.difference(g.createdAt);
    if (age < const Duration(minutes: 10)) continue;
    await settleGift(
      session,
      g.id!,
      definitive: age > const Duration(hours: 2),
    );
  }

  final due = await Gift.db.find(
    session,
    where: (t) => t.status.equals(GiftStatus.pending) & (t.expiresAt <= now),
  );
  for (final g in due) {
    final expired = await session.db.transaction((tx) async {
      final locked = await Gift.db.findById(
        session,
        g.id!,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (locked == null || locked.status != GiftStatus.pending) return false;
      await Gift.db.updateRow(
        session,
        locked.copyWith(status: GiftStatus.expired, closedAt: now),
        transaction: tx,
      );
      return true;
    });
    if (expired) await refundGift(session, g.id!);
  }

  final unrefunded = await Gift.db.find(
    session,
    where: (t) =>
        t.status.inSet({GiftStatus.cancelled, GiftStatus.expired}) &
        t.refundedAt.equals(null) &
        t.paymentId.notEquals(null) &
        (t.refundAttempts < 20),
  );
  for (final g in unrefunded) {
    await refundGift(session, g.id!);
  }
}
