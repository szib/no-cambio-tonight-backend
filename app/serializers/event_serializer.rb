class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :location, :date_time, :is_cancelled, :capacity, :number_of_attendees
  has_one :organiser, serializer: UserSerializer
  has_many :attendees, serializer: UserSerializer
  has_one :gamelist
end
