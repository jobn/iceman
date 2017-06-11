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
end
