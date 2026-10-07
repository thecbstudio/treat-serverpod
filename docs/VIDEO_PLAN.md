# Video plan (hard limit: under 2:00 — aim for 1:50)

BuilderBase wants a demo video (YouTube or Vimeo). Judges watch it before they try anything, so it is the most important deliverable after the repo. The script and voice-over are also in `docs/SUBMISSION.md`; this file is the recording guide.

## What makes it good (not "impressive effects")

- **Show the real thing working, live, on two screens.** The strongest moment is the student's screen changing by itself when the business scans (Serverpod streams). Keep both windows visible side by side for it.
- **One story, in order:** claim → scan → post verified by Claude → gift with a real card payment → reputation. Then one sentence about the stack.
- **No intro animation, no music needed.** Start on the product in the first 3 seconds. If you add music, use royalty-free only.
- **Subtitles on.** Many judges watch muted. Burn them in (CapCut / Clipchamp) or upload an `.srt` (YouTube → Subtitles).
- **Voice:** your own voice in simple English is fine; read slowly, one take per scene. Or generate a voice-over with a TTS tool, but keep the subtitles.

## Setup (10 minutes)

1. Fresh start: `serverpod start --no-flutter` is enough once `web/app` is built (`serverpod run flutter_build`), then open `http://localhost:8082` (or the deployed link).
2. Chrome, 1920×1080 screen, **two windows side by side**: left a **narrow** window (~430 px wide, looks like a phone) for the student, right a normal window for the business. Hide the bookmarks bar, close other tabs, use Do Not Disturb.
3. Recorder: **OBS Studio** (free, record the whole screen at 1080p/30) or Windows **Win+Alt+R** (Xbox Game Bar). Record **each scene as its own clip**; you will cut the waiting.
4. Editor: **Clipchamp** (built into Windows) or **CapCut**. Export 1080p MP4, upload to YouTube as *Unlisted*, check the duration shows **under 2:00**.
5. Have the iyzico sandbox card ready: `5528 7900 0000 0008`, `12/30`, CVC `123`.

## Scenes (click path + voice-over)

| # | Time | What to do on screen | Voice-over |
|---|---|---|---|
| 1 | 0:00–0:08 | Welcome screen (desktop window), then tap **Student** in the left window and **Business** in the right window. | "Students want free stuff. Small businesses want real local reach. treat trades one for the other — and proves it happened." |
| 2 | 0:08–0:22 | Left: Discover → open **Switch Mario Kart slot** (the live drop) → **Claim treat** → QR + 6-character code. | "Claim a treat and get a QR code. The server checks the rules — once a week, opening hours, stock — inside a locked transaction." |
| 3 | 0:22–0:36 | Right: **Scan** → type the code → **Verify code**. Keep the camera on the left window: it flips to **Redeemed** by itself. | "The place scans it — and the student's phone updates instantly. Serverpod streams over WebSockets." |
| 4 | 0:36–0:58 | Left, on the claim: **Demo: no post handy?** → send the sample **without #işbirliği** → *no disclosure* (cut the wait) → appeal with the compliant sample → **Approved**. Right: Panel feed updates. | "Claude reads the screenshot: tagged the place, and disclosed as an ad, as Turkish rules require. One fair appeal." |
| 5 | 0:58–1:22 | Left: **Gifts → Send a gift** → *Demo: use my own e-mail* → Pixel Oyun Kafe, 20 TL → **Pay** → iyzico page: type the test card (cut the typing) → back in treat, the gift shows a QR. Right: **Scan** → type the gift code → **Gift handed over**; open **Panel**: the gifts card shows 17 TL after the 15 %. | "Students can also gift a paid treat. Real card checkout on iyzico, the server verifies the payment itself, and a cancel is a real refund." |
| 6 | 1:22–1:36 | Right: **Business** tab → *Reputation kit* → **Open page** (the public page `/p/…`) → **Print card**. Quick look at the treat score on the Panel. | "Places earn a verified treat score, a public page, and a counter card that asks every customer for a Google review — never tied to a treat." |
| 7 | 1:36–1:48 | Welcome screen → **Try the student-card check** → *Use the sample card* → verified. Cut to the GitHub README (CI green, "190 tests"). | "No .edu e-mail? Claude checks the student card and deletes the photo. Endpoints, streams, future calls, storage, auth, Relic pages, migrations: all Serverpod 4." |
| 8 | 1:48–1:55 | End card: logo + repo / live link text. | "treat. — Flutter and Serverpod 4." |

Word count of the voice-over: about 230 words, i.e. ~1:35 at a calm pace; the rest is silence while things happen on screen.

## Subtitles

Copy the voice-over lines into the editor's auto-captions or write an `.srt` with the scene start times above. Keep each subtitle under two lines.

## Before you upload (checklist)

- [ ] Duration under 2:00 (check the YouTube page, not just the editor).
- [ ] No API keys or `passwords.yaml` visible; no personal e-mails (the demo ones are fine).
- [ ] The iyzico page is shown only with the sandbox test card.
- [ ] The video title: `treat. — free treats for students, verified by AI (Serverpod hackathon)`.
- [ ] Link and repo access added to the BuilderBase form.
