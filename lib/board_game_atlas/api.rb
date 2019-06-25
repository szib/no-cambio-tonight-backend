module BoardGameAtlas
  module API
    class << self
      def setup
        client_id = ENV['BGA_CLIENT_ID']
        @base_url = "https://www.boardgameatlas.com/api/search?client_id=#{client_id}"
      end

      def search(name)
        setup
        url = @base_url + "&name=#{name}"
        data = JSON.parse(RestClient.get(url))
        games_data = convert_games(data)
        games_data
      end

      def find_by_id(bga_id)
        setup
        url = @base_url + "&ids=#{bga_id}"
        data = JSON.parse(RestClient.get(url))
        game_data = convert_game(data['games'][0])
        game_data
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
  end
end