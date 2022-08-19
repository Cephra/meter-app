import {
  Count,
  CountSchema,
  Filter,
  repository,
  Where,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  getWhereSchemaFor,
  param,
  patch,
  post,
  requestBody,
} from '@loopback/rest';
import {MeterType, Meter} from '../models';
import {MeterTypeRepository} from '../repositories';

export class MeterTypeMeterController {
  constructor(
    @repository(MeterTypeRepository)
    protected meterTypeRepository: MeterTypeRepository,
  ) {}

  @get('/meter-types/{id}/meters', {
    responses: {
      '200': {
        description: 'Array of MeterType has many Meter',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Meter)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Meter>,
  ): Promise<Meter[]> {
    return this.meterTypeRepository.meters(id).find(filter);
  }

  @post('/meter-types/{id}/meters', {
    responses: {
      '200': {
        description: 'MeterType model instance',
        content: {'application/json': {schema: getModelSchemaRef(Meter)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof MeterType.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Meter, {
            title: 'NewMeterInMeterType',
            exclude: ['id'],
            optional: ['meterTypeId'],
          }),
        },
      },
    })
    meter: Omit<Meter, 'id'>,
  ): Promise<Meter> {
    return this.meterTypeRepository.meters(id).create(meter);
  }

  @patch('/meter-types/{id}/meters', {
    responses: {
      '200': {
        description: 'MeterType.Meter PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Meter, {partial: true}),
        },
      },
    })
    meter: Partial<Meter>,
    @param.query.object('where', getWhereSchemaFor(Meter)) where?: Where<Meter>,
  ): Promise<Count> {
    return this.meterTypeRepository.meters(id).patch(meter, where);
  }

  @del('/meter-types/{id}/meters', {
    responses: {
      '200': {
        description: 'MeterType.Meter DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Meter)) where?: Where<Meter>,
  ): Promise<Count> {
    return this.meterTypeRepository.meters(id).delete(where);
  }
}
