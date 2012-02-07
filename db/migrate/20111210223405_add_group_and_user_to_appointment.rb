class AddGroupAndUserToAppointment < ActiveRecord::Migration

  def self.up
    add_column :appointments,  :group_id, :integer

    add_index :appointments, [:user_id]
    add_index :appointments, [:group_id]
  end

  def self.down
    remove_column :appointments, :group_id
  end
end
