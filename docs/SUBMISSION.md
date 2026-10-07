# Submission kit

Everything needed for the BuilderBase form. Fill the `TODO`s on submission day (13 Oct; the deadline is 14 Oct 23:59 CEST). The demo video must be **under 2 minutes** (YouTube or Vimeo).

---

## 1. Title & tagline

**treat. — free treats for students, verified local reach for small businesses**

## 2. Description (what it does)

treat is a marketplace between university students and the small businesses around campus. A café, barber or gaming lounge offers something small for free — a coffee, a haircut, an hour of console. A student claims it, shows a QR code at the counter, and in return posts about the place on Instagram or TikTok, tagged and disclosed as an ad (#işbirliği). They upload a screenshot and Claude checks it within seconds: approved → the treat counts toward their streak, badges and the leaderboard; rejected → a clear reason and one appeal.

What businesses get: word-of-mouth from real local customers instead of paid ads, a live panel with every claim, scan, post and verdict as it happens, a **verified in-app treat score** from students the place actually scanned in, a public page, and a printable counter card whose QR asks *every* customer for a Google review (Google forbids rewarding reviews, so treat never does). Students can also **gift** a paid treat to a friend: card payment on iyzico, QR at the counter, 15 % commission, real refunds.

One loop, live on both phones: *claim → show QR → get scanned → post → get verified* — and, as a second loop, *pay → friend shows QR → place scans*.

## 3. How it's built

- **Flutter web** client (phone-first, wide layout on desktop), **Serverpod 4** backend on **Serverpod Cloud** (server, Postgres, private file storage, e-mail).
- **All rules on the server, in transactions:** eligibility (verification, strikes, once-a-week per place, active hours in Europe/Istanbul, caps) is computed from the claims table, and claiming locks the student and offer rows so double taps and races can't beat a cap. Redeem is idempotent; a gift can be redeemed or cancelled, never both.
- **Streams + server events:** `claim.watch` and `shop.watchFeed` push state over WebSockets, with a periodic DB re-check so a missed message never leaves a screen wrong.
- **Future calls:** `ExpireClaimCall` expires unused QR codes, `VerifyProofCall` / `VerifyIdentityCall` run the AI checks in the background with retries. On the Starter plan (future calls off) the same work runs in-process and resumes after a restart. A timer expires old gifts and retries refunds.
- **Web server (Relic):** server-rendered public place pages (`/p/:id`, link previews + schema.org), the printable counter card with server-drawn QR codes, `/privacy`, `/terms`, and the iyzico payment callback (`POST /pay/iyzico/:id`).
- **File uploads:** screenshots, student cards and documents go to private storage via upload descriptions; the server picks the path and validates the file. Card and document photos are deleted as soon as the AI has decided.
- **Payments:** iyzico hosted checkout (card data never touches treat), signed IYZWSv2 requests, results fetched server-to-server and checked for amount and conversation id, refunds retried until they succeed. Tested against the real iyzico **sandbox**.
- **Auth:** Serverpod's e-mail identity provider; `.edu` verified automatically, everyone else sends a student card that Claude checks. Account deletion removes everything personal and refunds open gifts.
- **AI:** Claude via the Anthropic Messages API, every verdict forced through a tool call (structured, no text parsing); text inside photos is treated as data, never as instructions.
- **Tests:** 190 `serverpod_test` tests plus gateway unit tests; CI (analyze, format, tests) is green.

## 4. AI disclosure

Built with Claude Code (Anthropic) as a pair programmer: it wrote most of the code under my direction; I made the product and scope decisions and reviewed the changes. At runtime the app uses Claude (Anthropic API) to verify proof screenshots, student cards and business documents.

## 5. Prior-work disclosure

The idea was explored earlier as a React/Firebase prototype, used only as a feature reference. This submission is a new implementation written from scratch during the hackathon in Flutter + Serverpod (first commit 26 Sep 2026); no code was reused (design tokens, copy and category photos were). *(Adjust after BuilderBase's answer to our Help Desk question.)*

## 6. Honest limits

- AI checks can't prove authenticity (a determined person can fake a screenshot, card or document); the README explains what we do about it.
- Paying gift money out to places is not automated (the panel shows what is owed, net of 15 %); production would use iyzico marketplace sub-merchants. Payments run in the iyzico sandbox.
- Instagram/TikTok accounts are not connected; web only; English UI.

## 7. Links & access

- Live app (optional; BuilderBase only requires demo video, repo and description): `TODO https://<project>.serverpod.space if deployed`
- Repository: https://github.com/thecbstudio/treat-serverpod (private — share with viktor@serverpod.dev, alexander@serverpod.dev, isak@serverpod.dev) `TODO share`
- Video: `TODO YouTube/Vimeo link`
- No sign-up needed. On the welcome screen use **Student**, **Business** and **Try the student-card check** (one tap each). Demo logins (password `TODO production.demoAccountPassword from passwords.yaml`): `student@demo.treat`, `pixel@demo.treat` (Pixel Oyun Kafe), `kirlangic@demo.treat`.
- Test card for the gift payment (iyzico sandbox): `5528 7900 0000 0008`, any future date, CVC `123`.
- Step-by-step: README → "Demo accounts" (claim → scan → post → verdict, gifting alone in one window, student-card check).

## 8. Build & run

See README → "Run it locally" (`cp config/passwords.example.yaml config/passwords.yaml` and add the Anthropic key, plus the iyzico sandbox keys for gifting, then `serverpod start`).

---

# Video script (< 2:00, aim for 1:50)

Step-by-step recording guide (setup, tools, click path, subtitles, checklist): `docs/VIDEO_PLAN.md`.

Setup: **phone** (or a narrow browser window) = student, **laptop** = business panel, both from the one-tap demo buttons on the live link. Record both and cut side by side. Have the iyzico test card ready.

| Time | Shot | Voice-over / caption |
|---|---|---|
| 0:00–0:10 | Welcome screen | "Students want free stuff. Small businesses want real local reach. treat trades one for the other — and proves it happened." |
| 0:10–0:25 | Student: open the live drop → **Claim treat** → QR + code | "Claim a treat, get a QR code. The server checks the rules — once a week, opening hours, stock — inside a locked transaction." |
| 0:25–0:40 | Business: **Scan** → code. Cut to the student: flips to **Redeemed** by itself | "The place scans it and the student's phone updates instantly — Serverpod streams over WebSockets." |
| 0:40–1:00 | Student: demo sample *tags the place, no #işbirliği* → Claude rejects *no disclosure*; appeal with the compliant sample → **Approved** | "Claude reads the screenshot: tagged the place, disclosed as an ad as Turkish rules require. One fair appeal." |
| 1:00–1:25 | Student: **Gifts** → pay on iyzico's page (sandbox card) → gift with QR. Business: scan → **Gift handed over**; Panel shows 17 TL after the 15 % | "Students can also gift a paid treat. Real card checkout on iyzico, the server verifies the payment itself, and a cancel is a real refund." |
| 1:25–1:40 | Business: treat score + reviews, **Reputation kit**, public page `/p/…` and the counter card | "Places earn a verified treat score and a public page — and a counter card that asks every customer for a Google review, never tied to a treat." |
| 1:40–1:52 | Quick cut: student-card check approved; README "190 tests" / CI green | "No .edu e-mail? Claude checks the student card, then deletes the photo. Endpoints, streams, future calls, storage, auth, Relic pages, migrations — all Serverpod 4." |
| 1:52–1:58 | Logo / link | "treat. — Flutter + Serverpod 4 on Serverpod Cloud." |

---

# Hackathon post (Best Hackathon Post)

> Built **treat.** for the #Serverpod hackathon: students claim free treats from local cafés, post about them, and Claude verifies the post — while the student's phone and the business's panel update live over Serverpod streams. Future calls expire QR codes and run the AI checks; friends can gift a paid treat through iyzico with real refunds; all rules run server-side in locked transactions. Flutter web + Serverpod 4 + Serverpod Cloud, 190 tests. 🎥 `TODO video link`

# Feedback form

Use `FEEDBACK.md` (13 concrete issues with suggested fixes) — paste the top items into the Most Valuable Feedback form.
