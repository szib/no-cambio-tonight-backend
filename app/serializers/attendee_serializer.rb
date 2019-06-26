class AttendeeSerializer < ActiveModel::Serializer
  has_one :attendee, serializer: UserSerializer
  has_one :event
end
