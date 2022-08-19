import {ModelCrudRestApiConfig} from '@loopback/rest-crud';
import {MeterType} from '../models';

const config: ModelCrudRestApiConfig = {
  model: MeterType,
  pattern: 'CrudRest',
  dataSource: 'postgres',
  basePath: '/meter-types',
  readonly: false,
};
module.exports = config;
