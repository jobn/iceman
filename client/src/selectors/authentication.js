// @flow
import { createSelector} from 'reselect'

const selectMeta = (state) => state.authentication.meta
const selectAuthenticated = (state) => state.authentication.authenticated

export const authenticationSelector = createSelector(
  selectMeta, selectAuthenticated,
  (meta, authenticated) => ({ meta, authenticated })
)

export const authenticatedSelector = createSelector(
  selectAuthenticated,
  (authenticated) => ({ authenticated })
)
