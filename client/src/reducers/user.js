// @flow

const initialState = {
  id: 1,
  name: 'Johannes',
  email: 'johannes@github.com',
}

export default function user(state: Object = initialState, action: string): Object {
  return { ...state };
}
