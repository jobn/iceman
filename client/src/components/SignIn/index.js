// @flow
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { authenticate } from '../../actions/user'
import { authenticationSelector } from '../../selectors/authentication'
import ErrorMessage from './Error'

type Props = {
  meta: Object,
  authenticated: boolean,
  onAuthenticate: Function,
}

class SignIn extends Component {
  email: HTMLInputElement
  password: HTMLInputElement
  handleSubmit: Function
  props: Props

  handleSubmit = (event: Event) => {
    event.preventDefault()
    const { onAuthenticate } = this.props

    onAuthenticate(
      this.email.value,
      this.password.value,
    )
  }

  render() {
    const { authenticated, meta: { requesting, error } } = this.props

    return (
      <form className='SignIn' onSubmit={this.handleSubmit}>
         <label>
           Email:
           <input type="text" ref={(input) => this.email = input} disabled={requesting} />
         </label>

         <label>
           Password:
           <input type="text" ref={(input) => this.password = input} disabled={requesting} />
         </label>

         <input type="submit" value="Submit" disabled={requesting} />

         {error &&
           <ErrorMessage error={error} />
         }

         {authenticated &&
           <div className='success'>
             <p>Success :)</p>
           </div>
         }
       </form>
    )
  }
}

const mapDispatchToProps = {
  onAuthenticate: authenticate
}

export default connect(
  authenticationSelector,
  mapDispatchToProps
)(SignIn)
