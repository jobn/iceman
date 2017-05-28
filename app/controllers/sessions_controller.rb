# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate, only: :destroy

  def create
    token = CreateSession.new(
      email: session_params[:email],
      password: session_params[:password]
    ).call

    if token
      render json: token, status: :ok
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
