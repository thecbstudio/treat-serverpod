# TREAT — Flutter + Serverpod (hackathon build)

TREAT: students claim free treats from local shops (coffee, food, dessert, beauty, fitness, activity) in exchange for a social-media proof (IG story/post, Google review, TikTok). Shop scans the student's QR / 6-char code → student posts proof → AI verifies → +1 treat.

Built for "Build Something Real: The Serverpod Hackathon". **Deadline 14 Oct 2026 23:59 CEST, we submit on 13 Oct.** Full plan: `C:\Users\cinar\.claude\plans\evet-nas-l-devam-ed-yoruz-stateless-peach.md`.

## Hard rules
- Written from scratch during the hackathon. The old React/Firebase prototype at `C:\Users\cinar\Downloads\treat` is **spec/reference only — read it, never copy code**. Re-implement logic in Dart. Design tokens, copy text and category photos may be reused.
- UI language: **English** (ARB i18n from day one; TR later). Talk to Çınar in Turkish.
- Scope (changed 30 Sep 2026 by Çınar): parity with the original prototype's feature table (gifting with 15 % commission via the **real iyzico sandbox**, discounts + shop subscription, settings, AI student/shop verification, notifications, TR). **NO** donations/askıda, **NO** chat, **NO** mock payments. Read `docs/HANDOFF.md` first. Further scope changes only with Çınar's approval.
- Stop at the end of every milestone (M0…M5), report, wait for approval.
- All authorization and business rules live on the server, inside transactions. Never swallow errors — every screen has error + retry states.
- Time zone for business rules: **Europe/Istanbul** (active hours, daily cap day, Monday-based streak weeks).
- Never print or commit API keys. `config/passwords.yaml` is git-ignored; Çınar pastes the Anthropic key in person.
- Deploys (`serverpod cloud launch`) and pushes that trigger deploys are run by Çınar — give Çınar PowerShell commands.
- Every Serverpod 4 friction point goes into `FEEDBACK.md` (Most Valuable Feedback prize).
- Serverpod 4 is newer than the model's training data: check `.claude/skills/serverpod-*` and https://docs.serverpod.dev before coding each area. Notes in `docs/serverpod-notes.md`.

## Windows / environment notes
- Windows 11, PowerShell 5.1 (no `&&`; use `;`). Git Bash also available. Use absolute paths.
- If the session doesn't see the tools on PATH: `$env:Path += ";C:\Users\cinar\flutter\bin;C:\Users\cinar\AppData\Local\Pub\Cache\bin"`.
- **Claude desktop app runs as an MSIX package** → writes to `%LOCALAPPDATA%` are virtualized, which breaks the embedded Postgres process-identity check (tests fail with "Another process is using the local database"). Always set `$env:SERVERPOD_PG_CACHE_DIR="C:\Users\cinar\dev\.pg-cache"` before `dart test` / `serverpod` commands run from Claude.
- An orphaned embedded Postgres can be stopped cleanly with: `& "C:\Users\cinar\dev\.pg-cache\16.13.0-r1\windows-x64\bin\pg_ctl.exe" stop -D <server>\.serverpod\<mode>\pgdata -m fast`.

## Generic Flutter & Serverpod guidance (from the template)

This project is a Flutter app (frontend) backed by a Serverpod server (backend). Always build the app's backend with Serverpod.
Build for multiple users, use Serverpod's built-in authentication, which is already set up in `lib/server.dart`.

The user starts the server and Flutter app with `serverpod start`. There is no need to check if the server is running: make the changes and call the `serverpod` MCP tools as needed. If the server is not running, an informative error message will be received from the MCP server. Then STOP and ask the user to start it. NEVER start the server yourself. The Flutter app is started along with it, or can be launched from the MCP tool `spawn_flutter_app`.

While running, `serverpod start` watches for file changes to run incremental code generation and hot reload both the server and the Flutter app.

Calling `serverpod generate` directly is not needed, but might be useful to troubleshoot when an incremental generation fails.

ALWAYS use the MCP server instead of the command line. Use the MCP server to:

- `create_migration` and `apply_migrations` for database (after you change data models).
- `create_repair_migration` if the database has drifted out of sync with the migrations.
- `tail_server_logs` to read logs from the server.
- `tail_flutter_logs` to read the raw stdout/stderr of the Flutter app.
- `hot_reload` / `hot_restart` to reload or restart the server and the Flutter app. ALWAYS call `hot_restart` after doing changes in the Flutter app that may not work with normal hot reload (which is automatically applied).
- `spawn_flutter_app` to start a Flutter app declared under `serverpod: flutter_apps:` in the server `pubspec.yaml`.
- `get_flutter_app_dtd` (Dart tooling daemon) for connecting to the app through the `dart` MCP.

NEVER edit generated code. The server's `lib/src/generated/` directory and the whole `treat_client` package are rewritten by the code generator. Change the `.spy.yaml` models, the endpoints, or `lib/server.dart` instead.

Migrations are a narrow exception: the `migration.sql` of a generated migration MAY be edited by hand when the generated SQL would lose data — to add a data transformation, or to reach a destructive change through non-destructive steps. Never touch the other files in the migration directory, and keep the schema the SQL ends up with identical to `definition.sql` — new databases are created from that file and never run `migration.sql`.

Only when the server cannot be started at all, fall back to the CLI in the server package:

- `serverpod generate` to regenerate the client and the generated server code.
- `serverpod create-migration` after changing a model with a `table` (add `--force` for destructive changes). It only writes the migration; `serverpod start` applies pending migrations when it boots the server.

Tests need no Docker. `config/test.yaml` sets `database.dataPath`, so Serverpod starts and manages the test database (an embedded PostgreSQL) itself, and the project's `docker-compose.yaml` is not used for it. Just run `dart test` in the server package.

Checklist after doing changes, in this order:

- `dart analyze` (CLI)
- `dart format` (CLI)
- `create_migration` and `apply_migrations` (MCP - only if necessary)
- Do `serverpod` MCP `hot_restart` if required (hot reload is done automatically). Will also hot restart Flutter app
- Run tests, if applicable (`dart test` in the server package)
- Check `serverpod` MCP `tail_server_logs` and `tail_flutter_logs` for any issues.

If the user asks you to test the app:

1. Use `get_flutter_app_dtd` (`serverpod` MCP) to get the Flutter app's DTD
2. Pass the DTD to `connect_dart_tooling_daemon` (`dart` MCP) to connect to the app
3. Use `flutter_driver` (`dart` MCP) to navigate through the app

The app is launched from `treat_flutter/lib/driver.dart`, which starts the Flutter driver extension with text entry emulation turned off so the app stays usable by hand. To let the driver type, set `enableTextEntryEmulation: true` there and `hot_restart` the app.

IMPORTANT: After building the first version of the app, update this AGENTS.md file with information about the app we're building. KEEP the info about the MCP server and the checklist. Remove this paragraph.
