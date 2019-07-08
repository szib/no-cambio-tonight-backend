class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :bga_id
      t.string :name

      t.timestamps
    end
  end
end
