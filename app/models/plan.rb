# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :destroy
end
