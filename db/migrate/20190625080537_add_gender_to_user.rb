class AddGenderToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer, default: 0
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
