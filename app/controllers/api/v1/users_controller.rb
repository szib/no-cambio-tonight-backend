class Api::V1::UsersController < ApplicationController
  skip_before_action :require_login, only: %i[login create]

  def create
    user = User.new(user_registration_params)
    user.member_since = Date.today
    if user.save
      render json: { token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Cannot create user.' }, status: 400
    end
  end
  

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user
    else
      render json: { error: "User not found."}, status: 404
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: { token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Invalid username/password combination.' }, status: 401
    end
  end

  def validate
    user = current_user
    if user
      render json: { token: issue_token({ id: user.id }) }
    else
      render json: { error: 'Invalid token.' }, status: 401
    end
  end

  private

    def user_registration_params
      params.permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
    end
    
end
