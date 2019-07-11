class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :bga_id
      t.string :name
      t.text :description

      t.string :publisher
      t.integer :year_published

      t.integer :min_players
      t.integer :max_players
      t.integer :min_playtime
      t.integer :max_playtime
      t.integer :min_age
      t.float :average_user_rating
      
      t.string :image_thumb
      t.string :image_small
      t.string :image_medium
      t.string :image_large
      t.string :image_original
      t.string :rules_url

      t.timestamps
    end
  end
end
