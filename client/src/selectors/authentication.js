// @flow
import { createSelector} from 'reselect'

const selectMeta = (state) => state.authentication.meta
const selectAuthenticated = (state) => state.authentication.authenticated
const selectToken = (state) => state.authentication.token

export const authenticationSelector = createSelector(
  selectMeta, selectAuthenticated,
  (meta, authenticated) => ({ meta, authenticated })
)

export const authenticatedSelector = createSelector(
  selectAuthenticated,
  (authenticated) => ({ authenticated })
)

export const tokenSelector = createSelector(
  selectToken,
  (token) => (token)
)
