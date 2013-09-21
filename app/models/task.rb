# == Schema Information
#
# Table name: tasks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  done       :boolean
#  due_in     :date
#  user_id    :integer
#

class Task < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }

  validates :name, presence: true
  validates :user_id, presence: true
  validates :due_in, allow_nil: true, timeliness: { after: Date.current }


  def toggle_done!
    self.toggle!(:done)
  end

end
