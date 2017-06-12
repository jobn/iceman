# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid users(:simon)
  end

  test "simon can be authenticated with password 'password'" do
    assert users(:simon).try(:authenticate, 'password')
  end

  test '.account returns associated account' do
    assert_equal users(:simon).account, accounts(:jensen)
  end

  test '.plan returns the associated plan' do
    assert_equal users(:simon).plan, plans(:simons_plan)
  end

  test 'associated plans are destroyed when user is destroyed' do
    assert_difference 'Plan.count', -1 do
      users(:simon).destroy
    end
  end

  test 'associated authentication_tokens are destroyed when user is destroyed' do
    assert_difference 'AuthenticationToken.count', -1 do
      users(:peter).destroy
    end
  end
end
