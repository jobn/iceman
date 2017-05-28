# frozen_string_literal: true

class CreateSession
  attr_reader :email, :password

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    user = User.try_authenticate(
      email: email,
      password: password
    )

    user.authentication_tokens.create if user
  end
end
