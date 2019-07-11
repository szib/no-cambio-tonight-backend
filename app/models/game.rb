class Game < ApplicationRecord
  has_many :gamepieces, dependent: :restrict_with_exception
  has_many :owners, through: :gamepieces

  has_and_belongs_to_many :categories
  has_and_belongs_to_many :mechanics

  def number_of_owners
    gamepieces.size
  end
end
