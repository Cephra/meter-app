import {repository} from '@loopback/repository';
import {param, get, getModelSchemaRef} from '@loopback/rest';
import {MeterType, Unit} from '../models';
import {MeterTypeRepository} from '../repositories';

export class MeterTypeUnitController {
  constructor(
    @repository(MeterTypeRepository)
    public meterTypeRepository: MeterTypeRepository,
  ) {}

  @get('/meter-types/{id}/unit', {
    responses: {
      '200': {
        description: 'Unit belonging to MeterType',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Unit)},
          },
        },
      },
    },
  })
  async getUnit(
    @param.path.number('id') id: typeof MeterType.prototype.id,
  ): Promise<Unit> {
    return this.meterTypeRepository.unit(id);
  }
}
