# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  is_read     :boolean          default(FALSE)
#  type        :integer          not null
#  user_id     :integer
#  object_id   :integer
#  object_type :string(255)
#  sent_to     :integer          not null
#

class Notification < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  extend Enumerize
  default_scope -> { order('created_at DESC') }

  belongs_to :user
  belongs_to :object, polymorphic: :true

  enumerize :type, in: { group_blabla: 1, group_bla2: 2, syllabus_blabla: 3, syllabus_blabla2: 4 }, predicates: { prefix: true }
  enumerize :sent_to, in: { phone: 1, email: 2, site: 3 }, predicates: { prefix: true }, scope: :sent_to
end
