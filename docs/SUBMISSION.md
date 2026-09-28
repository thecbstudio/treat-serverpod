# Submission kit

Everything needed for the BuilderBase form. Fill the `TODO`s on submission day.

---

## 1. Title & tagline

**treat. — free treats for students, real local reach for small businesses, verified by AI**

## 2. Description (what it does)

treat is a barter marketplace between university students and the small businesses around campus. A café, barber or gaming lounge offers something small for free — a coffee, a haircut, an hour of console. A student claims it, shows a QR code at the counter, and in return posts about the place on Instagram, Google Reviews or TikTok. They upload a screenshot, and Claude checks it within seconds: approved → the treat counts toward the student's streak, badges and the leaderboard; rejected → a clear reason and one appeal.

Businesses get word-of-mouth from real local customers instead of paid ads, with a live panel that shows every claim, scan, post and verdict as it happens, plus an estimate of the reach they earned. Students get free things for doing what they already do.

One user, one problem, one flow: *show QR → get scanned → post → get approved*, live on both phones.

## 3. How it's built

- **Flutter web** client (phone-first; one link for judges), **Serverpod 4** backend, deployed on **Serverpod Cloud** (server, Postgres, file storage, e-mail).
- **All rules on the server, in transactions:** eligibility (verification, strikes, once-a-week per place, active hours in Europe/Istanbul, daily/total caps) is computed from the claims table — no counters to drift — and claiming locks the student and offer rows so double taps and races can't beat a cap. Redeem is idempotent.
- **Streams + server events:** `claim.watch` and `shop.watchFeed` push state over WebSockets; changes are posted to `claim:<id>` / `shop:<id>` channels, with a periodic DB re-check so a missed message never leaves a screen wrong.
- **Future calls:** `ExpireClaimCall` expires unused QR codes at their deadline (cancelled on redeem); `VerifyProofCall` runs the AI check in the background with retries and backoff — a technical failure never costs the student a strike.
- **File uploads:** proof screenshots go to private cloud storage via upload descriptions; the server chooses the path and validates the file; businesses get short-lived links.
- **Auth:** Serverpod's e-mail identity provider; `.edu` addresses are verified automatically.
- **AI:** Claude via the Anthropic Messages API; the verdict is forced through a tool call (structured JSON, no text parsing).
- **Tests:** 68 `serverpod_test` tests (rules, claim/redeem/expiry, live streams, proof verification with a fake AI, strikes & appeals).

## 4. AI disclosure

Built with Claude Code (Anthropic) as a pair programmer: it wrote most of the code under my direction; I made the product and scope decisions, tested every flow on real devices and reviewed the changes. At runtime the app uses Claude (Anthropic API) to verify proof screenshots.

## 5. Prior-work disclosure

The idea was explored earlier as a React/Firebase prototype. This submission is a new implementation written from scratch during the hackathon in Flutter + Serverpod; no code was reused (design tokens, copy and category photos were). *(Adjust after BuilderBase's answer to our rules e-mail.)*

## 6. Links & access

- Live app: https://treat-app.serverpod.space  `TODO confirm after deploy`
- Repository: https://github.com/thecbstudio/treat-serverpod (private — shared with viktor@serverpod.dev, alexander@serverpod.dev, isak@serverpod.dev) `TODO share`
- Video: `TODO YouTube/Vimeo link`
- Demo logins (password: `TODO prod demo password`):
  - Student: `student@demo.treat`
  - Business: `pixel@demo.treat` (Pixel Oyun Kafe, open 13:00–23:00 Istanbul), `kirlangic@demo.treat` (09:00–18:00)
- Test tip: open the student in one browser and the business in another (or incognito). Claim → type the 6-character code on the business's **Scan** tab → upload a screenshot on the student side → watch both screens.

## 7. Build & run

See README → "Run it locally" (`cp config/passwords.example.yaml config/passwords.yaml && serverpod start`).

---

# Video script (< 2:00)

Setup: **phone** = student (browser, logged in as `student@demo.treat`), **laptop** = business panel (`pixel@demo.treat`). Record the laptop screen + film the phone, or screen-record both and cut side by side. Do it during Pixel's open hours (13:00–23:00). Prepare a real Instagram story screenshot that tags the place.

| Time | Shot | Voice-over / caption |
|---|---|---|
| 0:00–0:10 | Welcome screen on the phone | "Students want free stuff. Small businesses want real local reach. treat trades one for the other." |
| 0:10–0:25 | Discover → open "1 hour of console" → rules card | "Every offer has rules — once a week per place, opening hours, daily slots. The server checks them for you, live." |
| 0:25–0:35 | Tap **Claim treat** → QR + code + countdown | "Claim it, and you get a QR code valid for two hours." |
| 0:35–0:55 | Laptop: **Scan** → type the code → green "Valid". Cut to the phone: it flipped to **Redeemed** on its own | "At the counter the business scans it — and the student's screen updates instantly. Serverpod streams." |
| 0:55–1:20 | Phone: pick the story screenshot → Submit → **Under review** → **Approved** | "Post about the place, upload a screenshot, and Claude checks that it really tags the business." |
| 1:20–1:35 | Laptop **Panel**: feed row turning Approved, reach / value card, open the proof | "The business sees every claim, scan and verified post in real time, and the reach it earned." |
| 1:35–1:50 | Phone: profile (treats, streak, badges) → leaderboard | "Students build streaks and badges; fake posts get a strike, and there's one fair appeal." |
| 1:50–2:00 | Logo / link | "treat — built with Flutter and Serverpod 4 on Serverpod Cloud." |

---

# Hackathon post (Best Hackathon Post)

> Built **treat** for the #Serverpod hackathon: students claim free treats from local cafés and shops, post about them, and Claude verifies the post — while the student's phone and the business's panel update live over Serverpod streams. Future calls expire QR codes and run the AI checks in the background; all eligibility rules run server-side in locked transactions. Flutter web + Serverpod 4 + Serverpod Cloud. 🎥 `TODO video link`

# Feedback form

Use `FEEDBACK.md` (7 concrete issues with suggested fixes) — paste the top items into the Most Valuable Feedback form.
