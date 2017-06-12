# frozen_string_literal: true

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid plans(:simons_plan)
  end

  test '.user returs the associated user' do
    assert_equal plans(:simons_plan).user, users(:simon)
  end
end
