import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('sign-in');
  this.route('app', { path: 'app' }, function() {
    this.route('plan', { path: 'plans/:plan_id' });
  });
});

export default Router;
