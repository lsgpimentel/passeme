class AddIntervalToStudyTime < ActiveRecord::Migration
  def change
    add_column :study_times, :interval, :time, null: false
  end
end
