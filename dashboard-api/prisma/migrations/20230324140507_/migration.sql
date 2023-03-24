/*
  Warnings:

  - The values [WEATHER] on the enum `ServiceName` will be removed. If these variants are still used in the database, this will fail.
  - The values [FOOTBALL_RES] on the enum `WidgetName` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ServiceName_new" AS ENUM ('SPOTIFY');
ALTER TABLE "Service" ALTER COLUMN "name" TYPE "ServiceName_new" USING ("name"::text::"ServiceName_new");
ALTER TYPE "ServiceName" RENAME TO "ServiceName_old";
ALTER TYPE "ServiceName_new" RENAME TO "ServiceName";
DROP TYPE "ServiceName_old";
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "WidgetName_new" AS ENUM ('WEATHER_TEMP', 'SPOTIFY_LAST_PLAYED_TRACK');
ALTER TABLE "Widget" ALTER COLUMN "description" TYPE "WidgetName_new" USING ("description"::text::"WidgetName_new");
ALTER TYPE "WidgetName" RENAME TO "WidgetName_old";
ALTER TYPE "WidgetName_new" RENAME TO "WidgetName";
DROP TYPE "WidgetName_old";
COMMIT;
