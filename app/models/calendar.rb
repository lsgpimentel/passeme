class Calendar < ActiveRecord::Base
  belongs_to :timetable
  has_many :calendar_event_sources
  has_many :subjects, through: :calendar_event_sources
  has_many :subject_groups, through: :subjects

  #accepts_nested_attributes_for :calendar_event_sources, allow_destroy: true
end
