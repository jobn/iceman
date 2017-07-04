# PROJECT ICEMAN

Planning app for families and children with ASF

## Development setup

Backend in Rails 5.1,
client in Ember

ruby-version 2.4,
node-version 8.1.3

Run the following commands to setup dev environment

* `bundle install`
* `npm install -g ember-cli@2.13`
* `cd client && npm install`

## Starting the servers

Development servers are managed by foreman and there is a rake task to start foreman. So booting the dev servers is as simple as:

`rake start`
