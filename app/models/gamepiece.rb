class Gamepiece < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :game

  has_many :eventgames
  has_many :attendances, through: :eventgames
end
