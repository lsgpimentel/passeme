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

class CreateGroupActivity < Activity

  def notify
    self.owner.notify(:group_blabla, self.object)
  end

  def set_type
    self.type = :group_blabla
  end

end
