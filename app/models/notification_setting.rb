# == Schema Information
#
# Table name: notification_settings
#
#  id            :integer          not null, primary key
#  type          :integer          not null
#  setting_id    :integer
#  send_to_site  :boolean          default(FALSE)
#  send_to_email :boolean          default(FALSE)
#  send_to_phone :boolean          default(FALSE)
#

class NotificationSetting < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  extend Enumerize

  default_scope -> { order('type') }

  cattr_reader :types_and_where_they_can_be_sent
  @@types_and_where_they_can_be_sent = {
    task_before_overdue: [:email],
    follow_up_next_day: [:email],
    follow_up_next_month: [:email],
    follow_up_past_month:[:email],
    group_create: []
  }

  cattr_reader :new_user_default_notification_settings
  @@new_user_default_notification_settings = {
    task_before_overdue: [],
    follow_up_next_day: [:email],
    follow_up_next_month: [:email],
    follow_up_past_month:[:email],
    group_create: []
  }

  belongs_to :setting

  enumerize :type, in: { task_before_overdue: 1, follow_up_next_day: 2, follow_up_next_month: 3, follow_up_past_month: 4, group_create: 5 }, predicates: { prefix: true }

  validates :type, presence: true

end
