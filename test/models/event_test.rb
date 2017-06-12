# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'fixture is valid' do
    assert_valid events(:simon_gets_up)
  end

  test 'must have title' do
    without_title = events(:simon_gets_up)
    without_title.update_attributes(title: nil)
    assert_invalid without_title
  end

  test '.plan returns associated plan' do
    assert_equal events(:simon_gets_up).plan, plans(:simons_plan)
  end

  test 'events are ordered by starts_at' do
    events = plans(:simons_plan).events
    assert events.index(events(:simon_gets_up)) < events.index(events(:simon_eats_breakfast)), 'ordering is wrong'
  end
end
