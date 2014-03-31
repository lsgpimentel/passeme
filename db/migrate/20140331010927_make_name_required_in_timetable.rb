class MakeNameRequiredInTimetable < ActiveRecord::Migration
  def change
    change_column :timetables, :name, :string, null: false
  end
end
