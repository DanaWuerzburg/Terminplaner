class RemoveTimeToAppointments < ActiveRecord::Migration
  def up
    remove_column :appointments, :time
  end

  def down
  end
end
