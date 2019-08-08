# frozen_string_literal: true

class Api::V1::EventsController < ApplicationController
  before_action :find_event, only: %i[show cancel update]
  before_action :find_user, only: %i[cancel update]

  def create
    event = Event.new(event_params)
    event.organiser = current_user
    event.attendees << current_user
    if event.save
      render json: event, root: "event", adapter: :json
    else
      e = Errors::CannotCreate.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  def index
    @events = Event.all.sort_by(&:start_date_time).reverse
    if @events
      render json: @events, root: "events", adapter: :json,
      each_serializer: EventsSerializer, current_user: current_user, include: '**'
    else
      e = Errors::NotFound.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  def show
    if @event
      render json: @event, root: "event", adapter: :json, include: '**'
    else
      e = Errors::NotFound.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  # def update
  #   if @event.organiser === @user && @event.update_attributes(event_params)
  #     render json: @event, root: "event", adapter: :json, include: '**'
  #   else
  #     render json: { error: 'Cannot update event.' }, status: 404
  #   end
  # end

  def cancel
    if @event
      if @event.organiser === @user
        @event['is_cancelled'] = true
        if @event.save
          render json: @event, root: "event", adapter: :json, include: '**'
        else
          e = Errors::CannotCreate.new what: 'event'
          render json: ErrorSerializer.new(e), status: e.status
        end

      else
        e = Errors::InsufficientPermission.new
        render json: ErrorSerializer.new(e), status: e.status
      end
    else
      e = Errors::NotFound.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :location, :start_date_time, :end_date_time, :capacity)
  end

  def find_event
    @event = Event.find_by(id: params[:id])
  end

  def find_user
    @user = current_user
  end
end
