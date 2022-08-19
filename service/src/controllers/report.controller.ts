import {repository} from '@loopback/repository';
import {get, getModelSchemaRef, param} from '@loopback/rest';
import {MeterWithStats, ValueWithChange} from '../models';
import {MeterRepository, ValueRepository} from '../repositories';

import {differenceInDays} from 'date-fns';

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
            schema: {type: 'array', items: getModelSchemaRef(ValueWithChange)},
          },
        },
      },
    },
  })
  async report(
    @param.path.number('meterTypeId') meterTypeId: number,
    @param.query.date('from') from: string | null,
    @param.query.date('to') to: string | null,
  ): Promise<ValueWithChange[]> {
    const metersByType = await this.meterRepository.find({
      where: {meterTypeId},
      fields: ['id'],
    });
    const valuesByMeterType = await this.valueRepository.find({
      where: {
        meterId: {
          inq: metersByType.map(m => m.id as number),
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
    });
    const sortedMetersByType = metersByType
      .map(m => {
        const firstValue = valuesByMeterType.find(v => v.meterId === m.id);
        const lastValue = valuesByMeterType.findLast(v => v.meterId === m.id);

        const creationDate = new Date(firstValue?.timestamp ?? 0);

        return new MeterWithStats({
          ...m,
          creationDate,
          firstValue: firstValue?.value ?? 0,
          lastValue: lastValue?.value ?? 0,
        });
      })
      .sort((a, b) => {
        return (
          (a.creationDate as Date).getTime() -
          (b.creationDate as Date).getTime()
        );
      });
    const sortedValues = sortedMetersByType
      .map((meter, i) => {
        const valuesForMeter = valuesByMeterType
          .filter(v => v.meterId === meter.id)
          .map((v, j, a) => {
            const cumSum = sortedMetersByType
              .slice(0, i)
              .map(m => (m.lastValue ?? 0) - (m.firstValue ?? 0))
              .reduce((acc, m) => m + acc, 0);
            const firstValueOfCurrentMeter = meter.firstValue ?? 0;

            v.value = v.value - firstValueOfCurrentMeter + cumSum;
            const prev = a[j - 1];
            const prevValue = a[j - 1]?.value ?? cumSum;
            return new ValueWithChange({
              ...v,
              change: v.value - prevValue,
              daysSinceLastRecord: differenceInDays(
                v.timestamp,
                prev?.timestamp ?? v.timestamp,
              ),
            });
          });

        return valuesForMeter;
      })
      .flat();

    return sortedValues;
  }
}
