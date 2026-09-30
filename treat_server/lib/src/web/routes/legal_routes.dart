import 'package:serverpod/serverpod.dart';

import '../html.dart';

/// Where people reach us about their data. Shown on both pages.
const contactEmail = 'CONTACT_EMAIL_TBD';

const _updated = '30 September 2026';

/// GET /privacy — privacy notice (KVKK "aydınlatma metni" + GDPR).
class PrivacyRoute extends Route {
  @override
  Future<Result> handleCall(Session session, Request request) async =>
      _legalPage('Privacy notice', _privacy);
}

/// GET /terms — terms of use.
class TermsRoute extends Route {
  @override
  Future<Result> handleCall(Session session, Request request) async =>
      _legalPage('Terms of use', _terms);
}

Response _legalPage(String title, String body) => Response.ok(
  body: Body.fromString(
    page(
      title: '$title · treat.',
      head: '<meta name="robots" content="index,follow">',
      extraCss: _css,
      body:
          '''
<main>
  <a class="mark brand" href="/">treat.</a>
  <h1>$title</h1>
  <p class="muted">Last updated $_updated</p>
  $body
  <p class="foot muted"><a href="/privacy">Privacy notice</a> · <a href="/terms">Terms of use</a> · <a href="mailto:$contactEmail">$contactEmail</a></p>
</main>''',
    ),
    mimeType: MimeType.html,
  ),
);

const _privacy =
    '''
<p>treat. connects university students with local places: a place gives a
student a free treat, and the student posts about the visit on social media.
This notice explains which personal data we process, why, and what you can do
about it. It is our information notice under the Turkish Personal Data
Protection Law No. 6698 (KVKK) and follows the EU GDPR.</p>

<h2>Who is responsible</h2>
<p>The treat team is the data controller. Reach us at
<a href="mailto:$contactEmail">$contactEmail</a> for anything in this notice.</p>

<h2>What we process</h2>
<ul>
  <li><b>Account:</b> your e-mail address, password (stored only as a hash),
  and whether you are a student or a business.</li>
  <li><b>Students:</b> name, university, verification status, the treats you
  claimed and their times, the screenshots of your posts, links to permanent
  posts, the AI's verdicts, strikes, ratings, reviews and private notes to a
  place, thank-you notes, and which posts you chose to show publicly.</li>
  <li><b>Businesses:</b> the place's name, category, district, address,
  description, Instagram handle, Google review link, and its offers.</li>
  <li><b>Reports</b> you send about content, and technical logs (IP address,
  device and request data) needed to run and secure the service.</li>
</ul>

<h2>Why, and on which legal basis</h2>
<ul>
  <li><b>To run the service you signed up for</b> (KVKK art. 5/2-c, GDPR art.
  6/1-b): accounts, claiming and redeeming treats, checking that the post you
  promised was made, ratings, public place and student pages.</li>
  <li><b>Legitimate interest</b> (KVKK art. 5/2-f, GDPR art. 6/1-f): preventing
  fake posts and abuse (strikes, reports, re-checking that permanent posts are
  still online), security logs.</li>
  <li><b>Legal obligations</b> (KVKK art. 5/2-ç): records we must keep by law.</li>
</ul>

<h2>How your post is verified</h2>
<p>When you upload a screenshot, it is sent to <b>Anthropic</b> (Claude), an AI
provider acting as our processor, together with the place's name and handle.
Claude checks that the post tags the place and is disclosed as an ad
(#işbirliği). Anthropic does not use this data to train its models. For TikTok
links we ask TikTok's public oEmbed service whether the video is still online.
No decision about you is made by the AI alone that you cannot contest: every
rejection can be appealed once.</p>

<h2>Who sees what</h2>
<ul>
  <li>The place you visited sees your name, university, your screenshot, the
  link to your post, your rating, review and private note.</li>
  <li>Everyone using treat sees your name, university, treat count and badges,
  your ratings and reviews, and the posts you chose to show on the wall.</li>
  <li>Your e-mail address is never shown to anyone.</li>
</ul>

<h2>Where it is stored, and transfers abroad</h2>
<p>treat runs on <b>Serverpod Cloud</b> (database, file storage, e-mail).
Serverpod Cloud and Anthropic may process data on servers outside Türkiye,
including the United States. Transfers abroad are made under KVKK art. 9 and
GDPR chapter V safeguards.</p>

<h2>How long we keep it</h2>
<p>We keep your data while your account exists. When you delete your account
we delete your profile, your claims, ratings, reviews, notes, reports and
screenshots right away. A place's aggregate counters (for example "students
treated") keep their number but no personal data. Server logs are kept only as
long as needed for security and are then deleted.</p>

<h2>Your rights</h2>
<p>Under KVKK art. 11 and the GDPR you can ask whether we process your data,
get a copy, have it corrected or deleted, object to processing, learn who
receives it, and claim compensation for unlawful processing. You can edit your
profile and <b>delete your account at any time in the app</b> (Profile →
Settings, or Business profile for places). For anything else, write to
<a href="mailto:$contactEmail">$contactEmail</a>; we answer within 30 days. You
can also complain to the Turkish Personal Data Protection Authority (KVKK) or
your EU data protection authority.</p>

<h2>Cookies</h2>
<p>The app stores your sign-in token in your browser's local storage so you
stay signed in. We use no advertising or tracking cookies.</p>

<h2>Changes</h2>
<p>We will update this notice when the service changes and show the date at the
top. treat is a young product built during a hackathon; if anything here is
unclear, ask us.</p>
''';

