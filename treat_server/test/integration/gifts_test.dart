import 'dart:convert';

import 'package:test/test.dart';
import 'package:treat_server/src/domain/clock.dart';
import 'package:treat_server/src/domain/gift_rules.dart';
import 'package:treat_server/src/generated/protocol.dart';
import 'package:treat_server/src/payments/iyzico.dart';
import 'package:treat_server/src/services/gifts.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Stands in for iyzico: remembers what was asked, answers what the test says.
class FakeGateway implements PaymentGateway {
  final started = <CheckoutRequest>[];
  final cancelled = <String>[];
  final refunded = <({String id, int kurus})>[];

  /// Token → result, filled by [payFor].
  final results = <String, CheckoutResult>{};
  bool failStart = false;
  bool failCancel = false;
  bool failRefund = false;
  bool resultsDown = false;
  var _n = 0;

  @override
  Future<CheckoutStart> startCheckout(CheckoutRequest request) async {
    if (failStart) throw PaymentException('iyzico is down');
    started.add(request);
    final token = 'tok-${++_n}';
    return CheckoutStart(
      token: token,
      paymentPageUrl: 'https://pay.example/$token',
    );
  }

  /// The buyer completes the payment page for the latest checkout.
  String payFor(CheckoutRequest r, {int? kurus, bool paid = true}) {
    final token = 'tok-${started.indexOf(r) + 1}';
    results[token] = CheckoutResult(
      paid: paid,
      conversationId: r.conversationId,
      paidKurus: kurus ?? r.amountTl * 100,
      paymentId: paid ? 'pay-$token' : null,
      paymentTransactionId: paid ? 'trx-$token' : null,
    );
    return token;
  }

  @override
  Future<CheckoutResult> fetchResult(
    String token,
    String conversationId,
  ) async {
    if (resultsDown) throw PaymentException('timeout');
    final r = results[token];
    if (r == null) throw PaymentException('not paid yet', code: '5');
    return r;
  }

  @override
  Future<void> cancelPayment(String paymentId, {required String ip}) async {
    if (failCancel) throw PaymentException('cancel refused');
    cancelled.add(paymentId);
  }

  @override
  Future<void> refundTransaction(
    String id, {
    required int kurus,
    required String ip,
  }) async {
    if (failRefund) throw PaymentException('refund refused');
    refunded.add((id: id, kurus: kurus));
  }
}

