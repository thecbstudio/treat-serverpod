import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../../services/gifts.dart';

/// POST /pay/iyzico/:id — iyzico sends the browser back here after its
/// payment page, with the checkout token in a form post. The token only says
/// which payment to look at: the result is fetched from iyzico with our own
/// credentials, never taken from the browser. Then the browser continues to
/// the gift page of the app.
class IyzicoCallbackRoute extends Route {
  IyzicoCallbackRoute() : super(methods: {Method.post});

  @override
  Future<Result> handleCall(Session session, Request request) async {
    final id = int.tryParse(request.pathParameters.raw[#id] ?? '');
    var outcome = 'failed';
    if (id != null) {
      try {
        final form = Uri.splitQueryString(await request.readAsString());
        final gift = await Gift.db.findById(session, id);
        // Ignore tokens that aren't the one we issued for this gift.
        if (gift != null &&
            gift.paymentToken != null &&
            gift.paymentToken == form['token']) {
          final settled = await settleGift(session, id, definitive: true);
          outcome = settled.status == GiftStatus.pending ? 'ok' : 'failed';
        }
      } catch (e, st) {
        session.log(
          'iyzico callback for gift $id failed',
          level: LogLevel.warning,
          exception: e,
          stackTrace: st,
        );
        outcome = 'unknown';
      }
    }
    // 303: turn iyzico's POST into a GET of the app page.
    return Response.seeOther(
      Uri(
        path: id == null ? '/gifts' : '/gift/$id',
        queryParameters: {'pay': outcome},
      ),
    );
  }
}
