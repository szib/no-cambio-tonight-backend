class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :attendee, index: true
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_foreign_key :attendances, :users, column: :attendee_id
  end
end
