# frozen_string_literal: true

class EventsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  before_action :authenticate

  def index
    @plan = plans.find(params[:plan_id])
    render json: @plan.events
  end

  def show
    @event = account.events.find(params[:id])
    render json: @event
  end

  def create
    @plan = plans.find(params[:plan_id])
    @event = @plan.events.build(event_params)

    if @event.save
      render json: @event, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def update
    @event = account.events.find(params[:id])
    if @event.update(event_params)
      render json: @event, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def destroy
    @event = account.events.find(params[:id])
    @event.destroy
    render json: {}, status: :no_content
  end

  private

  def event_params
    params.require(:event).permit(:title, :color, :starts_at, :ends_at)
  end

  def record_not_found
    render json: {}, status: :not_found
  end

  def parameter_missing
    render json: {}, status: :bad_request
  end
end
