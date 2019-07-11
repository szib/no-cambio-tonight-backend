class Eventgame < ApplicationRecord
  belongs_to :attendance
  belongs_to :gamepiece
  has_one :game, through: :gamepiece
  has_one :owner, through: :attendance, source: :attendee
end
