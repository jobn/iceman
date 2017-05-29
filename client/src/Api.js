// @flow
class RequestError extends Error {
  response: Object
}

function checkStatus(response: Object): Object | RequestError {
  if (response.ok) {
    return response
  } else {
    const { url, status, statusText } = response

    let error = new RequestError(statusText)
    error.response = { url, status, statusText }
    throw error
  }
}

function parseJSON(response: Object): Object {
  return response.json()
}

class Api {
  authenticate(payload: Object): Promise<*> {
    const { email, password } = payload

    return fetch('/api/sessions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ email, password })
    })
    .then(checkStatus)
    .then(parseJSON)
  }
}

export default new Api()
