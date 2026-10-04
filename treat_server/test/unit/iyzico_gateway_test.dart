import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:treat_server/src/payments/iyzico.dart';

const _request = CheckoutRequest(
  conversationId: 'gift-abc',
  basketId: 'gift-7',
  amountTl: 100,
  itemName: 'Treat gift at Café',
  buyerId: 'student-1',
  buyerName: 'Ali Yılmaz',
  buyerEmail: 'ali@ogr.anadolu.edu.tr',
  buyerIp: '1.2.3.4',
  callbackUrl: 'https://treat.example/pay/iyzico/7',
);

http.Response _json(Object body) => http.Response(
  jsonEncode(body),
  200,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

IyzicoGateway _gateway(MockClient client) => IyzicoGateway(
  apiKey: 'sandbox-key',
  secretKey: 'sandbox-secret',
  client: client,
);

void main() {
  test('a checkout is posted signed to the sandbox and returns the page', () async {
    late http.Request seen;
    final gateway = _gateway(
      MockClient((r) async {
        seen = r;
        return _json({
          'status': 'success',
          'token': 'tok',
          'paymentPageUrl': 'https://sandbox-cpp.iyzipay.com?token=tok',
        });
      }),
    );
    final start = await gateway.startCheckout(_request);
    expect(start.token, 'tok');
    expect(start.paymentPageUrl, contains('sandbox-cpp'));

    expect(
      seen.url.toString(),
      'https://sandbox-api.iyzipay.com/payment/iyzipos/checkoutform/initialize/auth/ecom',
    );
    final rnd = seen.headers['x-iyzi-rnd']!;
    // The header must be reproducible from key, secret, random key, path, body.
    expect(
      seen.headers['Authorization'],
      iyzicoAuthorization(
        apiKey: 'sandbox-key',
        secretKey: 'sandbox-secret',
        randomKey: rnd,
        path: '/payment/iyzipos/checkoutform/initialize/auth/ecom',
        body: seen.body,
      ),
    );
    final body = jsonDecode(seen.body) as Map<String, Object?>;
    expect(body['price'], '100.00');
    expect(body['paidPrice'], '100.00');
    expect(body['currency'], 'TRY');
    expect(body['conversationId'], 'gift-abc');
    expect(body['callbackUrl'], 'https://treat.example/pay/iyzico/7');
    expect((body['buyer'] as Map)['name'], 'Ali');
    expect((body['buyer'] as Map)['surname'], 'Yılmaz');
    final item = (body['basketItems'] as List).single as Map;
    expect(item['price'], '100.00');
    expect(item['itemType'], 'VIRTUAL');
  });

  test('a paid checkout result gives ids and the amount in kuruş', () async {
    final fields = {
      'paymentStatus': 'SUCCESS',
      'paymentId': '555',
      'currency': 'TRY',
      'basketId': 'gift-7',
      'conversationId': 'gift-abc',
      'paidPrice': 100.5,
      'price': 100.5,
      'token': 'tok',
    };
    final gateway = _gateway(
      MockClient(
        (r) async => _json({
          'status': 'success',
          ...fields,
          'itemTransactions': [
            {'paymentTransactionId': '777'},
          ],
          'signature': iyzicoResultSignature([
            'SUCCESS',
            '555',
            'TRY',
            'gift-7',
            'gift-abc',
            '100.5',
            '100.5',
            'tok',
          ], 'sandbox-secret'),
        }),
      ),
    );
    final result = await gateway.fetchResult('tok', 'gift-abc');
    expect(result.paid, isTrue);
    expect(result.paidKurus, 10050);
    expect(result.paymentId, '555');
    expect(result.paymentTransactionId, '777');
    expect(result.conversationId, 'gift-abc');
    expect(result.signatureMismatch, isFalse);
  });

  test('a wrong result signature is flagged, not hidden', () async {
    final gateway = _gateway(
      MockClient(
        (r) async => _json({
          'status': 'success',
          'paymentStatus': 'SUCCESS',
          'paymentId': '1',
          'paidPrice': 20,
          'signature': 'nope',
        }),
      ),
    );
    expect((await gateway.fetchResult('t', 'c')).signatureMismatch, isTrue);
  });

  test('a failed payment is not paid, and iyzico errors surface as '
      'PaymentException with code', () async {
    final unpaid = _gateway(
      MockClient(
        (r) async => _json({'status': 'success', 'paymentStatus': 'FAILURE'}),
      ),
    );
    expect((await unpaid.fetchResult('t', 'c')).paid, isFalse);

    final refused = _gateway(
      MockClient(
        (r) async => _json({
          'status': 'failure',
          'errorCode': '11',
          'errorMessage': 'Invalid token',
        }),
      ),
    );
    await expectLater(
      refused.fetchResult('t', 'c'),
      throwsA(
        isA<PaymentException>()
            .having((e) => e.code, 'code', '11')
            .having((e) => e.message, 'message', 'Invalid token'),
      ),
    );
  });

  test('network failures and non-JSON answers are PaymentExceptions', () async {
    await expectLater(
      _gateway(
        MockClient((r) async => throw Exception('offline')),
      ).cancelPayment(
        '1',
        ip: '1.2.3.4',
      ),
      throwsA(isA<PaymentException>()),
    );
    await expectLater(
      _gateway(
        MockClient((r) async => http.Response('<html>', 502)),
      ).cancelPayment('1', ip: '1.2.3.4'),
      throwsA(isA<PaymentException>()),
    );
  });

  test('cancel and refund post the documented fields', () async {
    final seen = <http.Request>[];
    final gateway = _gateway(
      MockClient((r) async {
        seen.add(r);
        return _json({'status': 'success'});
      }),
    );
    await gateway.cancelPayment('555', ip: '1.2.3.4');
    await gateway.refundTransaction('777', kurus: 2050, ip: '1.2.3.4');
    expect(seen[0].url.path, '/payment/cancel');
    expect((jsonDecode(seen[0].body) as Map)['paymentId'], '555');
    expect(seen[1].url.path, '/payment/refund');
    final refund = jsonDecode(seen[1].body) as Map;
    expect(refund['paymentTransactionId'], '777');
    expect(refund['price'], '20.50');
  });
}
