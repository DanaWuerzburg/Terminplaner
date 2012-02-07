class AddAppointmentToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :appointment_id, :integer
  end
end
