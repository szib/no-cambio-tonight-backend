class GamepieceSerializer < ActiveModel::Serializer
  attributes :id, :owner_id, :game_id
  attribute :game, serializer: GameSerializer
  has_many :comments, serializer: CommentSerializer
  belongs_to :game, serializer: GameSerializer
end
