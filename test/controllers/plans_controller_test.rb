# frozen_string_literal: true

require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test 'should return 401 when authentication header is missing' do
    get plans_url
    assert_response :unauthorized
  end

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
    get plan_url(plans(:simons_plan)), signed_in_as(users(:simon))

    pattern = {
      plan: {
        id: plans(:simons_plan).id
      }
    }

    assert_json_match pattern, response.body
    assert_response :success
  end

  test 'should not return plan from other account' do
    get plan_url(plans(:peters_plan)), signed_in_as(users(:simon))
    assert_response :not_found
  end

  test 'should create plan on valid post' do
    assert_difference 'accounts(:jensen).plans.count' do
      options = signed_in_as(users(:simon)).merge(
        params: { plan: { user_id: users(:simone).id } }
      )
      post plans_url, options
    end

    pattern = {
      plan: {
        id: Integer
      }.ignore_extra_keys!
    }

    assert_json_match pattern, response.body
    assert_response :created
  end

  test 'should return 404 on invalid user_id in create post' do
    assert_no_difference 'Plan.count' do
      options = signed_in_as(users(:simon)).merge(
        params: { plan: { user_id: 'wrong' } }
      )
      post plans_url, options
    end

    assert_response :not_found
  end

  test 'should return 400 on invalid params in create post' do
    assert_no_difference 'Plan.count' do
      options = signed_in_as(users(:simon)).merge(
        params: {}
      )
      post plans_url, options
    end

    assert_response :bad_request
  end

  test 'should update plan' do
    options = signed_in_as(users(:simon)).merge(
      params: {
        plan: {
          user_id: users(:simone).id
        }
      }
    )
    put plan_url(plans(:simons_plan)), options

    assert_equal users(:simone).plan, plans(:simons_plan)
    assert_nil users(:simon).plan
    assert_response :success
  end

  test 'should return 404 on invalid user_id in update put' do
    options = signed_in_as(users(:simon)).merge(
      params: {
        plan: {
          user_id: 'wrong'
        }
      }
    )
    put plan_url(plans(:simons_plan)), options

    assert_response :not_found
  end

  test 'should return 400 on invalid params in update put' do
    options = signed_in_as(users(:simon)).merge(
      params: {}
    )
    put plan_url(plans(:simons_plan)), options

    assert_response :bad_request
  end

  test 'should destroy plan' do
    assert_difference 'accounts(:jensen).plans.count', -1 do
      delete plan_url(plans(:simons_plan)), signed_in_as(users(:simon))
    end

    assert_response :success
  end

  test 'should not destroy plan on other account' do
    assert_no_difference 'Plan.count' do
      delete plan_url(plans(:simons_plan)), signed_in_as(users(:peter))
    end

    assert_response :not_found
  end
end
