BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "claim" (
    "id" bigserial PRIMARY KEY,
    "offerId" bigint NOT NULL,
    "shopId" bigint NOT NULL,
    "studentId" bigint NOT NULL,
    "studentName" text NOT NULL,
    "frequency" text NOT NULL,
    "code" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone NOT NULL,
    "redeemedAt" timestamp without time zone,
    "proofType" text,
    "proofPath" text,
    "proofSubmittedAt" timestamp without time zone,
    "decidedAt" timestamp without time zone,
    "verdictReason" text,
    "appealed" boolean NOT NULL DEFAULT false,
    "verifyAttempts" bigint NOT NULL DEFAULT 0,
    "strikeGiven" boolean NOT NULL DEFAULT false
);

-- Indexes
CREATE INDEX "claim_student_idx" ON "claim" USING btree ("studentId");
CREATE INDEX "claim_shop_status_idx" ON "claim" USING btree ("shopId", "status");
CREATE INDEX "claim_shop_code_idx" ON "claim" USING btree ("shopId", "code");
CREATE INDEX "claim_offer_idx" ON "claim" USING btree ("offerId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "offer" (
    "id" bigserial PRIMARY KEY,
    "shopId" bigint NOT NULL,
    "seedKey" text,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "category" text NOT NULL,
    "frequency" text NOT NULL,
    "activeStartMin" bigint NOT NULL,
    "activeEndMin" bigint NOT NULL,
    "dailyCap" bigint,
    "totalCap" bigint,
    "status" text NOT NULL DEFAULT 'active'::text,
    "featured" boolean NOT NULL DEFAULT false,
    "proofTypes" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "offer_shop_idx" ON "offer" USING btree ("shopId");
CREATE INDEX "offer_status_idx" ON "offer" USING btree ("status");
CREATE UNIQUE INDEX "offer_seed_key_idx" ON "offer" USING btree ("seedKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "shop" (
    "id" bigserial PRIMARY KEY,
    "ownerId" uuid,
    "seedKey" text,
    "name" text NOT NULL,
    "category" text NOT NULL,
    "district" text NOT NULL,
    "address" text NOT NULL,
    "bio" text NOT NULL,
    "instagramHandle" text,
    "verified" boolean NOT NULL DEFAULT false,
    "totalRedeems" bigint NOT NULL DEFAULT 0,
    "approvedProofs" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "shop_owner_idx" ON "shop" USING btree ("ownerId");
CREATE UNIQUE INDEX "shop_seed_key_idx" ON "shop" USING btree ("seedKey");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "student_profile" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "name" text NOT NULL,
    "email" text NOT NULL,
    "university" text NOT NULL,
    "verification" text NOT NULL,
    "strikes" bigint NOT NULL DEFAULT 0,
    "treats" bigint NOT NULL DEFAULT 0,
    "categoriesTried" json NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "student_profile_auth_user_idx" ON "student_profile" USING btree ("authUserId");
CREATE INDEX "student_profile_treats_idx" ON "student_profile" USING btree ("treats");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "claim"
    ADD CONSTRAINT "claim_fk_0"
    FOREIGN KEY("offerId")
    REFERENCES "offer"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "claim"
    ADD CONSTRAINT "claim_fk_1"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "claim"
    ADD CONSTRAINT "claim_fk_2"
    FOREIGN KEY("studentId")
    REFERENCES "student_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "offer"
    ADD CONSTRAINT "offer_fk_0"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "shop"
    ADD CONSTRAINT "shop_fk_0"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "student_profile"
    ADD CONSTRAINT "student_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR treat
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('treat', '20260925213945692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260925213945692', "timestamp" = now();

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
