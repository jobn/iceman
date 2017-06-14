# frozen_string_literal: true

require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get plans_url, signed_in_as(users(:simon))

    pattern = {
      plans: [
        {
          id: plans(:simons_plan).id
        }.ignore_extra_keys!,
        {
          id: plans(:simons_moms_plan).id
        }.ignore_extra_keys!
      ]
    }

    assert_json_match pattern, response.body
    assert_response :success
  end

  test 'should get show' do
    skip 'pending'
  end

  test 'should get new' do
    skip 'pending'
  end

  test 'should get create' do
    skip 'pending'
  end

  test 'should get update' do
    skip 'pending'
  end

  test 'should get destroy' do
    skip 'pending'
  end
end
