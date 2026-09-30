import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../html.dart';

/// GET /card/:id — a printable counter card for a place (two A6 sides):
/// the front asks *every* customer for a Google review via the place's own
/// review link; the back tells students there's a treat here. Nothing on the
/// card is conditional on a review, so it's fine by Google's rules.
class PlaceCardRoute extends Route {
  @override
  Future<Result> handleCall(Session session, Request request) async {
    final id = int.tryParse(request.pathParameters.raw[#id] ?? '');
    final shop = id == null ? null : await Shop.db.findById(session, id);
    if (shop == null) return notFoundPage();
    final origin = originOf(request);
    final placeUrl = '$origin/p/${shop.id}';
    final google = shop.googleReviewUrl;

    final front = google == null
        ? '''
<div class="side">
  <div class="kicker">Google review card</div>
  <h1>Add your Google review link</h1>
  <p class="hint">In your Google Business Profile tap <b>Ask for reviews</b>,
  copy the link and paste it in <b>treat → Business → Google review card</b>.
  This side then shows a QR code every customer can scan.</p>
</div>'''
        : '''
<div class="side">
  <div class="kicker">${esc(shop.name)}</div>
  <h1>Enjoyed your visit?</h1>
  <div class="qr">${qrSvg(google)}</div>
  <p class="big">Leave us a review on Google</p>
  <p class="hint">Scan with your phone camera · takes 30 seconds</p>
</div>''';

    final back =
        '''
<div class="side back">
  <div class="mark logo">treat.</div>
  <h1>Student? Your treat here is free.</h1>
  <div class="qr">${qrSvg(placeUrl, color: '#E8532B')}</div>
  <p class="big">${esc(shop.name)} on treat</p>
  <p class="hint">Claim a free treat, post about the place, get it verified.</p>
</div>''';

    final html = page(
      title: '${shop.name} · counter card · treat.',
      extraCss: _css,
      body:
          '''
<div class="bar screen-only">
  <span><span class="mark">treat.</span> counter card for <b>${esc(shop.name)}</b></span>
  <button onclick="window.print()">Print</button>
</div>
<main>$front$back</main>''',
    );
    return Response.ok(body: Body.fromString(html, mimeType: MimeType.html));
  }
}

const _css = '''
  .bar { display:flex; justify-content:space-between; align-items:center;
         gap:12px; padding:14px 20px; background:#fff;
         border-bottom:1px solid var(--border); }
  .bar button { background:var(--accent); color:#fff; border:0; border-radius:10px;
                padding:10px 18px; font:inherit; font-weight:800; cursor:pointer; }
  main { display:flex; flex-wrap:wrap; gap:24px; justify-content:center; padding:24px; }
  .side { width:105mm; min-height:148mm; background:#fff; border:1px solid var(--border);
          border-radius:14px; padding:14mm 10mm; display:flex; flex-direction:column;
          align-items:center; text-align:center; }
  .side.back { background:linear-gradient(160deg,#FFF3EC,#fff); }
  .kicker { font-weight:800; color:var(--ink2); text-transform:uppercase;
            letter-spacing:.08em; font-size:12px; }
  h1 { font-size:26px; line-height:1.15; margin:10px 0 16px; }
  .qr svg { width:52mm; height:52mm; }
  .big { font-size:18px; font-weight:800; margin:14px 0 4px; }
  .hint { color:var(--ink2); font-size:13px; margin:0; }
  .logo { color:var(--accent); font-size:34px; }
  @page { size: A6; margin: 0; }
  @media print {
    body { background:#fff; }
    .screen-only { display:none; }
    main { display:block; padding:0; }
    .side { border:0; border-radius:0; width:105mm; height:148mm;
            page-break-after:always; }
  }
''';
