// @flow
import { takeLatest } from 'redux-saga/effects'
import { authenticate } from './authentication'
import { fetchCurrentUser } from './users'

function* rootSaga(): Generator<*, *, *> {
  yield takeLatest('AUTHENTICATE', authenticate)
  yield takeLatest('FETCH_CURRENT_USER', fetchCurrentUser)
}

export default rootSaga
