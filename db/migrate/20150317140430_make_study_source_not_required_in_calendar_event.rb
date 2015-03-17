class MakeStudySourceNotRequiredInCalendarEvent < ActiveRecord::Migration
  def change
    change_column :calendar_events, :study_source_id, :integer, null: true
  end
end
