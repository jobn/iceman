import Base from 'ember-simple-auth/authorizers/base';
import Ember from 'ember';

const { get, isEmpty } = Ember;

export default Base.extend({
  authorize(data, block) {
    let userToken = get(data, 'token');

    if (!isEmpty(userToken)) {
      block('Authorization', `Token token=${userToken}`);
    }
  }
});
