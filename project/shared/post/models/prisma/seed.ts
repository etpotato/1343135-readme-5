import { PostStatus, PostType, PrismaClient } from '@prisma/client';

const FIRST_TAG_UUID = '6d308040-96a2-4162-bea6-2338e9976540';
const SECOND_TAG_UUID = 'ab04593b-da99-4fe3-8b4b-e06d82e2efdd';

const FIRST_COMMENT_UUID = '3aeacb8d-d16e-46b9-b729-ac720fea5bca';
const SECOND_COMMENT_UUID = 'de18abfc-0699-459a-af29-89e118865f1d';

const FIRST_POST_UUID = '39614113-7ad5-45b6-8093-06455437e1e2';
const SECOND_POST_UUID = 'efd775e2-df55-4e0e-a308-58249f5ea202';

const FIRST_USER_ID = '658170cbb954e9f5b905ccf4';
const SECOND_USER_ID = '6581762309c030b503e30512';
const THIRD_USER_ID = '65a83188357a6cee330e0640';
const FOURTH_USER_ID = '65a8319360f51f6270a8f02b';

async function seedDb(prismaClient: PrismaClient) {
  await prismaClient.tag.createMany({
    data:[{
      id: FIRST_TAG_UUID,
      text: 'sky'
    },
    {
      id: SECOND_TAG_UUID,
      text: 'city'
    }]
  })

  await prismaClient.post.createMany({
    data: [
      {
        id: FIRST_POST_UUID,
        author: FIRST_USER_ID,
        status: PostStatus.published,
        isRepost: false,
        type: PostType.link,
      }, {
        id: SECOND_POST_UUID,
        author: SECOND_USER_ID,
        status: PostStatus.published,
        isRepost: false,
        type: PostType.video,
      }
    ]
  })

  await prismaClient.postsTags.createMany({
    data: [{
      postId: FIRST_POST_UUID,
      tagId: FIRST_TAG_UUID,
    },
    {
      postId: SECOND_POST_UUID,
      tagId: SECOND_TAG_UUID,
    }]
  })

  await prismaClient.comment.createMany({
    data: [{
      id: FIRST_COMMENT_UUID,
      text: 'Great!',
      postId: FIRST_POST_UUID,
      authorId: THIRD_USER_ID,
    }, {
      id: SECOND_COMMENT_UUID,
      text: 'Wow',
      postId: SECOND_POST_UUID,
      authorId: FOURTH_USER_ID,
    }]
  })

  await prismaClient.like.createMany({
    data: [{
      postId: FIRST_POST_UUID,
      userId: SECOND_USER_ID,
    }, {
      postId: FIRST_POST_UUID,
      userId: THIRD_USER_ID,
    }, {
      postId: SECOND_POST_UUID,
      userId: FIRST_USER_ID,
    }, {
      postId: SECOND_POST_UUID,
      userId: FOURTH_USER_ID,
    },]
  })
}

async function bootstrap() {
  const prismaClient = new PrismaClient();

  console.log('start')
  try {
    await seedDb(prismaClient);
    console.log('success')
    globalThis.process.exit(0);
  } catch (error: unknown) {
    console.error(error);
    globalThis.process.exit(1);
  } finally {
    await prismaClient.$disconnect();
  }
}

bootstrap();
