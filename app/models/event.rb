class Event < ApplicationRecord
  belongs_to :organiser, class_name: "User"

  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances

  def gamelist
    attendances.map(&:gamepieces).flatten.map(&:game).uniq
  end

  def number_of_attendees
    attendees.count
  end
end
