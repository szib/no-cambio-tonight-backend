class AddEndTimeToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :date_time
    add_column :events, :end_date_time, :datetime, after: :location
    add_column :events, :start_date_time, :datetime, after: :location
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
