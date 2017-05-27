# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate

  def current
    render json: current_user, status: :ok
  end
end
