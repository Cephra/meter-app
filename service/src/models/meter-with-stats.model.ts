import {model, property} from '@loopback/repository';
import {Meter} from '.';

@model()
export class MeterWithStats extends Meter {
  @property({
    type: 'number',
  })
  firstValue?: number;

  @property({
    type: 'number',
  })
  lastValue?: number;

  @property({
    type: 'date',
  })
  creationDate?: string | Date;

  constructor(data?: Partial<MeterWithStats>) {
    super(data);
  }
}

export interface MeterWithStatsRelations {
  // describe navigational properties here
}

export type MeterWithStatsWithRelations = MeterWithStats &
  MeterWithStatsRelations;
