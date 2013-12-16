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

  scope :studied, -> { where('studied_time IS NOT NULL') }
  scope :studied_debt, -> { studied.where('debt_reason IS NOT NULL') }

  enumerize :debt_reason, in: { reason_one: 1, reason_two: 2, reason_three: 3, reason_four: 4, reason_five: 5}, predicates: { prefix: true }

  belongs_to :calendar_event

  def in_debt?
    debt_reason != nil
  end
end
