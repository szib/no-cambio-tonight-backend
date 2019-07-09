class Api::V1::CommentsController < ApplicationController

  def show
    @comment = Comment.find_by(params[:id])
    render json: @comment, root: 'comment', adapter: :json
  end
end
