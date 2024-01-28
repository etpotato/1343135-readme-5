import { PrismaClientService } from '@project/shared/post/models';
import { DefaultPojoType, Entity, EntityIdType } from "./entity.type";
import { Repository } from "./repository.interface";

export abstract class BasePostgresRepository<
  EntityType extends Entity<EntityIdType, DocumentType>,
  DocumentType = DefaultPojoType
> implements Repository<EntityType, DocumentType> {
  constructor(
    protected readonly client: PrismaClientService,
    private readonly createEntity: (document: DocumentType) => EntityType,
  ) {}

  protected createEntityFromDocument(document: DocumentType): EntityType | null {
    if (!document) {
      return null;
    }

    return this.createEntity(document);
  }

  findById(id: EntityType["id"]): Promise<EntityType | null> {
    throw new Error("Method not implemented.");
  }
  save(entity: EntityType): Promise<EntityType> {
    throw new Error("Method not implemented.");
  }
  update(id: EntityType["id"], entity: EntityType): Promise<EntityType> {
    throw new Error("Method not implemented.");
  }
  deleteById(id: EntityType["id"]): Promise<void> {
    throw new Error("Method not implemented.");
  }
}
