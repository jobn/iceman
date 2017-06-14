# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authenticate

  def index
    @plans = current_user.account.plans
    render json: @plans
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
