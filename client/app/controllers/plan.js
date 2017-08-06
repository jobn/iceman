import Ember from 'ember';

export default Ember.Controller.extend({
  events: Ember.computed('model', function() {
    return this.get('model.events');
  })
});
