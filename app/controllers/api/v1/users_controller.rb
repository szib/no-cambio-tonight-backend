# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[signin create]

  def create
    user = User.new(user_registration_params)
    user.member_since = Date.today
    if user.save
      render json: { token: issue_token(id: user.id) }
    else
      e = Errors::CannotCreate.new what: 'user'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  def index
    users = User.all
    if users
      render json: users, root: "users", adapter: :json
    else
      render_not_found_error
    end
  end
  
  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, root: "user", adapter: :json
    else
      render_not_found_error
    end
  end

  # def destroy
  #   if current_user.destroy
  #     render json: { status: 'DELETED' }, status: 200
  #   else
  #     render json: { error: 'User not found.' }, status: 404
  #   end
  # end

  def signin
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: { token: issue_token(id: user.id) }
    else
      e = Errors::InvalidCredentials.new
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  def validate
    user = current_user
    render json: { token: issue_token(id: user.id) }
  end

  def profile
    render json: current_user, root: "user", adapter: :json
  end

  # def patch_profile
  #   user = current_user
  #   if user.update_attributes(patch_profile_params)
  #     render json: user, root: "user", adapter: :json
  #   else
  #     render json: { error: 'User not found.' }, status: 404
  #   end
  # end

  # def organised_events
  #   @events = current_user.organised_events
  #   render json: @events, root: "events", adapter: :json,
  #   each_serializer: EventsSerializer, current_user: current_user
  # end

  # def attended_events
  #   @events = current_user.attended_events
  #   render json: @events, root: "events", adapter: :json,
  #   each_serializer: EventsSerializer, current_user: current_user
  # end
  
  def upcoming_events
    user = current_user
    render json: user, root: "user", adapter: :json,
    serializer: UpcomingEventsSerializer
  end

  def gameitems
    user = User.find_by(id: params[:user_id])
    if user
      gameitems = user.gamepieces
      render json: gameitems, root: "gameitems", adapter: :json, include: '**'
    else
      render_not_found_error
    end
  end
  

  private

  def render_not_found_error
    e = Errors::NotFound.new what: 'User'
    render json: ErrorSerializer.new(e), status: e.status
  end

  def user_registration_params
    params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
  end

  def patch_profile_params
    params.permit(:email)
  end
end
