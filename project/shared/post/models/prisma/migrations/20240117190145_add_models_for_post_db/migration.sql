/*
  Warnings:

  - You are about to drop the column `postId` on the `link_contents` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `photo_contents` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `quote_contents` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `text_contents` table. All the data in the column will be lost.
  - You are about to drop the column `postId` on the `video_contents` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[post_id]` on the table `link_contents` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[post_id]` on the table `photo_contents` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[post_id]` on the table `quote_contents` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[post_id]` on the table `text_contents` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[post_id]` on the table `video_contents` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `post_id` to the `link_contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `post_id` to the `photo_contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `post_id` to the `quote_contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `post_id` to the `text_contents` table without a default value. This is not possible if the table is not empty.
  - Added the required column `post_id` to the `video_contents` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "link_contents" DROP CONSTRAINT "link_contents_postId_fkey";

-- DropForeignKey
ALTER TABLE "photo_contents" DROP CONSTRAINT "photo_contents_postId_fkey";

-- DropForeignKey
ALTER TABLE "quote_contents" DROP CONSTRAINT "quote_contents_postId_fkey";

-- DropForeignKey
ALTER TABLE "text_contents" DROP CONSTRAINT "text_contents_postId_fkey";

-- DropForeignKey
ALTER TABLE "video_contents" DROP CONSTRAINT "video_contents_postId_fkey";

-- DropIndex
DROP INDEX "link_contents_postId_key";

-- DropIndex
DROP INDEX "photo_contents_postId_key";

-- DropIndex
DROP INDEX "quote_contents_postId_key";

-- DropIndex
DROP INDEX "text_contents_postId_key";

-- DropIndex
DROP INDEX "video_contents_postId_key";

-- AlterTable
ALTER TABLE "link_contents" DROP COLUMN "postId",
ADD COLUMN     "post_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "photo_contents" DROP COLUMN "postId",
ADD COLUMN     "post_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "posts" ADD COLUMN     "original_author" TEXT;

-- AlterTable
ALTER TABLE "quote_contents" DROP COLUMN "postId",
ADD COLUMN     "post_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "text_contents" DROP COLUMN "postId",
ADD COLUMN     "post_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "video_contents" DROP COLUMN "postId",
ADD COLUMN     "post_id" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "tags" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "likes" (
    "post_id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "likes_pkey" PRIMARY KEY ("post_id","user_id")
);

-- CreateTable
CREATE TABLE "comments" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "author_id" TEXT NOT NULL,
    "post_id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "comments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PostToTag" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "tags_text_key" ON "tags"("text");

-- CreateIndex
CREATE INDEX "comments_post_id_idx" ON "comments"("post_id");

-- CreateIndex
CREATE UNIQUE INDEX "_PostToTag_AB_unique" ON "_PostToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_PostToTag_B_index" ON "_PostToTag"("B");

-- CreateIndex
CREATE UNIQUE INDEX "link_contents_post_id_key" ON "link_contents"("post_id");

-- CreateIndex
CREATE UNIQUE INDEX "photo_contents_post_id_key" ON "photo_contents"("post_id");

-- CreateIndex
CREATE UNIQUE INDEX "quote_contents_post_id_key" ON "quote_contents"("post_id");

-- CreateIndex
CREATE UNIQUE INDEX "text_contents_post_id_key" ON "text_contents"("post_id");

-- CreateIndex
CREATE UNIQUE INDEX "video_contents_post_id_key" ON "video_contents"("post_id");

-- AddForeignKey
ALTER TABLE "likes" ADD CONSTRAINT "likes_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "comments" ADD CONSTRAINT "comments_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "video_contents" ADD CONSTRAINT "video_contents_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "text_contents" ADD CONSTRAINT "text_contents_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "quote_contents" ADD CONSTRAINT "quote_contents_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "photo_contents" ADD CONSTRAINT "photo_contents_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "link_contents" ADD CONSTRAINT "link_contents_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PostToTag" ADD CONSTRAINT "_PostToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;
