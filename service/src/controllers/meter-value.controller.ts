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
import {Meter, Value} from '../models';
import {MeterRepository} from '../repositories';

export class MeterValueController {
  constructor(
    @repository(MeterRepository) protected meterRepository: MeterRepository,
  ) {}

  @get('/meters/{id}/values', {
    responses: {
      '200': {
        description: 'Array of Meter has many Value',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Value)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<Value>,
  ): Promise<Value[]> {
    return this.meterRepository.values(id).find(filter);
  }

  @post('/meters/{id}/values', {
    responses: {
      '200': {
        description: 'Meter model instance',
        content: {'application/json': {schema: getModelSchemaRef(Value)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof Meter.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Value, {
            title: 'NewValueInMeter',
            exclude: ['id'],
            optional: ['meterId'],
          }),
        },
      },
    })
    value: Omit<Value, 'id'>,
  ): Promise<Value> {
    return this.meterRepository.values(id).create(value);
  }

  @patch('/meters/{id}/values', {
    responses: {
      '200': {
        description: 'Meter.Value PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Value, {partial: true}),
        },
      },
    })
    value: Partial<Value>,
    @param.query.object('where', getWhereSchemaFor(Value)) where?: Where<Value>,
  ): Promise<Count> {
    return this.meterRepository.values(id).patch(value, where);
  }

  @del('/meters/{id}/values', {
    responses: {
      '200': {
        description: 'Meter.Value DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(Value)) where?: Where<Value>,
  ): Promise<Count> {
    return this.meterRepository.values(id).delete(where);
  }
}
