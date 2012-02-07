class AddFieldsToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :priority_number, :integer, :group
  end
end
