# frozen_string_literal: true

require 'test_helper'

class CreateSessionTest < ActiveSupport::TestCase
  test 'returns an AuthenticationToken if credentials is valid' do
    token = CreateSession.new(
      email: users(:superman).email,
      password: 'password'
    ).call

    assert_kind_of AuthenticationToken, token
  end

  test 'returns nil if credentials is not valid' do
    token = CreateSession.new(
      email: users(:superman).email,
      password: 'wrong'
    ).call

    assert_nil token
  end
end
