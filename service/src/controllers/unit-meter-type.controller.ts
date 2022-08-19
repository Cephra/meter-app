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
import {Unit, MeterType} from '../models';
import {UnitRepository} from '../repositories';

export class UnitMeterTypeController {
  constructor(
    @repository(UnitRepository) protected unitRepository: UnitRepository,
  ) {}

  @get('/units/{id}/meter-types', {
    responses: {
      '200': {
        description: 'Array of Unit has many MeterType',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(MeterType)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<MeterType>,
  ): Promise<MeterType[]> {
    return this.unitRepository.meterTypes(id).find(filter);
  }

  @post('/units/{id}/meter-types', {
    responses: {
      '200': {
        description: 'Unit model instance',
        content: {'application/json': {schema: getModelSchemaRef(MeterType)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof Unit.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(MeterType, {
            title: 'NewMeterTypeInUnit',
            exclude: ['id'],
            optional: ['unitId'],
          }),
        },
      },
    })
    meterType: Omit<MeterType, 'id'>,
  ): Promise<MeterType> {
    return this.unitRepository.meterTypes(id).create(meterType);
  }

  @patch('/units/{id}/meter-types', {
    responses: {
      '200': {
        description: 'Unit.MeterType PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(MeterType, {partial: true}),
        },
      },
    })
    meterType: Partial<MeterType>,
    @param.query.object('where', getWhereSchemaFor(MeterType))
    where?: Where<MeterType>,
  ): Promise<Count> {
    return this.unitRepository.meterTypes(id).patch(meterType, where);
  }

  @del('/units/{id}/meter-types', {
    responses: {
      '200': {
        description: 'Unit.MeterType DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(MeterType))
    where?: Where<MeterType>,
  ): Promise<Count> {
    return this.unitRepository.meterTypes(id).delete(where);
  }
}
