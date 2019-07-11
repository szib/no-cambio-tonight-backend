class CreateGamepieces < ActiveRecord::Migration[5.2]
  def change
    create_table :gamepieces do |t|
      t.references :owner, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
