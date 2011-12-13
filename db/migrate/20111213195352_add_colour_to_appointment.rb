class AddColourToAppointment < ActiveRecord::Migration
  def change
    add_column :appointments, :colour, :string
  end
end
