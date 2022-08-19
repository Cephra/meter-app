import {repository} from '@loopback/repository';
import {param, get, getModelSchemaRef} from '@loopback/rest';
import {Meter, MeterType} from '../models';
import {MeterRepository} from '../repositories';

export class MeterMeterTypeController {
  constructor(
    @repository(MeterRepository)
    public meterRepository: MeterRepository,
  ) {}

  @get('/meters/{id}/meter-type', {
    responses: {
      '200': {
        description: 'MeterType belonging to Meter',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(MeterType)},
          },
        },
      },
    },
  })
  async getMeterType(
    @param.path.number('id') id: typeof Meter.prototype.id,
  ): Promise<MeterType> {
    return this.meterRepository.meterType(id);
  }
}
