import {inject, Getter} from '@loopback/core';
import {
  DefaultCrudRepository,
  repository,
  BelongsToAccessor,
  HasManyRepositoryFactory,
} from '@loopback/repository';
import {PostgresDataSource} from '../datasources';
import {Meter, MeterRelations, MeterType, Value} from '../models';
import {MeterTypeRepository} from './meter-type.repository';
import {ValueRepository} from './value.repository';

export class MeterRepository extends DefaultCrudRepository<
  Meter,
  typeof Meter.prototype.id,
  MeterRelations
> {
  public readonly meterType: BelongsToAccessor<
    MeterType,
    typeof Meter.prototype.id
  >;

  public readonly values: HasManyRepositoryFactory<
    Value,
    typeof Meter.prototype.id
  >;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
    @repository.getter('MeterTypeRepository')
    protected meterTypeRepositoryGetter: Getter<MeterTypeRepository>,
    @repository.getter('ValueRepository')
    protected valueRepositoryGetter: Getter<ValueRepository>,
  ) {
    super(Meter, dataSource);
    this.values = this.createHasManyRepositoryFactoryFor(
      'values',
      valueRepositoryGetter,
    );
    this.registerInclusionResolver('values', this.values.inclusionResolver);
    this.meterType = this.createBelongsToAccessorFor(
      'meterType',
      meterTypeRepositoryGetter,
    );
    this.registerInclusionResolver(
      'meterType',
      this.meterType.inclusionResolver,
    );
  }
}
