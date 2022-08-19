import {repository} from '@loopback/repository';
import {param, get, getModelSchemaRef} from '@loopback/rest';
import {Value, Meter} from '../models';
import {ValueRepository} from '../repositories';

export class ValueMeterController {
  constructor(
    @repository(ValueRepository)
    public valueRepository: ValueRepository,
  ) {}

  @get('/values/{id}/meter', {
    responses: {
      '200': {
        description: 'Meter belonging to Value',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Meter)},
          },
        },
      },
    },
  })
  async getMeter(
    @param.path.number('id') id: typeof Value.prototype.id,
  ): Promise<Meter> {
    return this.valueRepository.meter(id);
  }
}
