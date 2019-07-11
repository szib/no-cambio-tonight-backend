class Event < ApplicationRecord
  belongs_to :organiser, class_name: "User"

  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances
  has_many :eventgames, through: :attendances
  has_many :gamepieces, through: :eventgames

  has_many :comments,-> { order "created_at DESC" }, as: :commentable

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
