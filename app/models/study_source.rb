# == Schema Information
#
# Table name: study_sources
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  type       :integer          not null
#  title      :string(255)      not null
#  author     :string(255)
#  creator_id :integer          not null
#

class StudySource < ActiveRecord::Base
  self.inheritance_column = :_type_disabled
  extend Enumerize

  default_scope -> { order('type DESC') }

  #TODO Complete with other types
  enumerize :type, in: { book: 0, class: 1, video: 2, audio: 3 }, predicates: { prefix: true }

  has_and_belongs_to_many :subjects, join_table: :subjects_study_sources

  belongs_to :creator, class_name: "User"

  has_many :calendar_events

  validates :type, :title, :creator, presence: true

end
