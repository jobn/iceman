import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

const {
  inject : { service }
} = Ember;

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  currentUser: service(),

  model() {
    return this.get('currentUser.user');
  },

  actions: {
    invalidate() {
      this.get('session').invalidate();
    }
  }
});
