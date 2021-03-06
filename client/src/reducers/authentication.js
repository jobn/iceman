// @flow
import type Action from 'redux'
import { REHYDRATE } from 'redux-persist/constants'
import type { Meta } from '../types'

type State = {
  authenticated: boolean,
  token: string | null,
  meta: Meta,
}

const initialState: State = {
  authenticated: false,
  token: null,
  meta: {
    requesting: false,
    error: null
  }
}

const authentication = (state: Object = initialState, action: Action): State => {
  const { type, payload } = action

  switch (type) {
    case REHYDRATE:
      const { authentication } = payload
      const { meta } = state
      return { ...authentication, meta: { ...meta } }

    case 'AUTHENTICATE':
      return { ...state, meta: { requesting: true, error: null } }

    case 'AUTHENTICATION_SUCCEEDED':
      const { authentication_token: { token, user_id } } = payload
      return { ...state, token, user_id, authenticated: true, meta: { requesting: false } }

    case 'AUTHENTICATION_FAILED':
      const { error } = payload
      return { ...state, ...initialState, meta: { error, requesting: false } }

    default:
      return { ...state }
  }
}

export default authentication
