# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  creator_id :integer
#  name       :string(255)      not null
#  created_at :datetime         not null
#

class Group < ActiveRecord::Base

  #TODO migration
  belongs_to :creator, class_name: "User"
  has_and_belongs_to_many :participants, class_name: "User"
  #name of the group


end
