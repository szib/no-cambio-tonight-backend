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

  private

  # ========================================
  # Converts games from API to database game
  # data: json data from BGA API search
  # ========================================
  def convert_games(data)
    data['games'].map { |game| convert_game(game)}
  end

  def convert_game(bga_game)
    game = {}
    game['bga_id'] = bga_game['id']
    game['publisher'] = bga_game['primary_publisher']

    identical_keys = %w[
      name
      description
      year_published
      min_players
      max_players
      min_playtime
      max_playtime
      min_age
      average_user_rating
      rules_url
    ]
    identical_keys.each { |key| game[key] = bga_game[key] }

    bga_game['images'].keys.each { |key| game["image_#{key}"] = bga_game['images'][key] }

    game
  end

end
