import Model from 'ember-data/model';
import { belongsTo } from 'ember-data/relationships';
import attr from 'ember-data/attr';

export default Model.extend({
  name: attr(),
  email: attr(),
  plan: belongsTo('plan'),
});
