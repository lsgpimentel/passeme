class CalendarEventSource < ActiveRecord::Base

  belongs_to :calendar
  belongs_to :subject
  has_many :calendar_events

  #accepts_nested_attributes_for :calendar_events, allow_destroy: true
end
