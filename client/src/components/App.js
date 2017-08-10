// @flow
import React, { Component } from 'react';
import { Route, Redirect, withRouter } from 'react-router-dom'
import { connect } from 'react-redux';
import { authenticationSelector } from '../selectors/authentication'
import Dashboard from './Dashboard'
import '../App.css';

type Props = {
  authenticated: boolean,
}

class App extends Component {
  props: Props

  render() {
    const { authenticated } = this.props

    return (
      <Route path="/app" render={() =>
        authenticated ?
          <Dashboard /> :
          <Redirect to="/login" />
      } />
    );
  }
}

export default withRouter(connect(
  authenticationSelector,
)(App));
