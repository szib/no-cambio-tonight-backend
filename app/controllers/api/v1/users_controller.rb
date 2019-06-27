# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[signin create]

  def create
    user = User.new(user_registration_params)
    user.member_since = Date.today
    if user.save
      render json: { token: issue_token(id: user.id) }
    else
      render json: { error: 'Cannot create user.' }, status: 400
    end
  end

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: { error: 'User not found.' }, status: 404
    end
  end

  def destroy
    if current_user.destroy
      render json: { status: 'DELETED' }, status: 200
    else
      render json: { error: 'User not found.' }, status: 404
    end
  end

  def signin
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: { token: issue_token(id: user.id) }
    else
      render json: { error: 'Invalid username/password combination.' }, status: 401
    end
  end

  def validate
    user = current_user
    if user
      render json: { token: issue_token(id: user.id) }
    else
      render json: { error: 'Invalid token.' }, status: 401
    end
  end

  def profile
    render json: current_user
  end

  def patch_profile
    user = current_user
    if user.update_attributes(patch_profile_params)
      render json: user
    else
      render json: { error: 'User not found.' }, status: 404
    end
  end

  def events
    render json: current_user.organised_events
  end

  private

  def user_registration_params
    params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
  end

  def patch_profile_params
    params.permit(:email)
  end
end
