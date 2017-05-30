// @flow
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { authenticate } from '../actions/user'

type Props = {
  requesting: boolean,
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
    const { requesting } = this.props

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
       </form>
    )
  }
}

const mapStateToProps = (state: Object): Object => {
  return {
    requesting: state.authentication.meta.requesting,
  }
}

const mapDispatchToProps = {
  onAuthenticate: authenticate
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(SignIn)
