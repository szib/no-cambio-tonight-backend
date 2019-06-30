class Event < ApplicationRecord
  belongs_to :organiser, class_name: "User"

  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances

  def gamelist
    attendances.map(&:gamepieces).flatten.map(&:game).uniq
  end

  def number_of_attendees
    attendees.size
  end

  def attending?(user = current_user)
    attendees.find_by(id: user.id)
  end
end
