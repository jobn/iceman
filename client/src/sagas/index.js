// @flow
import { takeLatest } from 'redux-saga/effects'
import { authenticate } from './authentication'

function* rootSaga(): Generator<*, *, *> {
  yield takeLatest('AUTHENTICATE', authenticate)
}

export default rootSaga
