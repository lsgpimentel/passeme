# == Schema Information
#
# Table name: settings
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#

class Setting < ActiveRecord::Base
  has_many :notification_settings

  belongs_to :user

  accepts_nested_attributes_for :notification_settings

end
