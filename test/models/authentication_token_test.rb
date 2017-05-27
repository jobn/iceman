# frozen_string_literal: true

require 'test_helper'

class AuthenticationTokenTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid authentication_tokens(:supermans_token)
  end

  test 'new AuthenticationToken has token' do
    assert AuthenticationToken.create(user: users(:superman)).token
  end
end
