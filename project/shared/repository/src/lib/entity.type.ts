export type DefaultPojoType = Record<string, unknown>;
export type EntityIdType = string;

export type Entity<T extends EntityIdType, PojoType = DefaultPojoType> = {
  id?: T;
  toPOJO: () => PojoType;
};
