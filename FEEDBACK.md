# Serverpod 4 feedback log

Friction points hit while building TREAT, written down as they happen. Each entry: what happened, impact, suggested fix.
Environment: Windows 11 Home (26200), Flutter 3.47.5, Dart 3.13.4, serverpod_cli 4.0.2.

## 1. `serverpod create`: `flutter create .` step fails, project reported as created anyway
- **What:** `serverpod create treat --ide claude ...` printed `ERROR: Failed to run 'flutter create .' in ...\treat_flutter` and `Updating Flutter app MacOS entitlements... failed`, then carried on and exited with code 1. Running `flutter create .` by hand in `treat_flutter` afterwards worked fine.
- **Impact:** Confusing first-run experience; unclear whether the project is usable.
- **Suggestion:** Print the underlying `flutter create` stderr, and end with a clear "project created, but run `flutter create .` in X to finish" hint instead of a bare exit code 1.

## 2. First embedded-Postgres download is silent and races the 2-minute test timeout
- **What:** On a fresh machine the first `dart test` failed with `Serverpod did not start within the timeout of 0:02:00 ... cannot connect to the database`. The real cause: the PostgreSQL bundle was being downloaded (≈2 min) with no progress output. `serverpod -v database start` also showed nothing between `Found server directory` and `Embedded PostgreSQL is ready`.
- **Impact:** Misleading error that points at DB connectivity; developer starts debugging the wrong thing.
- **Suggestion:** Show download progress (the `onProgress` callback already exists in `BinaryStore.ensure`), and exclude the one-time binary fetch from the test startup timeout, or print "downloading PostgreSQL (one-time)…" in the test runner.

## 3. Timed-out test run leaves an orphaned Postgres that blocks all later runs
- **What:** After the timeout above, the test-mode postmaster kept running. Every following `dart test` failed with `Another process is using the local database`. Fix was `pg_ctl stop -D .serverpod/test/pgdata -m fast`.
- **Impact:** Hard to recover without reading package source.
- **Suggestion:** Include the exact `pg_ctl stop` command (with resolved paths) in the error message, or add `serverpod database stop [-m test]` (only `start` exists today).

## 4. Embedded Postgres breaks when the tool is launched from an MSIX-packaged app (Windows)
- **What:** When `dart test` runs from a process inside an MSIX container (e.g. the Claude desktop app, likely also other Store-packaged terminals/IDEs), writes to `%LOCALAPPDATA%` are virtualized to `%LOCALAPPDATA%\Packages\<pkg>\LocalCache\...`. The recorded postmaster executable path and the path returned by `QueryFullProcessImageName` then differ, `verifyIdentity()` returns "not ours", `attach()` fails, and the harness reports `Another process is using the local database` — even though Serverpod started that postmaster itself seconds earlier.
- **Workaround:** `SERVERPOD_PG_CACHE_DIR=C:\some\non-appdata\path` (found by reading `binary_store.dart`; not documented).
- **Suggestion:** Normalize both paths with `GetFinalPathNameByHandle`/resolve virtualized paths before comparing, or fall back to comparing file identity (volume serial + file index). Document `SERVERPOD_PG_CACHE_DIR`.

## 5. `default=` is rejected on `List` fields
- **What:** `categoriesTried: List<OfferCategory>, default=[]` fails generation with `The "default" key is not supported for "List" types`.
- **Impact:** Every constructor call has to pass an empty list by hand.
- **Suggestion:** Support `default=[]` (empty collection) for `List`/`Set`/`Map`, at least as `defaultModel`.

## 6. Parallel integration test files time out on the shared embedded Postgres
- **What:** With 4 test files using `withServerpod`, `dart test` (default concurrency) made two files fail in `setUpAll` after 2 minutes ("Serverpod did not start within the timeout"). Each file passes on its own.
- **Workaround:** `concurrency: 1` in `dart_test.yaml`.
- **Suggestion:** Serialize embedded-Postgres startup across test isolates (the launch lock exists but startup still races/times out), or generate `dart_test.yaml` with a safe default and document it.

## 7. `serverpod create` ships GitHub Actions workflows
- **What:** The generated `.github/workflows/*.yml` make the first `git push` fail for anyone whose GitHub token lacks the `workflow` scope (common for `gh` default logins / fine-grained tokens), and rewriting history to drop them is awkward.
- **Suggestion:** Ask before adding CI workflows, or mention the `workflow` scope requirement in the create output.
