// @flow
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { authenticate } from '../actions/user'

type Props = {
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
    return (
      <form className='SignIn' onSubmit={this.handleSubmit}>
         <label>
           Email:
           <input type="text" ref={(input) => this.email = input} />
         </label>

         <label>
           Password:
           <input type="text" ref={(input) => this.password = input} />
         </label>

         <input type="submit" value="Submit" />
       </form>
    )
  }
}

const mapDispatchToProps = {
  onAuthenticate: authenticate
}

export default connect(
  null,
  mapDispatchToProps
)(SignIn)
