// @flow
import type Action from 'redux'
import { call, put, select } from 'redux-saga/effects'
import Api from '../Api'
import { tokenSelector } from '../selectors/authentication'

export function* fetchCurrentUser(action: Action): Generator<*,*,*> {
  const token = yield select(tokenSelector)
  const options = { endpoint: '/current_user', token}
  try {
    const response = yield call(Api.fetch, options)
    yield put({ type: 'FETCH_CURRENT_USER_SUCCEEDED', payload: { ...response } })
  }
  catch(error) {
    yield put({ type: 'FETCH_CURRENT_USER_FAILED', payload: { error: { ...error.response } } })
  }
}
