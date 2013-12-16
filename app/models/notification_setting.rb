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

  cattr_reader :default_notification_settings
  @@default_notification_settings = {
    task_before_overdue: [:site],
    follow_up_next_day: [:site],
    follow_up_next_month: [:site],
    follow_up_past_month:[:site]
  }

  belongs_to :setting

  enumerize :type, in: { task_before_overdue: 1, follow_up_next_day: 2, follow_up_next_month: 3, follow_up_past_month: 4 }, predicates: { prefix: true }

end
