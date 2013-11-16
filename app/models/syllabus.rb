# == Schema Information
#
# Table name: syllabuses
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)      not null
#  goal       :string(255)      not null
#  specific   :boolean          default(FALSE)
#  creator_id :integer          not null
#

class Syllabus < ActiveRecord::Base
  has_one :creator, class_name: "User"
  
  has_many :timetables

end
