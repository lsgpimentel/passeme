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

class Activity < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  extend Enumerize

  has_many :notifications

  belongs_to :object, :polymorphic => :true
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  scope :with_object, lambda { |obj|
    where('object_id' => obj.id,'object_type' => obj.class.to_s)
  }

  enumerize :type, in: { group_blabla: 1, group_bla2: 2, syllabus_blabla: 3, syllabus_blabla2: 4 }, predicates: { prefix: true }

  #Notify of the creation of the activity.
  after_create :notify

  before_create :set_type

end
