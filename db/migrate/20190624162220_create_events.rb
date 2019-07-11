class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :organiser, foreign_key: true
      t.string :title
      t.string :location
      t.datetime :date_time
      t.boolean :is_cancelled
      t.integer :capacity

      t.timestamps
    end
  end
end
