class AddBlockSizeToTimetable < ActiveRecord::Migration
  def change
    add_column :timetables, :block_size, :time, null: false
  end
end
