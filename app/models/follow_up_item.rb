# == Schema Information
#
# Table name: follow_up_items
#
#  id                :integer          not null, primary key
#  calendar_event_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class FollowUpItem < ActiveRecord::Base
  extend Enumerize

  belongs_to :calendar_event

  enumerize :debt_reason, in: { reason_one: 1, reason_two: 2, reason_three: 3, reason_four: 4, reason_five: 5}, predicates: { prefix: true }

  def filled?

  end

  def in_debt?
    studied_time != calendar_event.delta_time
  end

  def net_hours
    calendar_event.from_time.to_s(:time) + " - " + calendar_event.to_time.to_s(:time)
  end

  def date
    calendar_event.date
  end

  def subject
    calendar_event.calendar_event_source.subject
  end

end
