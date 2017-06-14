# frozen_string_literal: true

class PlansController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  before_action :authenticate

  def index
    render json: plans
  end

  def show
    @plan = plans.find(params[:id])
    render json: @plan
  end

  def create
    @plan = target_user.create_plan
    render json: @plan, status: :created
  end

  def update
    @plan = plans.find(params[:id])
    @plan.update(user: target_user)
    render json: @plan
  end

  def destroy
    @plan = plans.find(params[:id])
    @plan.destroy
    render json: {}, status: :ok
  end

  private

  def target_user
    account.users.find(plan_params[:user_id])
  end

  def plan_params
    params.require(:plan).permit(:user_id)
  end

  def record_not_found
    render json: {}, status: :not_found
  end

  def parameter_missing
    render json: {}, status: :unprocessable_entity
  end
end
