class AddSubjectStudySourceToCalendarEvent < ActiveRecord::Migration
  def change
    change_table :calendar_events do |t|
      t.references :study_source, null: false
    end
  end
end
