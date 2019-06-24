class User < ApplicationRecord
  has_secure_password

  has_many :organised_events, class_name: 'Event', foreign_key: :organiser_id

  has_many :attendances, foreign_key: :attendee_id
  has_many :attended_events, through: :attendances, source: :event

  validates :username, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
end
