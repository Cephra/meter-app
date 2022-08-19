import {ModelCrudRestApiConfig} from '@loopback/rest-crud';
import {Value} from '../models';

const config: ModelCrudRestApiConfig = {
  model: Value,
  pattern: 'CrudRest',
  dataSource: 'postgres',
  basePath: '/values',
  readonly: false,
};
module.exports = config;
