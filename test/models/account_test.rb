# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid accounts(:jensen)
  end

  test '.users returns only associated users' do
    assert_includes accounts(:jensen).users, users(:simon)
    refute_includes accounts(:jensen).users, users(:peter)
  end

  test 'associated users are destroyed when account is destroyed' do
    assert_difference 'User.count', -1 do
      accounts(:hansen).destroy
    end
  end

  test '.plans returns plans associated through users' do
    assert_includes accounts(:jensen).plans, plans(:simons_plan)
    assert_includes accounts(:jensen).plans, plans(:simons_moms_plan)
  end
end
