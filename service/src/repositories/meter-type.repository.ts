import {inject, Getter} from '@loopback/core';
import {
  DefaultCrudRepository,
  repository,
  BelongsToAccessor,
  HasManyRepositoryFactory,
} from '@loopback/repository';
import {PostgresDataSource} from '../datasources';
import {MeterType, MeterTypeRelations, Unit, Meter} from '../models';
import {UnitRepository} from './unit.repository';
import {MeterRepository} from './meter.repository';

export class MeterTypeRepository extends DefaultCrudRepository<
  MeterType,
  typeof MeterType.prototype.id,
  MeterTypeRelations
> {
  public readonly unit: BelongsToAccessor<Unit, typeof MeterType.prototype.id>;

  public readonly meters: HasManyRepositoryFactory<
    Meter,
    typeof MeterType.prototype.id
  >;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
    @repository.getter('UnitRepository')
    protected unitRepositoryGetter: Getter<UnitRepository>,
    @repository.getter('MeterRepository')
    protected meterRepositoryGetter: Getter<MeterRepository>,
  ) {
    super(MeterType, dataSource);
    this.meters = this.createHasManyRepositoryFactoryFor(
      'meters',
      meterRepositoryGetter,
    );
    this.registerInclusionResolver('meters', this.meters.inclusionResolver);
    this.unit = this.createBelongsToAccessorFor('unit', unitRepositoryGetter);
    this.registerInclusionResolver('unit', this.unit.inclusionResolver);
  }
}
