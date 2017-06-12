# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :plan
  default_scope { order(:starts_at) }

  validates :title, presence: true
end
