# frozen_string_literal: true

class Api::V1::EventsController < ApplicationController
  before_action :find_event, only: [:show, :cancel]
  before_action :find_user, only: [:cancel]

  def create; end

  def index
    @events = Event.all
    if @events
      render json: @events
    else
      render json: { error: 'Cannot find event' }, status: 404
    end
  end

  def show
    if @event
      render json: @event
    else
      render json: { error: 'Cannot find event' }, status: 404
    end
  end
  
  def cancel
    if @event && @event.organiser === @user
      @event['is_cancelled'] = true
      if @event.save
        render json: @event
      else
        render json: { error: 'Cannot save event' }, status: 500
      end
    else
      render json: { error: 'Cannot find event or you are not the organizer' }, status: 400
    end
  end

  private

  def find_event
    @event = Event.find_by(id: params[:id])
  end

  def find_user
    @user = current_user
  end
end
