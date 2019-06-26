class User < ApplicationRecord
  has_secure_password

  has_many :organised_events, class_name: 'Event', foreign_key: :organiser_id, dependent: :destroy

  has_many :attendances, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :attendances, source: :event

  has_many :gamepieces, foreign_key: :owner_id, dependent: :destroy
  has_many :games, through: :gamepieces

  validates :username, uniqueness: { case_sensitive: false }

  validates :password, presence: true, on: [:create]
  validates :password_confirmation, presence: true, on: [:create]
end
