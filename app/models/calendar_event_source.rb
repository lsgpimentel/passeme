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

  default_scope { includes(:subject) }

  belongs_to :calendar
  belongs_to :subject
  has_many :calendar_events

  accepts_nested_attributes_for :calendar_events, allow_destroy: true

  #validates :subject, :color, :calendar, presence: true

  validates_associated :calendar_events

  def name
    subject.name
  end
end
