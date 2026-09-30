import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../../services/ratings.dart';
import '../html.dart';

/// Cover photos bundled with the Flutter app (see `shopPhoto` in the app).
const _shopPhotos = {
  'bowling',
  'firin',
  'ferah',
  'glow',
  'mavikitap',
  'tostcu',
};

String coverPath(Shop s) => _shopPhotos.contains(s.seedKey)
    ? '/assets/assets/shop/${s.seedKey}.jpg'
    : '/assets/assets/cat/${s.category.name}.jpg';

/// GET /p/:id — a place's public, server-rendered page: link previews in
/// WhatsApp/Instagram DMs, search engines, and anyone without the app. Shows
/// the treat score, verified reviews and open offers, then opens the app.
class PublicPlaceRoute extends Route {
  @override
  Future<Result> handleCall(Session session, Request request) async {
    final id = int.tryParse(request.pathParameters.raw[#id] ?? '');
    final shop = id == null ? null : await Shop.db.findById(session, id);
    if (shop == null) return notFoundPage();
    final origin = originOf(request);
    final rating = (await ratingsFor(session, {shop.id!}))[shop.id!]!;
    final reviews = await reviewsFor(
      session,
      shop.id!,
      forOwner: false,
      limit: 6,
    );
    final offers = await Offer.db.find(
      session,
      where: (t) =>
          t.shopId.equals(shop.id!) &
          t.status.equals(OfferStatus.active) &
          t.kind.equals(OfferKind.regular),
      orderBy: (t) => t.createdAt,
    );

    final score = rating.count == 0
        ? 'New on treat'
        : '★ ${rating.average.toStringAsFixed(1)} · '
              '${rating.count} verified student visit${rating.count == 1 ? '' : 's'}';
    final description =
        '$score. Students get a free treat here and post about it.';
    final cover = '$origin${coverPath(shop)}';
    final appLink = '$origin/place/${shop.id}';

    // Structured data for search engines; ratings come from a third party
    // (treat), not from the business itself.
    final jsonLd = jsonEncode({
      '@context': 'https://schema.org',
      '@type': 'LocalBusiness',
      'name': shop.name,
      'address': shop.address,
      'image': cover,
      'url': '$origin/p/${shop.id}',
      if (rating.count > 0)
        'aggregateRating': {
          '@type': 'AggregateRating',
          'ratingValue': rating.average,
          'reviewCount': rating.count,
        },
    }).replaceAll('</', r'<\/');

    final html = page(
      title: '${shop.name} on treat.',
      head:
          '''
<meta name="description" content="${esc(description)}">
<meta property="og:type" content="website">
<meta property="og:title" content="${esc(shop.name)} on treat.">
<meta property="og:description" content="${esc(description)}">
<meta property="og:image" content="${esc(cover)}">
<meta name="twitter:card" content="summary_large_image">
<script type="application/ld+json">$jsonLd</script>''',
      extraCss: _css,
      body:
          '''
<header style="background-image:url('${esc(coverPath(shop))}')">
  <a class="mark brand" href="/">treat.</a>
</header>
<main>
  <h1>${esc(shop.name)}</h1>
  <p class="sub">${esc(shop.category.name[0].toUpperCase() + shop.category.name.substring(1))} · ${esc(shop.district)}</p>
  <p class="score">${rating.count == 0 ? esc(score) : '${stars(rating.average.round())} <b>${rating.average.toStringAsFixed(1)}</b> · ${rating.count} verified student visit${rating.count == 1 ? '' : 's'}'}</p>
  ${shop.bio.isEmpty ? '' : '<p>${esc(shop.bio)}</p>'}
  <a class="cta" href="${esc(appLink)}">Get a free treat here</a>
  ${offers.isEmpty ? '' : '<h2>Treats</h2><ul class="offers">${offers.map((o) => '<li>${esc(o.title)}</li>').join()}</ul>'}
  <h2>What students say</h2>
  ${reviews.isEmpty ? '<p class="muted">No ratings yet.</p>' : reviews.map((r) => '''
  <div class="review">
    <div><b>${esc(r.studentName)}</b> ${stars(r.rating)}</div>
    <div class="muted">Verified visit · free treat · ${esc(r.offerTitle)}</div>
    ${r.review == null ? '' : '<p>${esc(r.review)}</p>'}
  </div>''').join()}
  <p class="foot muted">Ratings come only from students the place actually scanned in. Every one of them got a free treat, and their rating never affected it.</p>
</main>''',
    );
    return Response.ok(body: Body.fromString(html, mimeType: MimeType.html));
  }
}

const _css = '''
  header { height:220px; background-size:cover; background-position:center;
           position:relative; }
  header::after { content:""; position:absolute; inset:0;
                  background:linear-gradient(180deg,rgba(0,0,0,.25),rgba(0,0,0,0) 60%); }
  .brand { position:absolute; z-index:1; top:16px; left:20px; color:#fff;
           text-decoration:none; font-size:28px; }
  main { max-width:640px; margin:0 auto; padding:20px 20px 48px; }
  h1 { font-size:30px; margin:8px 0 2px; }
  h2 { font-size:13px; text-transform:uppercase; letter-spacing:.08em;
       color:var(--ink2); margin:28px 0 8px; }
  .sub, .muted { color:var(--ink2); }
  .sub { margin:0 0 10px; }
  .score { font-size:17px; margin:0 0 12px; }
  .stars { color:var(--star); letter-spacing:1px; }
  .stars .off { color:#E6DCCD; }
  .cta { display:inline-block; background:var(--accent); color:#fff; text-decoration:none;
         font-weight:800; padding:12px 20px; border-radius:12px; margin:6px 0 4px; }
  .offers { padding-left:20px; margin:0; }
  .offers li { margin:4px 0; }
  .review { background:var(--card); border:1px solid var(--border); border-radius:12px;
            padding:12px 14px; margin:8px 0; }
  .review p { margin:6px 0 0; }
  .foot { font-size:13px; margin-top:24px; }
''';

String stars(int n) =>
    '<span class="stars">${'★' * n}<span class="off">${'★' * (5 - n)}</span></span>';
