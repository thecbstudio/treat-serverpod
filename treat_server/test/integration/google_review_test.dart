import 'package:test/test.dart';
import 'package:treat_server/src/services/demo.dart';
import 'package:treat_server/src/services/google_review.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  group('validGoogleReviewUrl', () {
    test('then accepts Google review / Maps links and clears on blank', () {
      expect(
        validGoogleReviewUrl(' https://g.page/r/CabcDEF/review '),
        'https://g.page/r/CabcDEF/review',
      );
      expect(
        validGoogleReviewUrl(
          'https://search.google.com/local/writereview?placeid=ChIJ123',
        ),
        startsWith('https://search.google.com/'),
      );
      expect(validGoogleReviewUrl('https://maps.app.goo.gl/xyz'), isNotNull);
      expect(validGoogleReviewUrl('  '), isNull);
      expect(validGoogleReviewUrl(null), isNull);
    });

    test('then rejects other sites and plain http', () {
      for (final bad in [
        'https://evil.example/review',
        'http://g.page/r/abc/review',
        'javascript:alert(1)',
        'g.page/r/abc',
      ]) {
        expect(
          () => validGoogleReviewUrl(bad),
          throwsTreat('invalid_google_link'),
          reason: bad,
        );
      }
    });
  });

  withServerpod('Given a place', (sessionBuilder, endpoints) {
    tearDown(() => demoOverride = null);

    test('when it saves its Google review link then the shop has it, even '
        'as a locked demo place', () async {
      demoOverride = true;
      final owner = await signedInAs(sessionBuilder, 'o@place.com');
      await endpoints.profile.createShop(owner, shopInput());
      final shop = await endpoints.profile.setGoogleReviewUrl(
        owner,
        'https://g.page/r/abc/review',
      );
      expect(shop.googleReviewUrl, 'https://g.page/r/abc/review');
      final cleared = await endpoints.profile.setGoogleReviewUrl(owner, null);
      expect(cleared.googleReviewUrl, isNull);
    });
  });
}
