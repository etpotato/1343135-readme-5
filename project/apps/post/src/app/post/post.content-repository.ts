import { Injectable } from "@nestjs/common";
import { Entity, MemoryRepository } from "@project/shared/repository";
import {
  PostContent,
  PostLinkContent,
  PostPhotoContent,
  PostQuoteContent,
  PostTextContent,
  PostType,
  PostTypeValue,
  PostVideoContent,
} from "@project/shared/types";


class PostVideoContentRepository extends MemoryRepository<Entity<string, PostVideoContent>> {}
class PostTextContentRepository extends MemoryRepository<Entity<string, PostTextContent>> {}
class PostQuoteContentRepository extends MemoryRepository<Entity<string, PostQuoteContent>> {}
class PostPhotoContentRepository extends MemoryRepository<Entity<string, PostPhotoContent>> {}
class PostLinkContentRepository extends MemoryRepository<Entity<string, PostLinkContent>> {}

@Injectable()
export class PostContentRepositoryFactory {
  private readonly postVideoContentRepository: InstanceType<typeof PostVideoContentRepository>;
  private readonly postTextContentRepository: InstanceType<typeof PostTextContentRepository>;
  private readonly postQuoteContentRepository: InstanceType<typeof PostQuoteContentRepository>;
  private readonly postPhotoContentRepository: InstanceType<typeof PostPhotoContentRepository>;
  private readonly postLinkContentRepository: InstanceType<typeof PostLinkContentRepository>;

  constructor() {
    this.postVideoContentRepository = new PostVideoContentRepository();
    this.postTextContentRepository = new PostTextContentRepository();
    this.postQuoteContentRepository = new PostQuoteContentRepository();
    this.postPhotoContentRepository = new PostPhotoContentRepository();
    this.postLinkContentRepository = new PostLinkContentRepository();
  }

  public create(type: PostTypeValue)
    : MemoryRepository<Entity<string, PostContent>>  {
    switch (type) {
      case PostType.Video:
        return this.postVideoContentRepository;
      case PostType.Text:
        return this.postTextContentRepository;
      case PostType.Quote:
        return this.postQuoteContentRepository;
      case PostType.Photo:
        return this.postPhotoContentRepository;
      case PostType.Link:
        return this.postLinkContentRepository;
      default:
        throw new Error('Unknown post type');
    }
  }
}
