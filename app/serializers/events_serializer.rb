class EventsSerializer < ActiveModel::Serializer

  attributes :id, :title, :location, :start_date_time, :end_date_time, :is_cancelled
  attributes :capacity, :number_of_attendees
  attributes :is_current_user_attending
  attributes :is_current_user_organising
  has_one :organiser, serializer: UserSerializer

  def is_current_user_attending
    !object.attendees.find_by(id: current_user.id).nil?
  end

  def is_current_user_organising
    object.organiser.id === current_user.id
  end

end