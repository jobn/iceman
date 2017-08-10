// @flow
import React from 'react'
import ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { BrowserRouter } from 'react-router-dom'
import store from './store'
import App from './components/App'
import Login from './components/Login'
import './index.css'


ReactDOM.render(
  <Provider store={store}>
    <BrowserRouter>
      <div>
        <App />
        <Login />
      </div>
    </BrowserRouter>
  </Provider>
, document.getElementById('root'))
