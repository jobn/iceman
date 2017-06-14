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

  test '/current_user retuns the signed in user' do
    simon = users(:simon)
    get current_user_path, signed_in_as(simon)

    pattern = {
      user: {
        id: simon.id,
        name: simon.name,
        email: simon.email
      }
    }

    assert_json_match pattern, response.body
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
        }.ignore_extra_keys!,
        {
          id: users(:simone).id
        }.ignore_extra_keys!
      ]
    }

    assert_json_match pattern, response.body
    assert_response :success
  end
end
