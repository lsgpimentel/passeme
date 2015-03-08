# == Schema Information
#
# Table name: follow_up_items
#
#  id                :integer          not null, primary key
#  calendar_event_id :integer          not null
#  studied_time      :time
#  debt_reason       :integer
#  created_at        :datetime
#  updated_at        :datetime
#  date              :date             not null
#  from_time         :time             not null
#  to_time           :time             not null
#

class FollowUpItem < ActiveRecord::Base
  extend Enumerize

  default_scope -> { includes(:calendar_event).order(date: :asc) }

  scope :studied, -> { where('studied_time IS NOT NULL') }
  scope :studied_debt, -> { studied.where('debt_reason IS NOT NULL') }
  scope :in_period, -> (start_date, end_date) { where('follow_up_items.date >= :start_date AND follow_up_items.date <= :end_date', start_date: start_date, end_date: end_date) }

  enumerize :debt_reason, in: { solve_urgent_problem: 1, procrastination: 2, health_problems: 3, no_motivation: 4, very_tired: 5, others: 6}, predicates: { prefix: true }, scope: true

  belongs_to :calendar_event

  validates :calendar_event, :date, :from_time, :to_time, presence: true

  def in_debt?
    debt_reason != nil
  end

  def studied_time_in_hours
    (studied_time - studied_time.beginning_of_day) / 3600
  end

end
