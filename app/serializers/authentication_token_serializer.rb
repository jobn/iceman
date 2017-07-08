# frozen_string_literal: true

class AuthenticationTokenSerializer < ActiveModel::Serializer
  attributes :token
  belongs_to :user
end
