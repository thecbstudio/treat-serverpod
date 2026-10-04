import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// Raised for network problems and for iyzico saying "failure": the caller
/// decides whether to retry. [message] never contains card data.
class PaymentException implements Exception {
  PaymentException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() => 'PaymentException(${code ?? '-'}): $message';
}

/// What we ask iyzico's hosted checkout page to charge.
class CheckoutRequest {
  const CheckoutRequest({
    required this.conversationId,
    required this.basketId,
    required this.amountTl,
    required this.itemName,
    required this.buyerId,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerIp,
    required this.callbackUrl,
  });

  /// Comes back unchanged in the result: ties the payment to our gift.
  final String conversationId;
  final String basketId;
  final int amountTl;
  final String itemName;
  final String buyerId;
  final String buyerName;
  final String buyerEmail;
  final String buyerIp;
  final String callbackUrl;
}

class CheckoutStart {
  const CheckoutStart({required this.token, required this.paymentPageUrl});
  final String token;
  final String paymentPageUrl;
}

/// The paid/not-paid answer for a checkout token.
class CheckoutResult {
  const CheckoutResult({
    required this.paid,
    required this.conversationId,
    required this.paidKurus,
    this.paymentId,
    this.paymentTransactionId,
    this.failureMessage,
  });

  final bool paid;
  final String? conversationId;
  final int paidKurus;
  final String? paymentId;
  final String? paymentTransactionId;
  final String? failureMessage;
}

abstract interface class PaymentGateway {
  Future<CheckoutStart> startCheckout(CheckoutRequest request);

  /// Asks iyzico what happened to [token] (never trusts the browser).
  Future<CheckoutResult> fetchResult(String token, String conversationId);

  /// Returns the whole payment before it settles (same day).
  Future<void> cancelPayment(String paymentId, {required String ip});

  /// Returns [kurus] of one payment transaction (after settlement).
  Future<void> refundTransaction(
    String paymentTransactionId, {
    required int kurus,
    required String ip,
  });
}

String formatTl(int kurus) =>
    '${kurus ~/ 100}.${(kurus % 100).toString().padLeft(2, '0')}';

int parseKurus(Object? price) {
  if (price == null) return 0;
  final v = double.tryParse(price.toString());
  return v == null ? 0 : (v * 100).round();
}

/// iyzico's IYZWSv2 header: HMAC-SHA256 (hex) over `randomKey + path + body`
/// with the secret key, packed with the API key and random key into one
/// base64 string.
String iyzicoAuthorization({
  required String apiKey,
  required String secretKey,
  required String randomKey,
  required String path,
  required String body,
}) {
  final signature = Hmac(
    sha256,
    utf8.encode(secretKey),
  ).convert(utf8.encode('$randomKey$path$body')).toString();
  final params = 'apiKey:$apiKey&randomKey:$randomKey&signature:$signature';
  return 'IYZWSv2 ${base64Encode(utf8.encode(params))}';
}

/// The result signature iyzico adds to a retrieved checkout form: HMAC-SHA256
/// (hex) of the listed fields joined with ":". Confirmed against the live
/// sandbox, including how numbers are written (see [iyzicoNumber]).
String iyzicoResultSignature(List<String?> fields, String secretKey) => Hmac(
  sha256,
  utf8.encode(secretKey),
).convert(utf8.encode(fields.map((f) => f ?? '').join(':'))).toString();

/// A JSON number the way iyzico writes it into its signature: whole values
/// without a decimal point (`20.0` is `20`), others as they are (`100.5`).
String? iyzicoNumber(Object? v) {
  if (v == null) return null;
  if (v is num && v.isFinite && v == v.roundToDouble()) {
    return v.toInt().toString();
  }
  return v.toString();
}

/// iyzico's REST API (sandbox or live, by [baseUrl]) via the hosted checkout
/// form: card data never touches treat's server.
class IyzicoGateway implements PaymentGateway {
  IyzicoGateway({
    required this.apiKey,
    required this.secretKey,
    this.baseUrl = sandboxUrl,
    http.Client? client,
    Random? random,
  }) : _http = client ?? http.Client(),
       _random = random ?? Random.secure();

  static const sandboxUrl = 'https://sandbox-api.iyzipay.com';

  final String apiKey;
  final String secretKey;
  final String baseUrl;
  final http.Client _http;
  final Random _random;

  String _randomKey() =>
      '${DateTime.now().millisecondsSinceEpoch}${_random.nextInt(1 << 31)}';

