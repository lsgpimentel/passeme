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
#  block_interval :time             not null
#  block_size     :time             not null
#

class Timetable < ActiveRecord::Base

  #validates_with TimetableValidator

  scope :active_first, -> { order("active DESC") }
  before_create :make_active_on_create

  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :others_users_that_can_view, class_name: "User", join_table: :users_view_timetables, autosave: true
  has_one :forked_from, class_name: "Timetable"
  has_many :study_times, dependent: :destroy
  #validates_associated :study_times

  accepts_nested_attributes_for :study_times, allow_destroy: true

  has_one :calendar, autosave: true, dependent: :destroy

  has_many :calendar_event_sources, through: :calendar
  #has_many :subjects, through: :calendar_event_sources
  has_many :calendar_events, through: :calendar_event_sources
  has_many :follow_up_items, through: :calendar_events
  has_many :subject_groups, through: :subjects

  #accepts_nested_attributes_for :calendar, allow_destroy: true
  #accepts_nested_attributes_for :calendar_event_sources, allow_destroy: true
  #

  attr_accessor :use_pomodoro_technique, :pomodoro_technique
  attr_accessor :use_spaced_repetition, :spaced_repetition_percent_block_size
  attr_reader :start_date, :end_date
  attr_reader :subjects

  validates :name, :goal, :creator, :block_size, :block_interval, :start_date, :end_date, :spaced_repetition_percent_block_size, presence: true

  #validates_date :start_date, after: Date.current
  #validates_date :end_date, after: :start_date


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

  def subjects=(subjects)
    if subjects.all? { |s| s.is_a? Subject }
      @subjects = subjects
    else
      #Eager loading because we'll use the subject groups and study sources
      #to generate the calendar events in the algoritm
      @subjects = Subject.find(subjects.reject(&:blank?), include: [:study_sources, :subject_group])
    end
  end

  def start_date=(start_date)
    @start_date = Date.strptime(start_date, '%d/%m/%Y') 
  end

  def end_date=(end_date)
    @end_date = Date.strptime(end_date, '%d/%m/%Y') 
  end

  def spaced_repetition_percent_block_size=(percent)
    @spaced_repetition_percent_block_size = 1/Integer(percent)
  end

  def spaced_repetition_block_size_in_seconds
    spaced_repetition_percent_block_size * block_size_in_seconds
  end

  def block_size_in_seconds
    block_size - block_size.at_beginning_of_day
  end

  def block_interval_in_seconds
    block_interval - block_interval.at_beginning_of_day
  end

end
