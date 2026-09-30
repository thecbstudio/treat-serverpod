BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "identity_check" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "kind" text NOT NULL,
    "imagePath" text,
    "status" text NOT NULL,
    "reason" text,
    "attempts" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "decidedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "identity_check_user_idx" ON "identity_check" USING btree ("authUserId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "identity_check"
    ADD CONSTRAINT "identity_check_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR treat
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('treat', '20260930185937647', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260930185937647', "timestamp" = now();

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
