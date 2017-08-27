// @flow
import React, { Component } from 'react'
import { Route, Redirect, withRouter } from 'react-router-dom'
import { Button, Form, Message, Segment } from 'semantic-ui-react'
import { connect } from 'react-redux'
import { authenticate } from '../../actions/user'
import { authenticationSelector } from '../../selectors/authentication'

type Props = {
  meta: Object,
  authenticated: boolean,
  onAuthenticate: Function,
}

type State = {
  email: ?string,
  password: ?string,
}

class Login extends Component<Props, State> {
  handleSubmit: Function
  props: Props
  state: State = {
    email: null,
    password: null,
  }

  handleSubmit = (event: SyntheticEvent<*>) => {
    event.preventDefault()
    const { onAuthenticate } = this.props
    const { email, password } = this.state

    onAuthenticate(email,password)
    this.setState({
      email: null,
      password: null,
    })
  }

  handleEmailChange = (event: SyntheticEvent<*>) => {
    if (event.target instanceof HTMLInputElement) {
      this.setState({
        email: event.target.value
      })
    }
  }

  handlePasswordChange = (event: SyntheticEvent<*>) => {
    if (event.target instanceof HTMLInputElement) {
      this.setState({
        password: event.target.value
      })
    }
  }

  render() {
    const { authenticated, meta: { requesting, error } } = this.props
    return (
      <Route path="/login" render={() =>
        authenticated ?
          <Redirect to="/app" /> :
            <div className="container">
              <div className="login">
                <Form size='large' onSubmit={this.handleSubmit} error={error}>
                  <Segment>
                    <Message
                      error
                      header='Fejl'
                      content='Brugernavn og adgangskode stemmer ikke overens'
                    />

                    <Form.Input
                      icon='user'
                      iconPosition='left'
                      placeholder='E-mail addresse'
                      onChange={this.handleEmailChange}
                      disabled={requesting}
                    />

                    <Form.Input
                      icon='lock'
                      iconPosition='left'
                      placeholder='Adgangskode'
                      type='password'
                      onChange={this.handlePasswordChange}
                      disabled={requesting}
                    />
                    <Button fluid size='large' disabled={requesting}>Log ind</Button>
                  </Segment>
                </Form>
            </div>
          </div>
      } />
    )
  }
}

const mapDispatchToProps = {
  onAuthenticate: authenticate
}

export default withRouter(connect(
  authenticationSelector,
  mapDispatchToProps
)(Login))
