class AddFriendToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :friend_id, :integer

    add_index :appointments, [:friend_id]
  end
end
