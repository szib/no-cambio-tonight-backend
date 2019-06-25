class GamepieceSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :game_id
  belongs_to :owner
  belongs_to :game 
end
