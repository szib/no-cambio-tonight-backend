class Api::V1::CommentsController < ApplicationController
  before_action :find_event, only: %i[events_index events_create]

  def show
    @comment = Comment.find_by(params[:id])
    render json: @comment, root: 'comment', adapter: :json
  end

  def events_index
    if @event
      render json: @event.comments, root: 'comments', adapter: :json
    else
      render json: { error: 'Cannot find event' }, status: 400
    end
  end

  def events_create
    render json: { error: 'Not implemented' }, status: 418
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end

  def find_user
    @user = current_user
  end

end
