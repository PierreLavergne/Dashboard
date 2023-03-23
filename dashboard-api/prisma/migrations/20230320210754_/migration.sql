/*
  Warnings:

  - Added the required column `description` to the `Widget` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "WidgetName" AS ENUM ('WEATHER_TEMP', 'FOOTBALL_RES');

-- AlterTable
ALTER TABLE "Widget" ADD COLUMN     "description" "WidgetName" NOT NULL,
ALTER COLUMN "data" DROP NOT NULL;
