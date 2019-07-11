class UpcomingEventsSerializer < ActiveModel::Serializer
  attributes :id
  has_many :organised_events, serializer: EventSerializer
  has_many :attended_events, serializer: EventSerializer
end 