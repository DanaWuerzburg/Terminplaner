class ChangeAppointmentGroupToColour < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
  change_table :appointments do |t|
  t.rename :group, :colour
  end
  end
end
