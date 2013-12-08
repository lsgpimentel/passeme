class MergeSyllabusAndTimetable < ActiveRecord::Migration
  def change
    change_table :timetables do |t|
      t.string :goal, null: false
      t.boolean :specific, default: false
      t.references :creator, null: false
    end
    remove_reference :timetables, :syllabus

    drop_table :syllabuses


  end
end
