class GamepieceSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :game_id
  belongs_to :owner, serializer: UserSerializer
  belongs_to :game, serializer: GameSerializer
end
