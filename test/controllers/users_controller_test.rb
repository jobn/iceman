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

  test '/users returns users within same account' do
    get users_path, signed_in_as(users(:simon))

    pattern = {
      users: [
        {
          id: users(:simon).id
        }.ignore_extra_keys!,
        {
          id: users(:simons_mom).id
        }.ignore_extra_keys!
      ]
    }

    assert_json_match pattern, response.body
    assert_response :success
  end
end
