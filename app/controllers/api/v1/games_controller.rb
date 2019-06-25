# frozen_string_literal: true

class Api::V1::GamesController < ApplicationController
  before_action :setup

  # search games at BGA API
  def search
    url = @base_url + "&name=#{params[:name]}"
    data = JSON.parse(RestClient.get(url))
    games_data = convert_games(data)
    render json: games_data
  end
  
  # save a game by bga_id
  # it might need to be refactored as a helper method for POST /users/:id/games
  def save
    url = @base_url + "&ids=#{params[:bga_id]}"
    data = JSON.parse(RestClient.get(url))
    game_data = convert_game(data['games'][0])
    game = Game.create_with(game_data).find_or_create_by(bga_id: game_data['bga_id'])
    if game
      render json: game
    else
      render json: { error: 'Cannot save game.' }, status: 400
    end
  end

  private

  def setup
    client_id = ENV['BGA_CLIENT_ID']
    @base_url = "https://www.boardgameatlas.com/api/search?client_id=#{client_id}"
  end

  def search_params
    params.permit(:name)
  end

  def save_params
    params.permit(:bga_id)
  end
end
