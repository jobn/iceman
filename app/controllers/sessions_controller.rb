# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate, only: :destroy

  def create
    user = User.find_by(email: session_params[:email]).try(:authenticate, session_params[:password])

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
