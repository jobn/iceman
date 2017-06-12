# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  belongs_to :account
  has_many :authentication_tokens, dependent: :destroy
  has_one :plan, dependent: :destroy

  def self.try_authenticate(email:, password:)
    find_by(email: email).try(:authenticate, password)
  end
end
