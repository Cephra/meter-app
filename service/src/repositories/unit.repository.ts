import {inject, Getter} from '@loopback/core';
import {
  DefaultCrudRepository,
  repository,
  HasManyRepositoryFactory,
} from '@loopback/repository';
import {PostgresDataSource} from '../datasources';
import {Unit, UnitRelations, MeterType} from '../models';
import {MeterTypeRepository} from './meter-type.repository';

export class UnitRepository extends DefaultCrudRepository<
  Unit,
  typeof Unit.prototype.id,
  UnitRelations
> {
  public readonly meterTypes: HasManyRepositoryFactory<
    MeterType,
    typeof Unit.prototype.id
  >;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
    @repository.getter('MeterTypeRepository')
    protected meterTypeRepositoryGetter: Getter<MeterTypeRepository>,
  ) {
    super(Unit, dataSource);
    this.meterTypes = this.createHasManyRepositoryFactoryFor(
      'meterTypes',
      meterTypeRepositoryGetter,
    );
    this.registerInclusionResolver(
      'meterTypes',
      this.meterTypes.inclusionResolver,
    );
  }
}
