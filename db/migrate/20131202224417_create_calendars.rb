class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.references :timetable, null: false

      t.timestamps
    end

    add_reference :calendar_event_sources, :calendar, null: false
    remove_reference :calendar_event_sources, :timetable
  end
end
