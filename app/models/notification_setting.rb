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

  cattr_reader :default_notification_settings
  @@default_notification_settings = {
    group_blabla: [:phone, :site],
    group_bla2: [:email],
    syllabus_blabla: [:site],
    syllabus_blabla2: [:site, :phone, :email]
  }

  belongs_to :setting

  enumerize :type, in: { group_blabla: 1, group_bla2: 2, syllabus_blabla: 3, syllabus_blabla2: 4 }, predicates: { prefix: true }

end
