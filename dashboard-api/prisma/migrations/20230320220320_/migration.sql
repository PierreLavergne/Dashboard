/*
  Warnings:

  - Made the column `data` on table `Widget` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Widget" ALTER COLUMN "data" SET NOT NULL,
ALTER COLUMN "data" SET DEFAULT '{}';
