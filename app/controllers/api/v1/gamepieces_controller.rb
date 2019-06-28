# frozen_string_literal: true

class Api::V1::GamepiecesController < ApplicationController
  include BoardGameAtlas::API

  before_action :require_login
  before_action :find_user

  def index
    if @user
      render json: @user.gamepieces
    else
      render json: { error: 'Invalid user id' }, status: 404
    end
  end

  def create
    game = Game.find_by(bga_id: params[:bga_id])
    unless game
      # fetch and save game
      game_data = BoardGameAtlas::API.find_by_id(params[:bga_id])
      game = Game.create_with(game_data).find_or_create_by(bga_id: game_data['bga_id'])
      Gamepiece.create(owner: @user, game: game)
    end

    gp = Gamepiece.find_by(owner: @user, game: game)
    gp ||= Gamepiece.create(owner: @user, game: game)
    render json: gp
  end

  def destroy
    gp = Gamepiece.find_by(id: params[:id])
    if gp && gp.owner === current_user
      gp.destroy
      render json: { status: 'DELETED' }, status: 200
    else
      render json: { error: 'Cannot delete this game' }, status: 404
    end
  end

  private

  def find_user
    @user = current_user
  end
end
