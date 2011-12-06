class ChangeAppointmentGroupToColour < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
  change_table :appointments do |t|
    t.add_column :grouptype, :group
  end
  end
end
