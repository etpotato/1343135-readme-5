/*
  Warnings:

  - You are about to drop the column `content` on the `posts` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "posts" DROP COLUMN "content";

-- CreateTable
CREATE TABLE "video_contents" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "url" TEXT NOT NULL,

    CONSTRAINT "video_contents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "text_contents" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "text" TEXT NOT NULL,

    CONSTRAINT "text_contents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quote_contents" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "quote_author" TEXT NOT NULL,

    CONSTRAINT "quote_contents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "photo_contents" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "photo_contents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "link_contents" (
    "id" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "link_contents_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "video_contents_postId_key" ON "video_contents"("postId");

-- CreateIndex
CREATE UNIQUE INDEX "text_contents_postId_key" ON "text_contents"("postId");

-- CreateIndex
CREATE UNIQUE INDEX "quote_contents_postId_key" ON "quote_contents"("postId");

-- CreateIndex
CREATE UNIQUE INDEX "photo_contents_postId_key" ON "photo_contents"("postId");

-- CreateIndex
CREATE UNIQUE INDEX "link_contents_postId_key" ON "link_contents"("postId");

-- AddForeignKey
ALTER TABLE "video_contents" ADD CONSTRAINT "video_contents_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "text_contents" ADD CONSTRAINT "text_contents_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "quote_contents" ADD CONSTRAINT "quote_contents_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "photo_contents" ADD CONSTRAINT "photo_contents_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "link_contents" ADD CONSTRAINT "link_contents_postId_fkey" FOREIGN KEY ("postId") REFERENCES "posts"("id") ON DELETE CASCADE ON UPDATE CASCADE;
