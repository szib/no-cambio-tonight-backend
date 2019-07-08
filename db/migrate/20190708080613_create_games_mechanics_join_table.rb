class CreateGamesMechanicsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :mechanics do |t|
      t.index :game_id
      t.index :mechanic_id
    end
  end
end
