# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :plan_id, :title, :color, :starts_at, :ends_at
end
