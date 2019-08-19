class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :organiser, index: true
      t.string :title
      t.string :location
      t.datetime :date_time
      t.boolean :is_cancelled
      t.integer :capacity

      t.timestamps
    end

    add_foreign_key :events, :users, column: :organiser_id
  end
end
