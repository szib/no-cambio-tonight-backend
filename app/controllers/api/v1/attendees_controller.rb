# frozen_string_literal: true

class Api::V1::AttendeesController < ApplicationController
  before_action :find_event

  # def index
  #   if @event
  #     render json: @event.attendees, root: "attendees", adapter: :json
  #   else
  #     render json: { error: 'Cannot find event' }, status: 404
  #   end
  # end

  def create
    @attendance = Attendance.find_or_create_by(event: @event, attendee: current_user)
    if @attendance.save
      render json: @attendance, serializer: AttendeeSerializer
    else
      render json: { error: 'Cannot create this attendance' }, status: 400
    end
  end

  def destroy
    attendance = @event.attendances.find_by(attendee: current_user)

    if attendance && attendance.attendee === current_user
      attendance.destroy
      render json: { status: 'DELETED' }, status: 200
    else
      render json: { error: 'Cannot delete this attendance' }, status: 404
    end
  end

  private

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
