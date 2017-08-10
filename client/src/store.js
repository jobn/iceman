// @flow
import { createStore, applyMiddleware, compose } from 'redux'
import createSagaMiddleware from 'redux-saga'
import {persistStore, autoRehydrate} from 'redux-persist'
import reducers from './reducers'
import sagas from './sagas'

const sagaMiddleware = createSagaMiddleware()

const store = createStore(
  reducers,
  undefined,
  compose(
    applyMiddleware(sagaMiddleware),
    autoRehydrate(),
    window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__(),
  )
)

sagaMiddleware.run(sagas)

persistStore(store, {
  whitelist: ['authentication'],
  keyPrefix: 'store:',
})

export default store
