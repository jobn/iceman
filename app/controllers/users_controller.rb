# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate

  def show
    render json: account.users.find(params[:id])
  end

  def index
    render json: current_user.account.users
  end
end
