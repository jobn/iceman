# PROJECT ICEMAN

Planning app for families and children with ASF

## Development setup

Backend in Rails 5.1,
client in React 15.5

ruby-version 2.4,
node-version 7.10

The client app is bootstrapped using [create-react-app](https://github.com/facebookincubator/create-react-app)

Run the following commands to setup dev environment

* `bundle install`
* `npm i -g create-react-app`
* `cd client && npm install`

## Starting the servers

Development servers are managed by foreman and there is a rake task to start foreman. So booting the dev servers is as simple as:

`rake start`
