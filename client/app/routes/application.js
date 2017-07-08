import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const {
  inject : { service }
} = Ember;

export default Ember.Route.extend(ApplicationRouteMixin, {
  currentUser: service(),
  session: service(),

  beforeModel(transition) {
    if(this.get('session.isAuthenticated')) {
      return this._loadCurrentUser();
    } else if (transition.targetName !== 'sign-in') {
      this.transitionTo('sign-in');
    }
  },

  sessionAuthenticated() {
    this._super(...arguments);
    this._loadCurrentUser();
  },

  _loadCurrentUser() {
    return this.get('currentUser').load().catch(() => this.get('session').invalidate());
  }
});
