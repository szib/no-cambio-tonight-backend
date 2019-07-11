class CreateEventgames < ActiveRecord::Migration[5.2]
  def change
    create_table :eventgames do |t|
      t.references :attendance, foreign_key: true
      t.references :gamepiece, foreign_key: true

      t.timestamps
    end
  end
end
