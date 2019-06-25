class GameSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :publisher, :year_published
  attributes :min_players, :max_players, :min_playtime, :max_playtime, :min_age, :average_user_rating
  attributes :image_thumb, :image_small, :image_medium, :image_large, :image_original, :rules_url

  attribute :number_of_owners
end
