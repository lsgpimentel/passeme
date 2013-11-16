class CreateStudyTimes < ActiveRecord::Migration
  def change
    create_table :study_times do |t|
      t.integer :day, null: false
      t.time :from, null: false
      t.time :to, null: false
      t.integer :productivity, null: false

      t.references :timetable, null: false
    end
  end
end
