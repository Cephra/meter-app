import {repository} from '@loopback/repository';
import {get, getModelSchemaRef, param} from '@loopback/rest';
import {Value} from '../models';
import {MeterRepository, ValueRepository} from '../repositories';

export class ReportController {
  constructor(
    @repository(MeterRepository) protected meterRepository: MeterRepository,
    @repository(ValueRepository) protected valueRepository: ValueRepository,
  ) {}

  @get('/reports/{meterTypeId}', {
    responses: {
      '200': {
        description: 'Array of adjusted values for a given timeframe',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Value)},
          },
        },
      },
    },
  })
  async report(
    @param.path.number('meterTypeId') meterTypeId: number,
    @param.query.date('from') from: string | null,
    @param.query.date('to') to: string | null,
  ): Promise<Value[]> {
    const metersByTypeIds = (
      await this.meterRepository.find({
        where: {meterTypeId},
        fields: ['id'],
      })
    ).map(o => o.id as number);

    let currentMeterId: number | null = null,
      lastInitialValue: number = 0,
      lastValue: number = 0,
      lastValueOfMeter: number = 0;

    const adjustedValuesOfMeterType = (
      await this.valueRepository.find({
        where: {
          meterId: {
            inq: metersByTypeIds,
          },
          timestamp: {
            between: [
              new Date(from ?? 0).toISOString(),
              (to ? new Date(to) : new Date()).toISOString(),
            ],
          },
        },
        fields: ['value', 'timestamp', 'meterId'],
        order: ['timestamp asc'],
      })
    ).map(v => {
      const currentValue = v.value;

      if (v.meterId !== currentMeterId) {
        currentMeterId = v.meterId;
        lastInitialValue = currentValue;
        lastValueOfMeter = lastValue;
      }

      v.value = currentValue - lastInitialValue + lastValueOfMeter;
      // TODO somehow calc change
      // v.change = v.value - lastValue;
      lastValue = v.value;

      return v;
    });

    return adjustedValuesOfMeterType;
  }
}
