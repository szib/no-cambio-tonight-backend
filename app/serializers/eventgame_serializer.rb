class EventgameSerializer < ActiveModel::Serializer
  attribute :id
  has_one :owner, serializer: UserSerializer
  has_one :game
end
