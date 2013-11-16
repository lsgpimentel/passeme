class AddNoSpecificTimeToTimetables < ActiveRecord::Migration
  def change
    add_column :timetables, :no_specific_time, :boolean, default: false
  end
end
