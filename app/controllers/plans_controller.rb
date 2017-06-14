# frozen_string_literal: true

class PlansController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authenticate

  def index
    @plans = current_user.account.plans
    render json: @plans
  end

  def show
    @plan = current_user.account.plans.find(params[:id])
    render json: @plan
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def record_not_found
    render json: 'Not found', status: :not_found
  end
end