  Future<Map<String, Object?>> _post(
    String path,
    Map<String, Object?> body,
  ) async {
    final json = jsonEncode(body);
    final rnd = _randomKey();
    final http.Response response;
    try {
      response = await _http
          .post(
            Uri.parse('$baseUrl$path'),
            headers: {
              'Authorization': iyzicoAuthorization(
                apiKey: apiKey,
                secretKey: secretKey,
                randomKey: rnd,
                path: path,
                body: json,
              ),
              'x-iyzi-rnd': rnd,
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json,
          )
          .timeout(const Duration(seconds: 30));
    } catch (e) {
      throw PaymentException('iyzico unreachable: $e');
    }
    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (_) {
      throw PaymentException('iyzico answered HTTP ${response.statusCode}');
    }
    if (decoded is! Map<String, Object?>) {
      throw PaymentException('iyzico answer is not an object');
    }
    if (decoded['status'] != 'success') {
      throw PaymentException(
        '${decoded['errorMessage'] ?? 'iyzico refused the request'}',
        code: decoded['errorCode']?.toString(),
      );
    }
    return decoded;
  }

  @override
  Future<CheckoutStart> startCheckout(CheckoutRequest r) async {
    final price = formatTl(r.amountTl * 100);
    final parts = r.buyerName.trim().split(RegExp(r'\s+'));
    final name = parts.first;
    final surname = parts.length > 1 ? parts.sublist(1).join(' ') : parts.first;
    // iyzico insists on identity number, phone and addresses for every buyer.
    // Students don't give them to treat, so sandbox runs use iyzico's own
    // placeholder values; live mode would collect them on the checkout page.
    const address = 'Eskişehir';
    final response = await _post(
      '/payment/iyzipos/checkoutform/initialize/auth/ecom',
      {
        'locale': 'en',
        'conversationId': r.conversationId,
        'price': price,
        'paidPrice': price,
        'currency': 'TRY',
        'basketId': r.basketId,
        'paymentGroup': 'PRODUCT',
        'callbackUrl': r.callbackUrl,
        'enabledInstallments': [1],
        'buyer': {
          'id': r.buyerId,
          'name': name,
          'surname': surname,
          'gsmNumber': '+905350000000',
          'email': r.buyerEmail,
          'identityNumber': '11111111111',
          'registrationAddress': address,
          'ip': r.buyerIp,
          'city': 'Eskişehir',
          'country': 'Turkey',
        },
        'shippingAddress': {
          'contactName': r.buyerName,
          'city': 'Eskişehir',
          'country': 'Turkey',
          'address': address,
        },
        'billingAddress': {
          'contactName': r.buyerName,
          'city': 'Eskişehir',
          'country': 'Turkey',
          'address': address,
        },
        'basketItems': [
          {
            'id': r.basketId,
            'name': r.itemName,
            'category1': 'Gift',
            'itemType': 'VIRTUAL',
            'price': price,
          },
        ],
      },
    );
    final token = response['token'];
    final url = response['paymentPageUrl'];
    if (token is! String || url is! String) {
      throw PaymentException('iyzico answered without a payment page');
    }
    return CheckoutStart(token: token, paymentPageUrl: url);
  }

  @override
  Future<CheckoutResult> fetchResult(
    String token,
    String conversationId,
  ) async {
    final r = await _post('/payment/iyzipos/checkoutform/auth/ecom/detail', {
      'locale': 'en',
      'conversationId': conversationId,
      'token': token,
    });
    // Integrity: the answer is signed with our secret key. Without a valid
    // signature nothing is believed.
    final expected = iyzicoResultSignature([
      r['paymentStatus']?.toString(),
      r['paymentId']?.toString(),
      r['currency']?.toString(),
      r['basketId']?.toString(),
      r['conversationId']?.toString(),
      iyzicoNumber(r['paidPrice']),
      iyzicoNumber(r['price']),
      r['token']?.toString(),
    ], secretKey);
    if (r['signature'] != expected) {
      throw PaymentException(
        'iyzico answer has a wrong signature',
        code: 'signature',
      );
    }
    final items = r['itemTransactions'];
    final tx = items is List && items.isNotEmpty && items.first is Map
        ? (items.first as Map)['paymentTransactionId']?.toString()
        : null;
    final paid = r['paymentStatus'] == 'SUCCESS';
    return CheckoutResult(
      paid: paid,
      conversationId: r['conversationId']?.toString(),
      paidKurus: parseKurus(r['paidPrice']),
      paymentId: r['paymentId']?.toString(),
      paymentTransactionId: tx,
      failureMessage: paid ? null : r['errorMessage']?.toString(),
    );
  }

  @override
  Future<void> cancelPayment(String paymentId, {required String ip}) async {
    await _post('/payment/cancel', {
      'locale': 'en',
      'conversationId': 'cancel-$paymentId',
      'paymentId': paymentId,
      'ip': ip,
      'reason': 'OTHER',
      'description': 'treat gift closed',
    });
  }

  @override
  Future<void> refundTransaction(
    String paymentTransactionId, {
    required int kurus,
    required String ip,
  }) async {
    await _post('/payment/refund', {
      'locale': 'en',
      'conversationId': 'refund-$paymentTransactionId',
      'paymentTransactionId': paymentTransactionId,
      'price': formatTl(kurus),
      'currency': 'TRY',
      'ip': ip,
      'reason': 'OTHER',
      'description': 'treat gift closed',
    });
  }
}
