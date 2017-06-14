# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :plans, through: :users
end
