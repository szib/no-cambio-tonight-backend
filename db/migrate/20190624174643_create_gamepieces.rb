class CreateGamepieces < ActiveRecord::Migration[5.2]
  def change
    create_table :gamepieces do |t|
      t.references :owner, true: true
      t.references :game, foreign_key: true

      t.timestamps
    end

    add_foreign_key :gamepieces, :users, column: :owner_id
  end
end
