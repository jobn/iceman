# frozen_string_literal: true

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'requests require autnetication' do
    get plan_events_url(plans(:simons_plan))
    assert_response :unauthorized
  end

  test 'get /plans/:id/events should return all events for plan' do
    get plan_events_url(plans(:simons_plan)), signed_in_as(users(:simon))

    pattern = {
      data: [
        {
          id: events(:simon_gets_up).id.to_s,
          type: 'events'
        }.ignore_extra_keys!,
        {
          id: events(:simon_eats_breakfast).id.to_s,
          type: 'events'
        }.ignore_extra_keys!
      ]
    }

    assert_json_match pattern, response.body
    assert_response :success
  end

  test 'get /events/:id should return event' do
    event = events(:simon_gets_up)
    get event_url(event), signed_in_as(users(:simon))

    pattern = {
      data: {
        id: event.id.to_s,
        type: 'events',
        attributes: {
          title: event.title,
          color: event.color,
          'starts-at': event.starts_at,
          'ends-at': event.ends_at
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
    assert_response :success
  end

  test 'get /event/:id should return 401 for event on other account' do
    get event_url(events(:peter_gets_up)), signed_in_as(users(:simon))
    assert_response :not_found
  end

  test 'post /plans/:id/events creates event' do
    assert_difference 'plans(:simons_plan).events.count' do
      options = signed_in_as(users(:simon)).merge(
        params: {
          event: {
            title: 'Leave for school',
            color: 'blue',
            starts_at: '2017-06-12 07:40:00',
            ends_at: '2017-06-12 07:55:00'
          }
        }
      )

      post plan_events_url(plans(:simons_plan)), options
    end

    pattern = {
      data: {
        id: String,
        type: 'events',
        attributes: {
          title: 'Leave for school'
        }.ignore_extra_keys!,
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
    assert_response :created
  end

  test 'post /plans/:id/event should return 404 on invalid plan_id' do
    assert_no_difference 'Event.count' do
      options = signed_in_as(users(:simon)).merge(
        params: {
          event: {
            title: 'Leave for school',
            color: 'blue',
            starts_at: '2017-06-12 07:40:00',
            ends_at: '2017-06-12 07:55:00'
          }
        }
      )
      post plan_events_url('wrong'), options
    end

    assert_response :not_found
  end

  test 'post /plans/:id/event should return 400 on invalid params' do
    assert_no_difference 'Event.count' do
      options = signed_in_as(users(:simon)).merge(
        params: {}
      )
      post plan_events_url(plans(:simons_plan)), options
    end

    assert_response :bad_request
  end

  test 'post /plans/:id/events should return 400 on invalid event' do
    assert_no_difference 'Event.count' do
      options = signed_in_as(users(:simon)).merge(
        params: {
          event: {
            title: '',
            color: 'blue',
            starts_at: '2017-06-12 07:40:00',
            ends_at: '2017-06-12 07:55:00'
          }
        }
      )

      post plan_events_url(plans(:simons_plan)), options
    end

    assert_response :bad_request
  end

  test 'put /events/:id updates event' do
    options = signed_in_as(users(:simon)).merge(
      params: {
        event: {
          title: 'Stay in bed'
        }
      }
    )

    put event_url(events(:simon_gets_up)), options

    pattern = {
      data: {
        id: events(:simon_gets_up).id.to_s,
        type: 'events',
        attributes: {
          title: 'Stay in bed'
        }.ignore_extra_keys!
      }.ignore_extra_keys!
    }

    assert_json_match pattern, response.body
    assert_response :success
  end

  test 'put /events/:id should return 400 on invalid event' do
    options = signed_in_as(users(:simon)).merge(
      params: {
        event: {
          title: ''
        }
      }
    )

    put event_url(events(:simon_gets_up)), options
    assert_response :bad_request
  end

  test 'put /events/:id should return 404 on invalid id' do
    options = signed_in_as(users(:simon)).merge(
      params: {
        event: {
          title: 'Changed'
        }
      }
    )

    put event_url('wrong'), options
    assert_response :not_found
  end

  test 'delete /events/:id should delete event' do
    assert_difference 'Event.count', - 1 do
      delete event_url(events(:simon_gets_up)), signed_in_as(users(:simon))
    end

    assert_response :no_content
  end

  test 'delete /events/:id should return 404 on id from other account' do
    assert_no_difference 'Event.count' do
      delete event_url(events(:peter_gets_up)), signed_in_as(users(:simon))
    end

    assert_response :not_found
  end
end
