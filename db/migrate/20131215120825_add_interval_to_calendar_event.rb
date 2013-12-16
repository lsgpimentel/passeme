class AddIntervalToCalendarEvent < ActiveRecord::Migration
  def change
    add_column :calendar_events, :interval, :time
  end
end
