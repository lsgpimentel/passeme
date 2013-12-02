class CreateCalendarEvents < ActiveRecord::Migration
  def change
    create_table :calendar_events do |t|
      t.references :calendar_event_source, null: false
      t.string :title, null: false
      t.text :schedule
      t.date :date, null: false
      t.time :from_time, null: false
      t.time :to_time, null: false

      t.timestamps
    end
  end
end
