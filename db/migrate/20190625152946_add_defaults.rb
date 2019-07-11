class AddDefaults < ActiveRecord::Migration[5.2]
  def change
    change_column_default :events, :is_cancelled, from: nil, to: false
    change_column_default :events, :capacity, from: nil, to: 50
  end
end
