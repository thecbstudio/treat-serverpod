BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "gift" (
    "id" bigserial PRIMARY KEY,
    "senderId" bigint,
    "recipientId" bigint,
    "shopId" bigint,
    "senderName" text NOT NULL,
    "recipientName" text NOT NULL,
    "shopName" text NOT NULL,
    "amountTl" bigint NOT NULL,
    "commissionKurus" bigint NOT NULL,
    "netKurus" bigint NOT NULL,
    "message" text,
    "status" text NOT NULL,
    "code" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "paidAt" timestamp without time zone,
    "expiresAt" timestamp without time zone,
    "redeemedAt" timestamp without time zone,
    "closedAt" timestamp without time zone,
    "conversationId" text,
    "paymentToken" text,
    "paymentId" text,
    "paymentTransactionId" text,
    "refundedAt" timestamp without time zone,
    "refundAttempts" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE INDEX "gift_sender_idx" ON "gift" USING btree ("senderId");
CREATE INDEX "gift_recipient_idx" ON "gift" USING btree ("recipientId");
CREATE INDEX "gift_shop_status_idx" ON "gift" USING btree ("shopId", "status");
CREATE INDEX "gift_token_idx" ON "gift" USING btree ("paymentToken");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "gift"
    ADD CONSTRAINT "gift_fk_0"
    FOREIGN KEY("senderId")
    REFERENCES "student_profile"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "gift"
    ADD CONSTRAINT "gift_fk_1"
    FOREIGN KEY("recipientId")
    REFERENCES "student_profile"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "gift"
    ADD CONSTRAINT "gift_fk_2"
    FOREIGN KEY("shopId")
    REFERENCES "shop"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR treat
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('treat', '20261004191707945', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261004191707945', "timestamp" = now();

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
