// @flow
import type Action from 'redux'

export function authenticate(email: string, password: string): Action {
  return {
    type: 'AUTHENTICATE',
    payload: { email, password }
  }
}
