# frozen_string_literal: true

class PlanSerializer < ActiveModel::Serializer
  attributes :id
  has_many :events
  belongs_to :user
end
