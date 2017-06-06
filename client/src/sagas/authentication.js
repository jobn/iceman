// @flow
import type Action from 'redux'
import { call, put } from 'redux-saga/effects'
import Api from '../Api'

export function* authenticate(action: Action): Generator<*,*,*> {
  const { payload } = action

  try {
    const response = yield call(Api.authenticate, { ...payload })
    yield put({ type: 'AUTHENTICATION_SUCCEEDED', payload: { ...response } })
    yield put({ type: 'FETCH_CURRENT_USER' })
  }
  catch(error) {
    yield put({ type: 'AUTHENTICATION_FAILED', payload: { error: { ...error.response } } })
  }
}
