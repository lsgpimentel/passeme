# == Schema Information
#
# Table name: activities
#
#  id          :integer          not null, primary key
#  object_id   :integer
#  object_type :string(255)
#  owner_id    :integer
#  type        :integer          not null
#

class GroupCreateActivity < Activity
  
  NOTIFICATION_TYPE = :group_create

  def notify
    self.owner.notify(NOTIFICATION_TYPE, self.object)
  end

  def set_type
    self.type = :group_create
  end

end
