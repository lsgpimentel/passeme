class RemoveColumnNoSpecificTimeFromTimetable < ActiveRecord::Migration
  def change
    remove_column :timetables, :no_specific_time
  end
end
