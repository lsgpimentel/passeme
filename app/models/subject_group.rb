# == Schema Information
#
# Table name: subject_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class SubjectGroup < ActiveRecord::Base

  has_many :subjects, dependent: :nullify

end
