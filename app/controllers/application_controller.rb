class ApplicationController < ActionController::API
  before_action :require_login

  def secret
    ENV['AUTH_SECRET']
  end

  def issue_token(data)
    JWT.encode(data, secret)
  end

  def decode_token
    begin
      a = JWT.decode(token, secret).first
    rescue
      {}
    end
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
        render json: {error: "Authentication error"}, status: 401
    end
  end

end
