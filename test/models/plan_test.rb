# frozen_string_literal: true

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid plans(:simons_plan)
  end

  test '.user returs the associated user' do
    assert_equal plans(:simons_plan).user, users(:simon)
  end

  test '.events returns array of associated events' do
    assert_includes plans(:simons_plan).events, events(:simon_eats_breakfast)
    refute_includes plans(:simons_plan).events, events(:peter_gets_up)
  end

  test 'associated events are destroyed when plan is destroyed' do
    assert_difference 'Event.count', -1 do
      plans(:peters_plan).destroy
    end
  end
end
