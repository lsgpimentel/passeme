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
#  studied_time             :time
#  debt_reason              :integer
#  study_source_id          :integer          not null
#

class CalendarEvent < ActiveRecord::Base
  extend Enumerize
  include IceCubeMethods

  scope :to_study, -> { where(studied_time: nil) }
  scope :studied, -> { where('studied_time IS NOT NULL') }
  scope :studied_debt, -> { studied.where('debt_reason IS NOT NULL') }

  enumerize :debt_reason, in: { reason_one: 1, reason_two: 2, reason_three: 3, reason_four: 4, reason_five: 5}, predicates: { prefix: true }
  belongs_to :calendar_event_source

  belongs_to :study_source

  def delta_time
    from_time.to_s(:time) + " - " + to_time.to_s(:time)
  end

  def filled?

  end

  def in_debt?
    debt_reason != nil
  end

  def meta
    Time.at(to_time - from_time).utc
  end

  def subject
    calendar_event_source.subject
  end

end
