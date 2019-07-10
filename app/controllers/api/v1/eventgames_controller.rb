# frozen_string_literal: true

class Api::V1::EventgamesController < ApplicationController
  before_action :find_event

  def index
    if @event
      render json: @event.gamepieces, root: "game_pieces", adapter: :json
    else
      render json: { error: 'Cannot find event' }, status: 404
    end
  end

  def create
    attendance = @event.attendances.find_by(attendee_id: current_user.id)
    gamepiece = current_user.gamepieces.find_by(id: params[:gamepiece_id])
    if attendance && gamepiece
      eventgame = Eventgame.find_or_create_by(gamepiece: gamepiece, attendance: attendance)
      render json: eventgame, root: "game_piece", adapter: :json
    else
        render json: { error: 'Cannot add game to the event' }, status: 400
    end
  end

  def destroy
    attendance = @event.attendances.find_by(attendee_id: current_user.id)
    eventgame = Eventgame.find_by(attendance: attendance, gamepiece_id: params[:gamepiece_id])
    if eventgame
      eventgame.destroy
      render json: { status: 'DELETED' }, status: 200
    else
      render json: { error: 'Cannot remove this game from the event' }, status: 404
    end
  end

  private

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end
end
