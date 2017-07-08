# frozen_string_literal: true

class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :color, :starts_at, :ends_at
  belongs_to :plan
end
