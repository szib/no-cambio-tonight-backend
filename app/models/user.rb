class User < ApplicationRecord
  has_secure_password

  has_many :organised_events, class_name: 'Event', foreign_key: :organiser_id

  validates :username, uniqueness: { case_sensitive: false }
  validates :password_confirmation, presence: true
end
