class ChangeDateFromAppointment < ActiveRecord::Migration
  def up
      rename_column :appointments, :date, :start_at
      add_column :appointments, :end_at, :datetime
  end
  def down
      rename_column :appointments, :start_at, :date
      remove_column :appointments, :end_at
  end

end
