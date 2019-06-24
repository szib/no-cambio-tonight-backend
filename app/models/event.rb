class Event < ApplicationRecord
  belongs_to :organiser, class_name: "User"

  has_many :attendances
  has_many :attendees, through: :attendances
end
