# == Schema Information
#
# Table name: timetables
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  active           :boolean          default(FALSE)
#  public           :boolean          default(TRUE)
#  syllabus_id      :integer          not null
#  forked_from_id   :integer
#  no_specific_time :boolean          default(FALSE)
#

class Timetable < ActiveRecord::Base

  belongs_to :syllabus
  has_and_belongs_to_many :others_users_that_can_view, class_name: "User", join_table: :users_view_timetables, autosave: true
  has_one :forked_from, class_name: "Timetable"
  has_many :study_times, dependent: :destroy

  accepts_nested_attributes_for :study_times, allow_destroy: true

  has_one :calendar

  has_many :calendar_event_sources, through: :calendar
  has_many :subjects, through: :calendar_event_sources
  has_many :subject_groups, through: :subjects

  #accepts_nested_attributes_for :calendar_event_sources, allow_destroy: true

end
