import Model from 'ember-data/model';
import { belongsTo } from 'ember-data/relationships';
import attr from 'ember-data/attr';

export default Model.extend({
  plan: belongsTo('plan'),
  title: attr(),
  color: attr(),
  starts_at: attr('date'),
  ends_at: attr('date'),
});
