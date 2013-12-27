class RemoveIntervalFromStudyTime < ActiveRecord::Migration
  def change
    remove_column :study_times, :interval
    add_column :timetables, :block_interval, :time, null: false
  end
end
