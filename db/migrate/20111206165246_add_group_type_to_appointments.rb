class AddGroupTypeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :grouptype, :group
  end
end
