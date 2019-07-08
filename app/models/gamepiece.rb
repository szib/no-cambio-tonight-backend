class Gamepiece < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :game

  has_many :eventgames, dependent: :destroy
  has_many :attendances, through: :eventgames

  has_many :categories, through: :game
  has_many :mechanics, through: :game
end
