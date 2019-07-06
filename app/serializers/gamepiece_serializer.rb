class GamepieceSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :game_id
  # has_one :game
  attribute :game, serializer: GameSerializer
  belongs_to :game, serializer: GameSerializer
end
