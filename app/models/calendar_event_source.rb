class CalendarEventSource < ActiveRecord::Base

  belongs_to :timetable
  belongs_to :subject
  has_many :calendar_events

end
