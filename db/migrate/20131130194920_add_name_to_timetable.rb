class AddNameToTimetable < ActiveRecord::Migration
  def change
    add_column :timetables, :name, :string
  end
end
