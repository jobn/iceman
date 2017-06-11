# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'authentication success' do
    get current_user_path, headers: { 'HTTP_AUTHORIZATION' => "Token token=#{authentication_tokens(:simons_token).token}" }
    assert_response :success
  end

  test 'authentication fail' do
    get current_user_path, headers: { 'HTTP_AUTHORIZATION' => 'Token token=wrong' }
    assert_response :unauthorized
  end
end
