import Ember from 'ember';
import Base from 'ember-simple-auth/authenticators/base';

const {
  run,
  RSVP,
  get
} = Ember;

export default Base.extend({
  restore(data) {
    return RSVP.resolve(data);
  },

  authenticate(email, password) {
    let data = {
      session: { email, password }
    };

    let requestOptions = Ember.$.extend({}, {
      url:      '/api/sessions',
      type:     'POST',
      dataType: 'json',
      data,
      beforeSend(xhr, settings) {
        xhr.setRequestHeader('Accept', settings.accepts.json);
      }
    }, {});

    return new Ember.RSVP.Promise((resolve, reject) => {
      return Ember.$.ajax(requestOptions).then(
        (response) => {
          let sessionAttributes = {
            token: get(response, 'data.attributes.token'),
            userId: get(response, 'data.relationships.user.data.id')
          }

          run(null, resolve, sessionAttributes);
        },
        (xhr) => run(null, reject, xhr.responseJSON || xhr.responseText)
      );
    });
  },

  invalidate(data) {
    const token = get(data, 'token');

    let requestOptions = Ember.$.extend({}, {
      url:      '/api/sessions',
      type:     'DELETE',
      dataType: 'json',
      beforeSend(xhr, settings) {
        xhr.setRequestHeader('Accept', settings.accepts.json);
        xhr.setRequestHeader('Authorization', `Token token=${token}`);
      }
    }, {});

    return Ember.$.ajax(requestOptions)
  }
});
