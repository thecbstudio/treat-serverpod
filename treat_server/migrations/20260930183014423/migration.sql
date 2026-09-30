BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "claim" ADD COLUMN "reviewHidden" boolean NOT NULL DEFAULT false;
ALTER TABLE "claim" ADD COLUMN "wallHidden" boolean NOT NULL DEFAULT false;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "report" (
    "id" bigserial PRIMARY KEY,
    "reporterId" uuid NOT NULL,
    "kind" text NOT NULL,
    "targetId" bigint NOT NULL,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "report_target_idx" ON "report" USING btree ("kind", "targetId");
CREATE UNIQUE INDEX "report_once_idx" ON "report" USING btree ("reporterId", "kind", "targetId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "report"
    ADD CONSTRAINT "report_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR treat
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('treat', '20260930183014423', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260930183014423', "timestamp" = now();

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
