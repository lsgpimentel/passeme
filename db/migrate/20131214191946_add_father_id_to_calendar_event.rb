class AddFatherIdToCalendarEvent < ActiveRecord::Migration
  def change
    add_reference :calendar_events, :father, index: true
  end
end
