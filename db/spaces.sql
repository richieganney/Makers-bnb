-- -------------------------------------------------------------
-- TablePlus 2.7(246)
--
-- https://tableplus.com/
--
-- Database: makers_bnb_test
-- Generation Time: 2019-07-29 16:21:18.4290
-- -------------------------------------------------------------


-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS spaces_id_seq;

-- Table Definition
CREATE TABLE "public"."spaces" (
    "space_id" int4 NOT NULL DEFAULT nextval('spaces_id_seq'::regclass),
    "address" varchar,
    "title" varchar,
    "description" varchar,
    "price_per_night" float4,
    "owner" int4,
    CONSTRAINT "spaces_owner_fkey" FOREIGN KEY ("owner") REFERENCES "public"."users"("user_id"),
    PRIMARY KEY ("space_id")
);

INSERT INTO "public"."spaces" ("space_id", "address", "title", "description", "price_per_night", "owner") VALUES ('7', '123 fake street', 'title', 'description', '100', '6');
