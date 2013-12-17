# == Schema Information
#
# Table name: calendar_event_sources
#
#  id          :integer          not null, primary key
#  subject_id  :integer          not null
#  color       :string(255)      not null
#  created_at  :datetime
#  updated_at  :datetime
#  calendar_id :integer          not null
#

class CalendarEventSource < ActiveRecord::Base

  belongs_to :calendar
  belongs_to :subject
  has_many :calendar_events

  accepts_nested_attributes_for :calendar_events, allow_destroy: true

  def name
    subject.name
  end
end
