import 'accounts.dart';

/// Hosts Google uses for review / Maps links ("Ask for reviews" in Google
/// Business Profile gives a g.page or search.google.com link).
const _googleHosts = {
  'g.page',
  'search.google.com',
  'www.google.com',
  'google.com',
  'maps.google.com',
  'maps.app.goo.gl',
  'goo.gl',
};

/// Null/blank clears the link; anything else must be an https Google link.
String? validGoogleReviewUrl(String? input) {
  final t = input?.trim();
  if (t == null || t.isEmpty) return null;
  final uri = Uri.tryParse(t);
  if (uri == null ||
      uri.scheme != 'https' ||
      !_googleHosts.contains(uri.host.toLowerCase()) ||
      t.length > 300) {
    throw treatError(
      'invalid_google_link',
      'Paste the review link from your Google Business Profile.',
    );
  }
  return uri.toString();
}
