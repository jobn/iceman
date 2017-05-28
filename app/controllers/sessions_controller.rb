# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate, only: :destroy

  def create
    user = User.try_authenticate(
      email: session_params[:email],
      password: session_params[:password]
    )

    if user
      @token = user.authentication_tokens.create
      render json: @token, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end

  def destroy
    @token.destroy
    render json: {}, status: :ok
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
