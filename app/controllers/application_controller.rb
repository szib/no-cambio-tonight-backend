# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :require_login

  def secret
    ENV['AUTH_SECRET']
  end

  def issue_token(data)
    JWT.encode(data, secret)
  end

  def decode_token
    JWT.decode(token, secret).first
  rescue StandardError
    {}
  end

  def current_user
    id = decode_token['id']
    User.find_by(id: id)
  end

  def token
    request.headers['Authorization'].split.second # first: Bearer, second: token
  end

  def require_login
    unless current_user
      e = Errors::Unauthorized.new
      render json: ErrorSerializer.new(e), status: e.status
    end
  end
end
