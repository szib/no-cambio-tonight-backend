# frozen_string_literal: true

class Api::V1::GamepiecesController < ApplicationController
  include BoardGameAtlas::API

  before_action :require_login
  before_action :find_user

  def index
    render json: @user.gamepieces, root: "game_pieces", adapter: :json, include: '**'
  end

  def show
    gp = Gamepiece.find_by(id: params[:id])
    if gp && gp.owner === current_user
      render json: gp, status: 200, include: '**'
    else
      e = Errors::InsufficientPermission.new
      render json: ErrorSerializer.new(e), status: e.status
    end
  end
  
  def show2
    gp = Gamepiece.find_by(id: params[:id])
    if gp
      render json: gp, status: 200,root: "gameitem", adapter: :json, include: '**'
    else
      e = Errors::NotFound.new what: 'Gamepiece'
      render json: ErrorSerializer.new(e), status: e.status
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
    render json: gp, root: "game_piece", adapter: :json, include: '**'
  end

  def destroy
    gp = Gamepiece.find_by(id: params[:id])
    if gp && gp.owner === current_user
      gp.destroy
      render json: { status: 'DELETED' }, status: 200
    else
      e = Errors::CannotDelete.new what: 'gamepiece'
      render json: ErrorSerializer.new(e), status: e.status
    end
  end

  private

  def find_user
    @user = current_user
  end
end
