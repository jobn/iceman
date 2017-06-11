# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'authentication fails' do
    post sessions_url, params: { session: { email: users(:simon).email, password: 'wrong_password' } }
    assert_response :unauthorized
  end

  test 'authentication success' do
    post sessions_url, params: { session: { email: users(:simon).email, password: 'password' } }
    assert_response :success
  end

  test 'creates token for session' do
    assert_difference('AuthenticationToken.count') do
      post sessions_url, params: { session: { email: users(:simon).email, password: 'password' } }
    end
  end

  test 'delete deletes the token' do
    assert_difference('AuthenticationToken.count', -1) do
      delete sessions_url, headers: { 'HTTP_AUTHORIZATION' => "Token token=#{authentication_tokens(:simons_token).token}" }
    end
  end
end
