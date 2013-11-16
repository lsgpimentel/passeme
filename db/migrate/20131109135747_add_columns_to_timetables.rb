class AddColumnsToTimetables < ActiveRecord::Migration
  def change
    change_table :timetables do |t|
      t.boolean :active, default: false
      t.boolean :public, default: true

      t.references :syllabus, null: false
      t.references :forked_from
    end
  end
end
