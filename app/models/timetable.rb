# == Schema Information
#
# Table name: timetables
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  active         :boolean          default(FALSE)
#  public         :boolean          default(TRUE)
#  forked_from_id :integer
#  name           :string(255)
#  goal           :string(255)      not null
#  specific       :boolean          default(FALSE)
#  creator_id     :integer          not null
#

class Timetable < ActiveRecord::Base

  scope :active_first, -> { order("active DESC") }
  before_create :make_active_on_create

  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :others_users_that_can_view, class_name: "User", join_table: :users_view_timetables, autosave: true
  has_one :forked_from, class_name: "Timetable"
  has_many :study_times, dependent: :destroy

  accepts_nested_attributes_for :study_times, allow_destroy: true

  has_one :calendar

  has_many :calendar_event_sources, through: :calendar
  has_many :subjects, through: :calendar_event_sources
  has_many :calendar_events, through: :calendar_event_sources
  has_many :follow_up_items, through: :calendar_events
  has_many :subject_groups, through: :subjects

  accepts_nested_attributes_for :calendar, allow_destroy: true
  #accepts_nested_attributes_for :calendar_event_sources, allow_destroy: true
  #

  attr_accessor :pomodoro_technique, :spaced_repetition

  def make_active
    #Deactive all other timetables from the user
    creator.timetables.delete_if {|t| t == self }.each do |t|
      t.update_attribute(:active, false)
    end
    update_attribute(:active, true)
  end

  def make_active_on_create
    if active?
      creator.timetables.each do |t|
        t.update_attribute(:active, false)
      end
    end
  end

end
