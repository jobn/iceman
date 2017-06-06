// @flow
import type Action from 'redux'
import type { Meta } from '../types'

type User = {
  id: number,
  name: string,
  email: string,
  role: string,
}

type State = {
  user: User | null,
  meta: Meta,
}

const initialState = {
  user: null,
  meta: {
    requesting: false,
    error: null,
  }
}

export default function user(state: State = initialState, action: Action): Object {
  const { type, payload } = action

  switch (type) {
    case 'FETCH_CURRENT_USER':
      return { ...state, meta: { requesting: true }}

    case 'FETCH_CURRENT_USER_SUCCEEDED':
      const { user } = payload
      return { ...state, user, meta: { requesting: false } }

    case 'FETCH_CURRENT_USER_FAILED':
      const { error } = payload
      return { ...state, ...initialState, meta: { error, requesting: false } }

    default:
      return { ...state }
  }
}
