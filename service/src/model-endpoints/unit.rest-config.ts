import {ModelCrudRestApiConfig} from '@loopback/rest-crud';
import {Unit} from '../models';

const config: ModelCrudRestApiConfig = {
  model: Unit,
  pattern: 'CrudRest',
  dataSource: 'postgres',
  basePath: '/units',
  readonly: false,
};
module.exports = config;
