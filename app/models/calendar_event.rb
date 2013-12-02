class CalendarEvent < ActiveRecord::Base
  include IceCube

  belongs_to :calendar_event_source

end
