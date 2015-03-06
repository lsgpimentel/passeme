# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  done       :boolean          default(FALSE)
#  due_in     :date
#  user_id    :integer          not null
#

class Task < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }

  belongs_to :user
  validates :name, :user, presence: true
  validates :due_in, allow_nil: true, allow_blank: true, timeliness: { after: Date.current }

  has_many :notifications, as: :object, dependent: :destroy

  def toggle_done!
    self.toggle!(:done)
  end

end
