// @flow
import React, { Component } from 'react';
import { Route, Redirect } from 'react-router-dom'
import { connect } from 'react-redux';
import { authenticationSelector } from '../selectors/authentication'
import SignIn from './SignIn';
import logo from '../logo.svg';
import '../App.css';

type Props = {
  authenticated: boolean,
}

class App extends Component {
  props: Props

  render() {
    const { authenticated } = this.props

    return (
      <div className="App">
        {authenticated ?
          <Route path="/plans" component={Plans} />
          <Redirect to="/plans" />
        }

        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Hello {name}, Welcome to React</h2>
        </div>

        <p className="App-intro">
          Your email is { email }
        </p>

        <SignIn />
      </div>
    );
  }
}

export default connect(
  authenticationSelector,
)(App);
