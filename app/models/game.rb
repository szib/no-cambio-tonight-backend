class Game < ApplicationRecord
  has_many :gamepieces
  has_many :owners, through: :gamepieces


  def number_of_owners
    gamepieces.map(&:owner).count
  end
end
