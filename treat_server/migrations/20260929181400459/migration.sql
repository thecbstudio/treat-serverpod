BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "claim" ADD COLUMN "rating" bigint;
ALTER TABLE "claim" ADD COLUMN "review" text;
ALTER TABLE "claim" ADD COLUMN "privateNote" text;
ALTER TABLE "claim" ADD COLUMN "ratedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR treat
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('treat', '20260929181400459', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260929181400459', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;
