// @flow
import { combineReducers } from 'redux'
import user from './user'
import authentication from './authentication'

const reducers = combineReducers({
  authentication,
  user,
})

export default reducers
