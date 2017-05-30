// @flow
import React from 'react'

type Props = {
  error: {
    status: number,
    statusText: string,
  }
}

export default (props: Props) => {
  const { error: { status, statusText } } = props

  if (status === 401) {
    return (
      <div className='error'>
        <p>Username or password is incorrect</p>
      </div>
    )
  }
  return (
    <div className='error'>
      <p>There has been an error</p>
      <p>{status} - {statusText}</p>
    </div>
  )
}
