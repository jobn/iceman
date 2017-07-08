import Ember from 'ember';

const { inject: { service } } = Ember;

export default Ember.Controller.extend({
  session: service(),

  actions: {
    authenticate() {
      this.get('session').authenticate(
        'authenticator:rails',
        this.get('email'),
        this.get('password')
      ).catch((reason) => {
        this.set('errorMessage', reason.error || reason);
      });
    }
  }
});
