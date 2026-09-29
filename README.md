# treat.

**Students get free treats from local places. Places get real, local social-media reach. An AI checks the posts.**

A student grabs an offer ("medium filter coffee"), shows a QR code at the counter, the business scans it, the student posts an Instagram story / post, Google review or TikTok about the place and uploads a screenshot. Claude verifies the screenshot in the background and the treat is approved — or rejected with a reason and one appeal. Every step shows up **live** on both the student's phone and the business's panel.

Built for **Build Something Real: The Serverpod Hackathon** with **Flutter (web) + Serverpod 4**.

> **Live app:** https://treat-app.serverpod.space *(being deployed on Serverpod Cloud)*
> **Judging?** Tap **Student** / **Business** under *"Judging? Try it in one tap"* on the welcome screen — no sign-up, no real post needed. Details: [Demo accounts](#demo-accounts).

---

## The loop

| Student | Business |
|---|---|
| Browses **Discover** (search, categories). The server tells them per offer whether they can claim right now and why not (hours, daily cap, once-a-week rule, strikes…). | Creates offers: what, how often per student, active hours, daily/total caps, which posts it accepts. |
| **Claims** → gets a QR + 6-character backup code, valid for 2 hours, with a countdown. | **Scans** the QR with the camera (or types the code). Double scans count once. |
| The QR screen flips to **Redeemed** the instant the shop scans — no refresh. | The **Panel** feed lights up live: claims, redeems, proofs, verdicts. |
| Uploads a screenshot of the post → **Under review** → **Approved (+1 treat)** or **Rejected** (reason + one appeal). | Sees the proof screenshots, totals and an estimated reach / marketing value. |
| Profile: treats, week streak, badges, strikes. Leaderboard (name + university only). | |

## How Serverpod is used

| Feature | Where |
|---|---|
| **Endpoints + generated client** | `profile`, `offer`, `shopOffers`, `claim`, `shop`, `leaderboard` — all rules and authorization run on the server. |
| **Models + ORM + migrations** | `student_profile`, `shop`, `offer`, `claim` tables (`lib/src/models/*.spy.yaml`), relations to the auth user, indexes, includes. |
| **Transactions + row locks** | Claiming locks the student and the offer (`LockMode.forUpdate`) so double taps and concurrent students can't beat caps or the frequency rule. Redeem is idempotent inside a locked transaction. |
| **Streams (WebSockets)** | `claim.watch(id)` pushes the student's claim state; `shop.watchFeed()` pushes the business panel. |
| **Server events** | `session.messages` channels `claim:<id>` / `shop:<id>` fan changes out to open streams; `watch` also re-checks the DB every 5 s so a missed message (e.g. multiple instances without Redis) only delays an update. |
| **Future calls** | `ExpireClaimCall` fires at `expiresAt` (cancelled on redeem). `VerifyProofCall` runs the AI check right after submit, retries with backoff, and never punishes the student for an API failure. On Serverpod Cloud's Starter plan (future calls off) verification runs in-process and resumes after a restart; expiry needs no job because the rules treat a claim past its TTL as expired. |
| **File uploads / cloud storage** | Proof screenshots go to **private** storage through upload descriptions; the server picks the path, checks type/size by magic bytes, and gives the business short-lived download links. |
| **Authentication** | Serverpod email identity provider (sign-up, verification code, login) + our own student / business profiles. `.edu` e-mails are verified automatically. Demo mode adds a one-tap sign-in that creates a guest and issues its token server-side (`AuthServices.instance.tokenManager.issueToken`). |
| **Testing** | `serverpod_test` (`withServerpod`): 92 tests — rules, claim/redeem/expiry, live streams, proof verification with a fake AI, strikes and appeals, drops, demo sign-in. |
| **Serverpod Cloud** | Hosting of server + Flutter web app, Postgres, storage and e-mail. |

### Rules worth knowing (`treat_server/lib/src/domain/rules.dart`)
- Eligibility order: offer inactive → not verified → 3 strikes → active claim → once-a-week/month at this place → active hours → total cap → daily cap.
- Caps and frequency are **computed from the claims table** (no counters), so an expired claim gives its slot back automatically.
- All business time is **Europe/Istanbul** (active hours, "today" for caps, Monday-based streak weeks).
- A claim costs at most **one strike**; a won appeal gives it back; a lost appeal adds none.

### AI verification (`treat_server/lib/src/ai/proof_verifier.dart`)
Claude (Anthropic Messages API, called with `package:http`) gets the screenshot plus the business name, its Instagram handle, the offer and the requested post type. The answer is **forced through a tool call** (`report_verdict`), so there is no free-text parsing. Reasons: `no_mention`, `not_a_post`, `unreadable`.

## Run it locally

Requirements: Flutter 3.44+ / Dart 3.12+, Serverpod CLI 4.0.2 (`dart pub global activate serverpod_cli 4.0.2`), Chrome. **No Docker needed** — Serverpod 4 runs an embedded PostgreSQL.

```bash
git clone https://github.com/thecbstudio/treat-serverpod.git
cd treat-serverpod/treat_server
cp config/passwords.example.yaml config/passwords.yaml   # add your Anthropic key
serverpod start          # server + DB + migrations + demo seed + Flutter web app
```

`serverpod start` prints the app URL. Locally no e-mail is sent: the sign-up verification code is printed in the server console (`Registration code for …`). On Serverpod Cloud the code arrives by e-mail. Tests: `cd treat_server && dart test`.

> Windows note: the first start downloads PostgreSQL (~2 min, no progress bar). If you run it from an MSIX-packaged app, set `SERVERPOD_PG_CACHE_DIR` to a folder outside `%LOCALAPPDATA%` (see `FEEDBACK.md` #4).

## Demo accounts

Created automatically on server start when `demoAccountPassword` is set (local password: `treat-demo-2026`; the production password is in the submission form).

| Role | E-mail |
|---|---|
| Student (verified) | `student@demo.treat` |
| Business — Pixel Oyun Kafe (open 13:00–23:00) | `pixel@demo.treat` |
| Business — Kırlangıç Kahve | `kirlangic@demo.treat` |
| Other businesses | `tostcu@`, `duman@`, `form@`, `yirmi7@demo.treat` |

**Fastest way to try it (two browser windows, e.g. normal + incognito):**
1. Window A: welcome screen → **Student** (one tap; every tap creates a fresh, verified guest student, so judges never block each other).
2. Window B: welcome screen → **Business** (the shared demo place, Pixel Oyun Kafe, which always has a live drop).
3. A: open the live drop → **Claim treat** → note the 6-character code. B: **Scan** → type the code. A flips to *Redeemed* by itself.
4. A: no real post needed — under *Demo: no post handy?* send the sample story that **tags nobody** → Claude rejects it (strike 1/3). Appeal with the sample that **tags the place** → Claude approves and the strike is returned. B's **Panel** updates live.

The samples are ready-made story screenshots stored on the server; they go through exactly the same upload → storage → Claude path as a real one. They only exist for demo accounts, and demo sign-in only exists while the server runs in demo mode (`demoAccountPassword` set).

## Project layout

```
treat_server/   Serverpod server: endpoints, models, rules, AI verifier, future calls, tests
treat_client/   generated client (do not edit)
treat_flutter/  Flutter web app: go_router, ARB localization, one theme
FEEDBACK.md     Serverpod 4 friction points found while building (with suggestions)
```

## Honest notes

- **Prior prototype:** the idea was tried before as a React/Firebase prototype. This is a new implementation written from scratch during the hackathon in Flutter + Serverpod; no code was copied (design tokens, copy and category photos were reused).
- **AI use:** built with Claude Code (Anthropic) as a pair programmer; all product decisions, testing and review by the author. At runtime the app uses Claude to verify proof screenshots.
- **Photos:** place cover photos are from [Unsplash](https://unsplash.com) under the Unsplash License — [bowling](https://unsplash.com/photos/YxiW_hx3lyA), [toastie](https://unsplash.com/photos/ZB8NK8cB4EE), [simit](https://unsplash.com/photos/8PV0DwdS4nU), [bookshop](https://unsplash.com/photos/ju_8CFxk6_o), [ice cream](https://unsplash.com/photos/3D0HUHFcRrk), [manicure](https://unsplash.com/photos/gb6gtiTZKB8). The demo "story" screenshots are mock-ups made from these photos for the seed data.
- Camera scanning on the web uses the browser's barcode detector (Chrome on Android); the typed 6-character code always works as a fallback.
