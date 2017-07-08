import Ember from 'ember';

const {
  isEmpty,
  RSVP,
  inject: { service }
} = Ember;

export default Ember.Service.extend({
  session: service(),
  store: service(),

  user: null,

  load() {
    let userId = this.get('session.data.authenticated.userId');

    if (!isEmpty(userId)) {
      return this.get('store').findRecord('user', userId).then((user) => {
        this.set('user', user);
      });
    } else {
      Ember.Logger.error('User service: No user id found');
      return RSVP.reject();
    }
  }
});
