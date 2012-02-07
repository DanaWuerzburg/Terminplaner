class AddFieldsToFriendAppointment < ActiveRecord::Migration
  def change
    add_column :friendship_appointments, :shared_friend_id, :integer
    add_column :appointments, :shared_friend_id, :integer
  end
end
