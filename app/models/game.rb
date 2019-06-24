class Game < ApplicationRecord
  has_many :gamepieces
  has_many :owners, through: :gamepieces
end
