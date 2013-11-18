# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  difficulty :integer          not null
#  creator_id :integer          not null
#  name       :string(255)      not null
#

class Subject < ActiveRecord::Base
  extend Enumerize

  enumerize :difficulty, in: { one: 1, two: 2, three: 3, four: 4, five: 5}, predicates: { prefix: true }
  enumerize :importance, in: { one: 1, two: 2, three: 3, four: 4, five: 5}, predicates: { prefix: true }

  has_many :allocated_subjects

  has_and_belongs_to_many :study_sources, join_table: :subjects_study_sources

  belongs_to :creator, class_name: "User"

  has_one :subject_group

end
