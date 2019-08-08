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
      e = Errors::NotFound.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end
  
  def events_create
    comment = Comment.new(comment_params)
    comment.commentable = @event
    if comment.save
      render json: @event.comments, root: 'comments', adapter: :json
    else
      e = Errors::CannotCreate.new what: 'comment'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end
  
  def gameitems_index
    gameitem = Gamepiece.find_by(id: params[:gameitem_id])
    if gameitem
      render json: gameitem.comments, root: 'comments', adapter: :json
    else
      e = Errors::NotFound.new what: 'event'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end
  
  def gameitems_create
    comment = Comment.new(comment_params)
    gameitem = Gamepiece.find_by(id: params[:gameitem_id])
    comment.commentable = gameitem
    if comment.save
      render json: gameitem.comments, root: 'comments', adapter: :json
    else
      e = Errors::CannotCreate.new what: 'comment'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  def comment_params
    params.permit(:author_id, :comment_text)
  end

  def find_event
    @event = Event.find_by(id: params[:event_id])
  end

  def find_user
    @user = current_user
  end

end
