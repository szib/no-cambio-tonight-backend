class Game < ApplicationRecord
  has_many :gamepieces, dependent: :restrict_with_exception
  has_many :owners, through: :gamepieces

  def number_of_owners
    gamepieces.size
  end
end
