import {Entity, model, property, hasMany} from '@loopback/repository';
import {MeterType} from './meter-type.model';

@model({
  settings: {
    postgresql: {schema: 'public', table: 't_unit'},
  },
})
export class Unit extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'string',
    required: true,
  })
  suffix: string;

  @hasMany(() => MeterType)
  meterTypes: MeterType[];

  constructor(data?: Partial<Unit>) {
    super(data);
  }
}

export interface UnitRelations {
  // describe navigational properties here
}

export type UnitWithRelations = Unit & UnitRelations;
