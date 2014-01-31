# == Schema Information
#
# Table name: calendar_events
#
#  id                                          :integer          not null, primary key
#  calendar_event_source_id                    :integer          not null
#  date                                        :date             not null
#  from_time                                   :time             not null
#  to_time                                     :time             not null
#  created_at                                  :datetime
#  updated_at                                  :datetime
#  study_source_id                             :integer          not null
#  repeats                                     :string(255)
#  repeats_every_n_days                        :integer
#  repeats_every_n_weeks                       :integer
#  repeats_weekly_each_days_of_the_week_mask   :integer
#  repeats_every_n_months                      :integer
#  repeats_monthly                             :string(255)
#  repeats_monthly_each_days_of_the_month_mask :integer
#  repeats_monthly_on_ordinals_mask            :integer
#  repeats_monthly_on_days_of_the_week_mask    :integer
#  repeats_every_n_years                       :integer
#  repeats_yearly_each_months_of_the_year_mask :integer
#  repeats_yearly_on                           :boolean
#  repeats_yearly_on_ordinals_mask             :integer
#  repeats_yearly_on_days_of_the_week_mask     :integer
#  repeat_ends                                 :string(255)
#  repeat_ends_on                              :date
#  repeat_ends_count                           :integer
#  father_id                                   :integer
#  interval                                    :time
#

class CalendarEvent < ActiveRecord::Base
  include IceCubeMethods


  belongs_to :calendar_event_source

  belongs_to :study_source

  belongs_to :father, class_name: "CalendarEvent"

  has_many :follow_up_items
  has_many :revision_events, class_name: "CalendarEvent", foreign_key: "father_id"
  accepts_nested_attributes_for :revision_events, allow_destroy: true

  validates :calendar_event_source, :date, :from_time, :to_time, :study_source, presence: true

  def delta_time
    from_time.to_s(:time) + " - " + to_time.to_s(:time)
  end

  def meta
    Time.zone.at(to_time - from_time).utc
  end

  def subject
    calendar_event_source.subject
  end

end
