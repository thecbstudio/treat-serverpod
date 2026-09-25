# Serverpod 4 notes (verified during M0, 26 Sep 2026)

Sources: the agent skills installed by `serverpod create` (`.claude/skills/serverpod-*`, generated for 4.0.2) and https://docs.serverpod.dev. Re-check the skill before coding each area.

## Project layout (from `serverpod create treat --database --auth --webapp --no-redis --ide claude`)
- `treat_server/` — endpoints, models (`*.spy.yaml`), `config/*.yaml`, `migrations/`. `lib/server.dart` = bootstrap.
- `treat_client/` — generated, never edit.
- `treat_flutter/` — app; launched by `serverpod start` via `lib/driver.dart` (Flutter driver enabled for agent testing).
- Dart workspace (`resolution: workspace`) at repo root.
- Dev ports: API 8080, Insights 8081, web server 8082, embedded Postgres 8090 (test: 9090). Flutter dev app gets a random port.

## Dev loop
- `serverpod start` (from `treat_server`) = codegen watch + server hot reload + embedded Postgres + migrations applied on boot + Flutter web app. Verified working on Windows (26 Sep).
- Agent talks to the running stack via the `serverpod` MCP (`.mcp.json`, socket at `treat_server/.dart_tool/serverpod/mcp.sock`): `create_migration`, `apply_migrations`, `tail_server_logs`, `tail_flutter_logs`, `hot_restart`, `spawn_flutter_app`, `get_flutter_app_dtd`.
- Tests: `dart test` in `treat_server` — starts its own embedded Postgres (`config/test.yaml` has `dataPath`). From the Claude app set `SERVERPOD_PG_CACHE_DIR` first (see AGENTS.md / FEEDBACK #4).

## Auth (`serverpod_auth_idp_server` 4.0.2) — already wired
- `pod.initializeAuthServices(tokenManagerBuilders: [JwtConfigFromPasswords()], identityProviderBuilders: [ServerpodCloudEmailIdpConfig(appDisplayName: 'treat')])`.
- **Email verification:** dev → code logged to console; staging/prod → sent by the **Serverpod Cloud email service**, no config. ⇒ real sign-up works in prod; seed demo accounts are still needed for the jury.
- Server: import `package:serverpod_auth_idp_server/core.dart` (not the root library). `session.authenticated?.authUserId` (UuidValue). `requireLogin => true`, `requiredScopes`.
- Our own profile tables link to the auth user: `authUser: module:serverpod_auth_core:AuthUser?, relation(onDelete=Cascade)` + unique index on `authUserId`.
- Role (student/shop): our own tables (StudentProfile / Shop). Custom `Scope`s possible via `AuthServices.instance.authUsers.update(scopes: ...)` — decide in M1.
- Flutter: `SignInWidget(client: client, onAuthenticated:, onError:)` (brings its own Material surface — we will likely wrap/restyle); `client.auth.isAuthenticated`, `client.auth.authInfoListenable`, `signOutDevice()`.

## Streams (live updates)
- Endpoint method returning `Stream<T>` → WebSocket-managed client stub. Session lives until stream completes/cancelled. Throwing a serializable exception closes the stream → client `onError`.
- Fan-out with server events: `session.messages.postMessage(channel, model)` + `session.messages.createStream<T>(channel)`.
- ⚠ Without Redis, messages are **local to one server instance**. If Cloud runs >1 instance, a redeem on instance A won't reach a `watchClaim` stream on instance B. **Plan:** `watchClaim` yields the current DB row first, then merges message events with a slow DB re-check (e.g. every 5 s) so correctness never depends on delivery. Check Cloud instance count / Redis guide (https://docs.serverpod.dev/cloud/guides/redis) in M2.
- Channel naming: `claim:<id>`, `shop:<shopId>`.

## Future calls (scheduling)
- `class ExpireClaimCall extends FutureCall { Future<void> expire(Session s, int claimId) }` → generated `pod.futureCalls.callAtTime(t, identifier: 'expire-$id').<name>.expire(id)`; `callWithDelay`; `cancel(identifier)`. Stored in DB, survive restarts, claimed once across the cluster.
- Must be idempotent; handle failure inside and reschedule (→ VerifyProof retry/backoff).
- Config: `futureCallExecutionEnabled`, `futureCall.concurrencyLimit` (default 1 — raise to ~5 so AI verification doesn't block expiries), `scanInterval` (default 5000 ms; lower in dev/test).
- Runs on monolith/maintenance roles, not serverless role.

## File uploads (proof screenshots)
- Flow: server `session.storage.createUploadDescription(storageId:, path:)` → client `FileUploader(desc).upload(byteData)` → server `session.storage.verifyUpload(...)`. Path derived on the server (`proofs/<claimId>/<n>.jpg`), never from the client.
- Storage already wired in `server.dart`: `ServerpodCloudProvider.private/public(fallback: DatabaseCloudStorage(...))` → Cloud object storage in prod, DB storage in dev. Proofs go to **private**; the verifier reads with `retrieveFile`, the shop dashboard gets `temporaryDownloadUrl`.
- Alternative for small images: `ByteData` endpoint parameter — but `maxRequestSize` is 512 KB by default. Decision: **use upload descriptions**; client downsizes to ~1280 px JPEG.

## Database
- ORM: `Model.db.find/findFirstRow/insertRow/updateRow`, `session.db.transaction((tx) async {...})` (pass `transaction: tx` everywhere), row locks via `lockMode` + `transaction` (use for redeem idempotency).
- After model changes: `create_migration` (+ `apply_migrations`) via MCP; `serverpod start` applies pending migrations on boot.

## Web hosting / Serverpod Cloud
- `server.dart` serves the built Flutter web app from `treat_server/web/app` at `/` (`FlutterRoute`), and serves `/assets/assets/config.json` with the API URL for the app.
- `pubspec.yaml` script `flutter_build` builds the web app into `web/app` (Windows variant uses xcopy). `serverpod cloud launch` sets up pre-deploy scripts.
- Cloud commands (run by Çınar): `serverpod cloud auth login` (browser) → `serverpod cloud launch` (create project + first deploy; asks for passwords from `production`/`shared`) → later `serverpod cloud deploy`. Secrets: `serverpod cloud password set`.
- URLs: web `https://<project-id>.serverpod.space/`, API `https://<project-id>.api.serverpod.space/`, Insights `https://<project-id>.insights.serverpod.space/`.
- Sign-up: https://console.serverpod.cloud/auth/signup. Plans/credits: not in docs → hackathon resources/Discord.

## Open questions for later milestones
- M2: Cloud instance count / whether to connect Redis for global messages.
- M2: `mobile_scanner` on Flutter web (needs HTTPS in prod; localhost is OK in dev).
- M3: Anthropic model ID — verify in Anthropic docs when writing `proof_verifier.dart`.
