import {model, property} from '@loopback/repository';
import {Value} from '.';

@model()
export class ValueWithChange extends Value {
  @property({
    type: 'number',
  })
  change?: number;

  @property({
    type: 'number',
  })
  daysSinceLastRecord?: number;

  constructor(data?: Partial<ValueWithChange>) {
    super(data);
  }
}

export interface ValueWithChangeRelations {
  // describe navigational properties here
}

export type ValueWithChangeWithRelations = ValueWithChange &
  ValueWithChangeRelations;
