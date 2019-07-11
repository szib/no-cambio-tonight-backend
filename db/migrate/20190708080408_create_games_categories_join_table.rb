class CreateGamesCategoriesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :categories do |t|
      t.index :game_id
      t.index :category_id
    end
  end
end
