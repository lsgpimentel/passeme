# == Schema Information
#
# Table name: calendars
#
#  id           :integer          not null, primary key
#  timetable_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Calendar < ActiveRecord::Base



  belongs_to :timetable
  has_many :calendar_event_sources
  has_many :calendar_events, through: :calendar_event_sources
  has_many :follow_up_items, through: :calendar_events
  has_many :subjects, through: :calendar_event_sources
  has_many :subject_groups, through: :subjects
  has_many :study_sources, through: :subjects

  accepts_nested_attributes_for :calendar_event_sources, allow_destroy: true

  #validates :timetable, presence: true
  validates_associated :calendar_event_sources
end
