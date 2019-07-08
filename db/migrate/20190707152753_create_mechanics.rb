class CreateMechanics < ActiveRecord::Migration[5.2]
  def change
    create_table :mechanics do |t|
      t.string :bga_id
      t.string :name

      t.timestamps
    end
  end
end
