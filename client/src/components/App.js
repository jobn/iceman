// @flow
import React, { Component } from 'react';
import { connect } from 'react-redux';
import SignIn from './SignIn';
import logo from '../logo.svg';
import '../App.css';

type Props = {
  user: {
    id: number,
    name: string,
    email: string,
  }
}

class App extends Component {
  props: Props

  render() {
    const { user: { name, email } } = this.props

    return (
      <div className="App">
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

const mapStateToProps = (state: Object): Object => {
  return {
    user: state.user
  }
}

export default connect(
  mapStateToProps,
)(App);
