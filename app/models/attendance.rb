class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User', foreign_key: :attendee_id

  has_many :eventgames
  has_many :gamepieces, through: :eventgames
end
