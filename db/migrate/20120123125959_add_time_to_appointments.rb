class AddTimeToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :time, :string
  end
end
