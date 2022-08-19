import {ModelCrudRestApiConfig} from '@loopback/rest-crud';
import {Meter} from '../models';

const config: ModelCrudRestApiConfig = {
  model: Meter,
  pattern: 'CrudRest',
  dataSource: 'postgres',
  basePath: '/meters',
  readonly: false,
};
module.exports = config;