const _terms =
    '''
<p>These terms apply to everyone using treat. By creating an account you agree
to them and to our <a href="/privacy">privacy notice</a>.</p>

<h2>What treat is</h2>
<p>Places offer free treats to university students. A student claims an offer,
the place scans the student's code, the student posts about the visit and
uploads a screenshot, and an AI checks the post. treat does not sell, cook or
serve anything: every treat is given by the place, which is responsible for it
(including allergens and food safety).</p>

<h2>Accounts</h2>
<ul>
  <li>You must be at least 18 and give true information. One account per
  person or place.</li>
  <li>Students must be enrolled at a university. Keep your password to
  yourself; you are responsible for what happens in your account.</li>
</ul>

<h2>Students: posting honestly</h2>
<ul>
  <li>Post what the offer asks for, tag the place, and mark it as an ad
  (<b>#işbirliği</b>, #reklam or the platform's paid-partnership label). Turkish
  advertising rules require this disclosure for anything you got for free.</li>
  <li>Post about your real visit, from your own public account. Edited, borrowed
  or close-friends-only screenshots, or deleting a post soon after it was
  approved, are not allowed.</li>
  <li>A rejected post can be appealed once. Unfair behaviour earns strikes; with
  too many strikes you can't claim treats any more.</li>
  <li>Your rating never affects your treat. Rate the visit honestly.</li>
</ul>

<h2>Places</h2>
<ul>
  <li>Give the treat you advertise to every eligible student you scan in, as
  described in the offer.</li>
  <li>Don't ask students for positive reviews or ratings, and don't reward
  Google reviews: treat only rewards clearly disclosed social posts.</li>
  <li>Keep your place's information accurate.</li>
</ul>

<h2>Content</h2>
<p>You keep the rights to what you post. By uploading a screenshot, rating,
review or note you let treat show it to the people described in the privacy
notice, and, for posts you choose to share on the wall, on the place's public
page. Don't upload anything illegal, hateful, sexual, violent, or that shows
other people without their consent. Anyone can report a review, wall post or
place; reported content may be hidden and accounts that break these terms may
be suspended or deleted.</p>

<h2>Deleting your account</h2>
<p>You can delete your account at any time in the app. It removes your data as
described in the privacy notice.</p>

<h2>No warranty</h2>
<p>treat is provided as is, without guarantees that it is always available or
error-free, and that the AI is always right. To the extent the law allows, we
are not liable for indirect damages or for what places or other users do.</p>

<h2>Changes and law</h2>
<p>We may change these terms and will show the date at the top; continuing to
use treat means you accept the new version. Turkish law applies.</p>
<p>Questions: <a href="mailto:$contactEmail">$contactEmail</a>.</p>
''';

const _css = '''
  main { max-width:720px; margin:0 auto; padding:28px 20px 56px; line-height:1.6; }
  .brand { color:var(--accent); text-decoration:none; font-size:28px; }
  h1 { margin:24px 0 4px; font-size:30px; }
  h2 { margin-top:28px; font-size:19px; }
  li { margin:6px 0; }
  .muted { color:var(--ink2); }
  .foot { margin-top:40px; border-top:1px solid var(--border); padding-top:16px;
          font-size:14px; }
''';
