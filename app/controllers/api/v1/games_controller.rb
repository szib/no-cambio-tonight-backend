# frozen_string_literal: true

class Api::V1::GamesController < ApplicationController
  include BoardGameAtlas::API

  # search games at BGA API
  def search
    games_data = BoardGameAtlas::API.search(params[:name])
    render json: games_data
  end

  # save a game by bga_id
  def save
    game = Game.find_by(bga_id: params[:bga_id])
    unless game
      game_data = BoardGameAtlas::API.find_by_id(params[:bga_id])
      game = Game.create_with(game_data).find_or_create_by(bga_id: game_data['bga_id'])
    end
    if game
      render json: game
    else
      render json: { error: 'Cannot save game.' }, status: 400
    end
  end

  private

  def search_params
    params.permit(:name)
  end

  def save_params
    params.permit(:bga_id)
  end
end
