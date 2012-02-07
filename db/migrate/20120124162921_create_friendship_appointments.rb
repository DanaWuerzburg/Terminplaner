class CreateFriendshipAppointments < ActiveRecord::Migration
  def change
    create_table :friendship_appointments do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :appointment_id

      t.timestamps
    end
  end
end