void main() {
  late FakeGateway gateway;
  late DateTime now;
  setUp(() {
    gateway = FakeGateway();
    paymentGatewayOverride = gateway;
    now = DateTime.utc(2026, 10, 5, 9);
    clock = () => now;
  });
  tearDown(() {
    paymentGatewayOverride = null;
    clock = () => DateTime.now().toUtc();
  });

  group('rules', () {
    test('the 15 % split is exact in kuruş', () {
      final s = giftSplit(100);
      expect(s.commissionKurus, 1500);
      expect(s.netKurus, 8500);
      expect(giftSplit(20).commissionKurus, 300);
      expect(giftSplit(999).commissionKurus + giftSplit(999).netKurus, 99900);
    });

    test('price formatting and parsing', () {
      expect(formatTl(2000), '20.00');
      expect(formatTl(10050), '100.50');
      expect(parseKurus('100.5'), 10050);
      expect(parseKurus(null), 0);
    });

    test('the IYZWSv2 header signs randomKey + path + body with the secret', () {
      final header = iyzicoAuthorization(
        apiKey: 'key',
        secretKey: 'secret',
        randomKey: '123456',
        path: '/payment/cancel',
        body: '{"a":1}',
      );
      expect(header, startsWith('IYZWSv2 '));
      final decoded = String.fromCharCodes(
        base64Decode(header.substring('IYZWSv2 '.length)),
      );
      // HMAC-SHA256("123456/payment/cancel{\"a\":1}", "secret"), hex.
      expect(
        decoded,
        'apiKey:key&randomKey:123456&signature:'
        '${iyzicoResultSignature(['123456/payment/cancel{"a":1}'], 'secret')}',
      );
    });
  });

  withServerpod('Given a verified place and two verified students', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder owner;
    late TestSessionBuilder ali;
    late TestSessionBuilder bea;
    late int shopId;
    late int beaId;

    setUp(() async {
      owner = await signedInAs(sessionBuilder, 'owner@place.com');
      final shop = (await endpoints.profile.createShop(
        owner,
        shopInput(),
      )).shop!;
      shopId = shop.id!;
      await Shop.db.updateRow(
        sessionBuilder.build(),
        shop.copyWith(verified: true),
      );
      ali = await signedInAs(sessionBuilder, 'ali@ogr.anadolu.edu.tr');
      await endpoints.profile.createStudent(ali, 'Ali Yılmaz', 'AU');
      bea = await signedInAs(sessionBuilder, 'bea@ogr.anadolu.edu.tr');
      beaId = (await endpoints.profile.createStudent(
        bea,
        'Bea',
        'AU',
      )).student!.id!;
    });

    GiftInput input({
      int amount = 100,
      String? email = 'bea@ogr.anadolu.edu.tr',
      int? studentId,
      String? message,
    }) => GiftInput(
      shopId: shopId,
      amountTl: amount,
      recipientEmail: email,
      recipientStudentId: studentId,
      message: message,
    );

    /// Sends and pays; returns the settled gift as the sender sees it.
    Future<GiftView> sendAndPay({int amount = 100}) async {
      final checkout = await endpoints.gift.send(ali, input(amount: amount));
      gateway.payFor(gateway.started.last);
      return endpoints.gift.confirm(ali, checkout.gift.id!);
    }

    group('sending', () {
      test('when a gift is sent then iyzico gets the right basket and the '
          'gift waits for payment', () async {
        final checkout = await endpoints.gift.send(
          ali,
          input(amount: 150, message: ' Enjoy! '),
        );
        expect(checkout.paymentPageUrl, 'https://pay.example/tok-1');
        expect(checkout.gift.status, GiftStatus.awaitingPayment);
        expect(checkout.gift.amountTl, 150);
        expect(checkout.gift.commissionKurus, 2250);
        expect(checkout.gift.netKurus, 12750);
        expect(checkout.gift.message, 'Enjoy!');
        expect(checkout.gift.code, isNull);
        final r = gateway.started.single;
        expect(r.amountTl, 150);
        expect(r.buyerName, 'Ali Yılmaz');
        expect(r.callbackUrl, endsWith('/pay/iyzico/${checkout.gift.id}'));
        expect(r.conversationId, startsWith('gift-'));
      });

      test('when the recipient is picked from a profile then it works too, '
          'and giving both or neither is invalid_recipient', () async {
        final ok = await endpoints.gift.send(
          ali,
          input(email: null, studentId: beaId),
        );
        expect(ok.gift.recipientName, 'Bea');
        await expectLater(
          endpoints.gift.send(ali, input(studentId: beaId)),
          throwsTreat('invalid_recipient'),
        );
        await expectLater(
          endpoints.gift.send(ali, input(email: null)),
          throwsTreat('invalid_recipient'),
        );
      });

      test('when the amount, recipient or place is wrong then the right '
          'error and no payment is started', () async {
        await expectLater(
          endpoints.gift.send(ali, input(amount: 19)),
          throwsTreat('invalid_amount'),
        );
        await expectLater(
          endpoints.gift.send(ali, input(amount: 1001)),
          throwsTreat('invalid_amount'),
        );
        await expectLater(
          endpoints.gift.send(ali, input(email: 'ali@ogr.anadolu.edu.tr')),
          throwsTreat('gift_to_self'),
        );
        await expectLater(
          endpoints.gift.send(ali, input(email: 'nobody@x.edu.tr')),
          throwsTreat('recipient_not_found'),
        );
        final cem = await signedInAs(sessionBuilder, 'cem@gmail.com');
        await endpoints.profile.createStudent(cem, 'Cem', 'AU');
        await expectLater(
          endpoints.gift.send(ali, input(email: 'cem@gmail.com')),
          throwsTreat('recipient_not_verified'),
        );
        await expectLater(
          endpoints.gift.send(cem, input()),
          throwsTreat('not_verified'),
        );
        await expectLater(
          endpoints.gift.send(owner, input()),
          throwsTreat('not_a_student'),
        );
        await expectLater(
          endpoints.gift.send(ali, input(message: 'x' * 141)),
          throwsTreat('note_too_long'),
        );
        expect(gateway.started, isEmpty);
      });

      test('when the place is not verified then shop_not_giftable', () async {
        final other = await signedInAs(sessionBuilder, 'o2@place.com');
        final shop = (await endpoints.profile.createShop(
          other,
          shopInput(name: 'Unverified'),
        )).shop!;
        await expectLater(
          endpoints.gift.send(
            ali,
            GiftInput(
              shopId: shop.id!,
              amountTl: 50,
              recipientEmail: 'bea@ogr.anadolu.edu.tr',
            ),
          ),
          throwsTreat('shop_not_giftable'),
        );
        final places = await endpoints.gift.places(ali);
        expect(places.map((s) => s.id), [shopId]);
      });

      test('when iyzico is down then payment_unavailable and the gift is '
          'closed', () async {
        gateway.failStart = true;
        await expectLater(
          endpoints.gift.send(ali, input()),
          throwsTreat('payment_unavailable'),
        );
        expect(await endpoints.gift.sent(ali), isEmpty);
      });

      test('when ten gifts were started today then daily_gift_cap; '
          'tomorrow it is open again', () async {
        for (var i = 0; i < giftDailySendCap; i++) {
          await endpoints.gift.send(ali, input());
        }
        await expectLater(
          endpoints.gift.send(ali, input()),
          throwsTreat('daily_gift_cap'),
        );
        now = now.add(const Duration(days: 1));
        await endpoints.gift.send(ali, input());
      });
    });

    group('payment result', () {
      test('when the sender paid then the gift is pending with a code the '
          'recipient sees and the sender does not', () async {
        final view = await sendAndPay();
        expect(view.gift.status, GiftStatus.pending);
        expect(view.gift.code, isNull);
        expect(view.gift.expiresAt, now.add(giftTtl));

        final received = await endpoints.gift.received(bea);
        expect(received.single.gift.code, hasLength(6));
        expect(received.single.gift.senderName, 'Ali Yılmaz');
        // iyzico's ids never leave the server.
        expect(
          received.single.gift.toJsonForProtocol().containsKey('paymentId'),
          isFalse,
        );
        expect(
          (await endpoints.gift.get(ali, view.gift.id!)).gift.code,
          isNull,
        );
        await expectLater(
          endpoints.gift.get(owner, view.gift.id!),
          throwsTreat('not_a_student'),
        );
      });

      test('when not paid yet then confirm leaves it waiting', () async {
        final checkout = await endpoints.gift.send(ali, input());
        final view = await endpoints.gift.confirm(ali, checkout.gift.id!);
        expect(view.gift.status, GiftStatus.awaitingPayment);
      });

      test('when iyzico cannot be reached then confirm leaves it waiting '
          'and never closes a gift that may be paid', () async {
        final checkout = await endpoints.gift.send(ali, input());
        gateway.payFor(gateway.started.last);
        gateway.resultsDown = true;
        final view = await endpoints.gift.confirm(ali, checkout.gift.id!);
        expect(view.gift.status, GiftStatus.awaitingPayment);
      });

      test('when confirm runs twice then the gift keeps one code', () async {
        final first = await sendAndPay();
        final second = await endpoints.gift.confirm(ali, first.gift.id!);
        expect(second.gift.status, GiftStatus.pending);
        expect(
          (await endpoints.gift.received(bea)).single.gift.code,
          hasLength(6),
        );
      });

      test('when the paid amount is not the gift amount then it is closed '
          'and refunded, never delivered', () async {
        final checkout = await endpoints.gift.send(ali, input(amount: 100));
        gateway.payFor(gateway.started.last, kurus: 100);
        final view = await endpoints.gift.confirm(ali, checkout.gift.id!);
        expect(view.gift.status, GiftStatus.cancelled);
        expect(gateway.cancelled, ['pay-tok-1']);
        expect(await endpoints.gift.received(bea), isEmpty);
      });

      test('when a payment fails at the sweep after two hours then the gift '
          'is dropped', () async {
        final checkout = await endpoints.gift.send(ali, input());
        gateway.payFor(gateway.started.last, paid: false);
        now = now.add(const Duration(hours: 3));
        await sweepGifts(sessionBuilder.build());
        expect(
          (await Gift.db.findById(
            sessionBuilder.build(),
            checkout.gift.id!,
          ))!.status,
          GiftStatus.paymentFailed,
        );
        expect(await endpoints.gift.sent(ali), isEmpty);
      });

      test('when the browser never came back but the money moved then the '
          'sweep delivers the gift', () async {
        final checkout = await endpoints.gift.send(ali, input());
        gateway.payFor(gateway.started.last);
        now = now.add(const Duration(minutes: 11));
        await sweepGifts(sessionBuilder.build());
        expect(
          (await endpoints.gift.get(ali, checkout.gift.id!)).gift.status,
          GiftStatus.pending,
        );
      });
    });

    group('collecting', () {
      test('when the place scans the QR then the gift is handed over, the '
          'recipient gets a treat and the place is credited', () async {
        final view = await sendAndPay(amount: 100);
        final code = (await endpoints.gift.received(bea)).single.gift.code!;

        final result = await endpoints.shop.redeem(
          owner,
          'GIFT:${view.gift.id}:$code',
        );
        expect(result.view, isNull);
        expect(result.gift!.status, GiftStatus.redeemed);
        expect(result.alreadyRedeemed, isFalse);
        expect(result.gift!.code, isNull);

        final me = await endpoints.profile.getMe(bea);
        expect(me.student!.treats, 1);
        expect(me.student!.categoriesTried, [OfferCategory.coffee]);

        final stats = (await endpoints.shop.dashboard(owner)).gifts;
        expect(stats.redeemed, 1);
        expect(stats.netRedeemedTl, 85);
        expect(stats.waiting, 0);

        // A second scan changes nothing.
        final again = await endpoints.shop.redeem(owner, code);
        expect(again.alreadyRedeemed, isTrue);
        expect((await endpoints.profile.getMe(bea)).student!.treats, 1);
      });

      test('when the place types the 6-character code then it works like '
          'the QR', () async {
        await sendAndPay();
        final code = (await endpoints.gift.received(bea)).single.gift.code!;
        final result = await endpoints.shop.redeem(owner, code.toLowerCase());
        expect(result.gift!.status, GiftStatus.redeemed);
      });

      test('when another place scans it then wrong_shop, and unknown codes '
          'are not_found', () async {
        final view = await sendAndPay();
        final code = (await endpoints.gift.received(bea)).single.gift.code!;
        final other = await signedInAs(sessionBuilder, 'o2@place.com');
        await endpoints.profile.createShop(other, shopInput(name: 'Other'));
        await expectLater(
          endpoints.shop.redeem(other, 'GIFT:${view.gift.id}:$code'),
          throwsTreat('wrong_shop'),
        );
        await expectLater(
          endpoints.shop.redeem(owner, 'ZZZZZZ'),
          throwsTreat('not_found'),
        );
        await expectLater(
          endpoints.shop.redeem(owner, 'GIFT:999:ABCDEF'),
          throwsTreat('not_found'),
        );
      });

      test('when the gift is older than 30 days then it expires, the sweep '
          'refunds it and the place cannot redeem it', () async {
        final view = await sendAndPay();
        final code = (await endpoints.gift.received(bea)).single.gift.code!;
        now = now.add(giftTtl + const Duration(hours: 1));
        await expectLater(
          endpoints.shop.redeem(owner, code),
          throwsTreat('expired'),
        );
        await sweepGifts(sessionBuilder.build());
        final stored = (await Gift.db.findById(
          sessionBuilder.build(),
          view.gift.id!,
        ))!;
        expect(stored.status, GiftStatus.expired);
        expect(stored.refundedAt, isNotNull);
        // Paid 30 days ago, so it is a refund, not a cancel.
        expect(gateway.refunded.single.kurus, 10000);
        expect(gateway.cancelled, isEmpty);
      });
    });

    group('cancelling and refunds', () {
      test(
        'when the sender cancels the same day then the payment is '
        'cancelled at iyzico and the gift can no longer be redeemed',
        () async {
          final view = await sendAndPay();
          final code = (await endpoints.gift.received(bea)).single.gift.code!;
          final cancelled = await endpoints.gift.cancel(ali, view.gift.id!);
          expect(cancelled.gift.status, GiftStatus.cancelled);
          expect(cancelled.refundPending, isFalse);
          expect(gateway.cancelled, ['pay-tok-1']);
          expect(await endpoints.gift.received(bea), isEmpty);
          await expectLater(
            endpoints.shop.redeem(owner, code),
            throwsTreat('not_found'),
          );
        },
      );

      test('when the sender cancels days later then it is refunded by '
          'transaction', () async {
        final view = await sendAndPay(amount: 40);
        now = now.add(const Duration(days: 3));
        await endpoints.gift.cancel(ali, view.gift.id!);
        expect(gateway.refunded.single, (id: 'trx-tok-1', kurus: 4000));
      });

      test('when iyzico refuses the refund then it stays pending and the '
          'sweep retries until it works', () async {
        final view = await sendAndPay();
        gateway.failCancel = true;
        gateway.failRefund = true;
        final cancelled = await endpoints.gift.cancel(ali, view.gift.id!);
        expect(cancelled.refundPending, isTrue);

        await sweepGifts(sessionBuilder.build());
        expect(
          (await endpoints.gift.get(ali, view.gift.id!)).refundPending,
          isTrue,
        );
        gateway.failCancel = false;
        await sweepGifts(sessionBuilder.build());
        final done = await endpoints.gift.get(ali, view.gift.id!);
        expect(done.refundPending, isFalse);
        expect(gateway.cancelled, hasLength(1));
      });

      test(
        'when cancel and the place scan race then exactly one wins',
        () async {
          final view = await sendAndPay();
          final code = (await endpoints.gift.received(bea)).single.gift.code!;
          await endpoints.shop.redeem(owner, code);
          await expectLater(
            endpoints.gift.cancel(ali, view.gift.id!),
            throwsTreat('gift_redeemed'),
          );
          expect(gateway.cancelled, isEmpty);
        },
      );

      test('when someone else tries to cancel or the gift is closed then '
          'not_found / gift_closed', () async {
        final view = await sendAndPay();
        await expectLater(
          endpoints.gift.cancel(bea, view.gift.id!),
          throwsTreat('not_found'),
        );
        await endpoints.gift.cancel(ali, view.gift.id!);
        await expectLater(
          endpoints.gift.cancel(ali, view.gift.id!),
          throwsTreat('gift_closed'),
        );
      });

      test(
        'when an unpaid gift is cancelled then no refund is needed',
        () async {
          final checkout = await endpoints.gift.send(ali, input());
          await endpoints.gift.cancel(ali, checkout.gift.id!);
          expect(gateway.cancelled, isEmpty);
          expect(gateway.refunded, isEmpty);
          expect(await endpoints.gift.sent(ali), isEmpty);
        },
      );
    });

    group('account deletion', () {
      test('when the sender deletes the account then open gifts are '
          'refunded and the rows keep amounts but no names', () async {
        final view = await sendAndPay();
        await endpoints.profile.deleteAccount(ali);
        expect(gateway.cancelled, ['pay-tok-1']);
        final stored = (await Gift.db.findById(
          sessionBuilder.build(),
          view.gift.id!,
        ))!;
        expect(stored.status, GiftStatus.cancelled);
        expect(stored.senderName, '');
        expect(stored.senderId, isNull);
        expect(stored.recipientName, 'Bea');
        expect(stored.amountTl, 100);
        expect(await endpoints.gift.received(bea), isEmpty);
      });

      test('when the place deletes the account then every open gift is '
          'refunded', () async {
        await sendAndPay();
        await endpoints.profile.deleteAccount(owner);
        expect(gateway.cancelled, ['pay-tok-1']);
        expect(await endpoints.gift.sent(ali), hasLength(1));
        expect(
          (await endpoints.gift.sent(ali)).single.gift.status,
          GiftStatus.cancelled,
        );
      });
    });
  });
}
