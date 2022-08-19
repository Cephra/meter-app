import {inject, Getter} from '@loopback/core';
import {
  DefaultCrudRepository,
  repository,
  BelongsToAccessor,
} from '@loopback/repository';
import {PostgresDataSource} from '../datasources';
import {Value, ValueRelations, Meter} from '../models';
import {MeterRepository} from './meter.repository';

export class ValueRepository extends DefaultCrudRepository<
  Value,
  typeof Value.prototype.id,
  ValueRelations
> {
  public readonly meter: BelongsToAccessor<Meter, typeof Value.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
    @repository.getter('MeterRepository')
    protected meterRepositoryGetter: Getter<MeterRepository>,
  ) {
    super(Value, dataSource);
    this.meter = this.createBelongsToAccessorFor(
      'meter',
      meterRepositoryGetter,
    );
    this.registerInclusionResolver('meter', this.meter.inclusionResolver);
  }
}
