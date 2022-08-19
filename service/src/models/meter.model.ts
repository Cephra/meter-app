import {
  Entity,
  model,
  property,
  belongsTo,
  hasMany,
} from '@loopback/repository';
import {MeterType} from './meter-type.model';
import {Value} from './value.model';

@model({
  settings: {
    postgresql: {schema: 'public', table: 't_meter'},
    foreignKeys: {
      FK_T_METER_METER_TYPE_ID: {
        name: 'fk_t_meter_meter_type_id',
        entity: 'MeterType',
        entityKey: 'id',
        foreignKey: 'meter_type_id',
        onDelete: 'CASCADE',
        onUpdate: 'SET NULL',
      },
    },
  },
})
export class Meter extends Entity {
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
  name?: string;

  @belongsTo(
    () => MeterType,
    {name: 'meterType'},
    {postgresql: {columnName: 'meter_type_id'}},
  )
  meterTypeId: number;

  @hasMany(() => Value)
  values: Value[];

  constructor(data?: Partial<Meter>) {
    super(data);
  }
}

export interface MeterRelations {
  // describe navigational properties here
}

export type MeterWithRelations = Meter & MeterRelations;
