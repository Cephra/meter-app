import {
  Entity,
  model,
  property,
  belongsTo,
  hasMany,
} from '@loopback/repository';
import {Unit} from './unit.model';
import {Meter} from './meter.model';

@model({
  settings: {
    postgresql: {schema: 'public', table: 't_meter_type'},
    foreignKeys: {
      FK_T_METER_TYPE_UNIT_ID: {
        name: 'fk_t_meter_type_unit_id',
        entity: 'Unit',
        entityKey: 'id',
        foreignKey: 'unit_id',
        onDelete: 'CASCADE',
        onUpdate: 'SET NULL',
      },
    },
  },
})
export class MeterType extends Entity {
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

  @belongsTo(() => Unit, {name: 'unit'}, {postgresql: {columnName: 'unit_id'}})
  unitId: number;

  @hasMany(() => Meter)
  meters: Meter[];

  constructor(data?: Partial<MeterType>) {
    super(data);
  }
}

export interface MeterTypeRelations {
  // describe navigational properties here
}

export type MeterTypeWithRelations = MeterType & MeterTypeRelations;
