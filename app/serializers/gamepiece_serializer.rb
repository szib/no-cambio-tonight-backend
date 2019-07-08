class GamepieceSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :game_id
  attribute :game, serializer: GameSerializer
  belongs_to :game, serializer: GameSerializer
end
