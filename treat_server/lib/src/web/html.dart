import 'dart:convert';

import 'package:qr/qr.dart';
import 'package:serverpod/serverpod.dart';

// Quotes and <>& escaped (safe in text and attributes); "/" kept so URLs in
// meta tags stay readable for link-preview crawlers.
const _escape = HtmlEscape(
  HtmlEscapeMode(
    escapeLtGt: true,
    escapeQuot: true,
    escapeApos: true,
    escapeSlash: false,
  ),
);

/// HTML-escapes user text (place names, reviews) for server-rendered pages.
String esc(String? s) => _escape.convert(s ?? '');

/// The public origin of this request ("https://treat-app.serverpod.space"),
/// honouring the proxy's X-Forwarded-Proto so QR codes point at https.
String originOf(Request request) {
  final host =
      request.headers['x-forwarded-host']?.first ??
      request.headers['host']?.first ??
      request.url.authority;
  final proto =
      request.headers['x-forwarded-proto']?.first ??
      (host.startsWith('localhost') || host.startsWith('127.')
          ? 'http'
          : 'https');
  return '$proto://$host';
}

/// A QR code as a crisp, printable inline SVG.
String qrSvg(String data, {int size = 220, String color = '#241C17'}) {
  final image = QrImage(
    QrCode.fromData(data: data, errorCorrectLevel: QrErrorCorrectLevel.M),
  );
  final n = image.moduleCount;
  const quiet = 2;
  final dim = n + quiet * 2;
  final rects = StringBuffer();
  for (var y = 0; y < n; y++) {
    for (var x = 0; x < n; x++) {
      if (image.isDark(y, x)) {
        rects.write('M${x + quiet} ${y + quiet}h1v1h-1z');
      }
    }
  }
  return '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 $dim $dim" '
      'width="$size" height="$size" shape-rendering="crispEdges" '
      'role="img" aria-label="QR code">'
      '<rect width="$dim" height="$dim" fill="#fff"/>'
      '<path d="$rects" fill="$color"/></svg>';
}

/// Shared page shell in the app's colours and type.
String page({
  required String title,
  required String body,
  String head = '',
  String extraCss = '',
}) =>
    '''<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${esc(title)}</title>
<link rel="icon" type="image/png" href="/favicon.png">
$head
<style>
  :root { --accent:#E8532B; --ink:#241C17; --ink2:#6F6157; --bg:#FAF6F0;
          --card:#fff; --border:#EEE4D6; --star:#F2A516; }
  * { box-sizing: border-box; }
  body { margin:0; background:var(--bg); color:var(--ink);
         font-family: "Nunito", system-ui, -apple-system, "Segoe UI", Roboto, sans-serif; }
  a { color: var(--accent); }
  .mark { font-weight:900; letter-spacing:-1px; }
  $extraCss
</style>
</head>
<body>
$body
</body>
</html>''';

/// A plain "not found" page for unknown place ids.
Response notFoundPage() => Response.notFound(
  body: Body.fromString(
    page(
      title: 'Not found · treat.',
      body:
          '<p style="padding:40px;text-align:center">'
          'This place isn’t on <span class="mark">treat.</span> (anymore).</p>',
    ),
    mimeType: MimeType.html,
  ),
);
