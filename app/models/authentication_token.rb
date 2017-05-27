# frozen_string_literal: true

require 'securerandom'

class AuthenticationToken < ApplicationRecord
  belongs_to :user
  before_create :set_token

  private

  def set_token
    self.token = generate_token unless token.present?
  end

  def generate_token
    SecureRandom.uuid.delete('-')
  end
end
