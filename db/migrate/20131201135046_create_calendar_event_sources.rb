class CreateCalendarEventSources < ActiveRecord::Migration
  def change
    create_table :calendar_event_sources do |t|
      t.references :timetable, null: false
      t.references :subject, null: false
      t.string :color, null: false

      t.timestamps
    end
  end
end
