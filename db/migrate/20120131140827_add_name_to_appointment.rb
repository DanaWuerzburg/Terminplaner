class AddNameToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :name, :string
  end
end
