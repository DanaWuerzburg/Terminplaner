class AddGroupsToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :group, :string
  end
end
