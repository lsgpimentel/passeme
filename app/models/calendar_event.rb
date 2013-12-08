# == Schema Information
#
# Table name: calendar_events
#
#  id                       :integer          not null, primary key
#  calendar_event_source_id :integer          not null
#  title                    :string(255)      not null
#  schedule                 :text
#  date                     :date             not null
#  from_time                :time             not null
#  to_time                  :time             not null
#  created_at               :datetime
#  updated_at               :datetime
#

class CalendarEvent < ActiveRecord::Base
  include IceCube

  belongs_to :calendar_event_source

  has_one :follow_up_item


  def delta_time
    to_time - from_time
  end

end
