# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'authentication success' do
    get users_path, headers: { 'HTTP_AUTHORIZATION' => "Token token=#{authentication_tokens(:simons_token).token}" }
    assert_response :success
  end

  test 'authentication fail' do
    get users_path, headers: { 'HTTP_AUTHORIZATION' => 'Token token=wrong' }
    assert_response :unauthorized
  end

  test 'get /user/:id retuns user' do
    simon = users(:simon)
    get user_path(simon), signed_in_as(simon)

    pattern = {
      data: {
        id: simon.id.to_s,
        type: 'users',
        attributes: {
          name: simon.name,
          email: simon.email
        },
        relationships: {
          plan: {
            data: {
              id: plans(:simons_plan).id.to_s,
              type: 'plans'
            }
          }
        }
      }
    }

    assert_json_match pattern, response.body
  end

  test 'get /users returns users within same account' do
    get users_path, signed_in_as(users(:simon))

    pattern = {
      data: [
        {
          id: users(:simon).id.to_s
        }.ignore_extra_keys!,
        {
          id: users(:simons_mom).id.to_s
        }.ignore_extra_keys!,
        {
          id: users(:simone).id.to_s
        }.ignore_extra_keys!
      ]
    }

    assert_json_match pattern, response.body
    assert_response :success
  end
end
