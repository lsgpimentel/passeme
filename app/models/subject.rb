# == Schema Information
#
# Table name: subjects
#
#  id               :integer          not null, primary key
#  created_at       :datetime
#  updated_at       :datetime
#  difficulty       :integer          not null
#  creator_id       :integer          not null
#  name             :string(255)      not null
#  importance       :integer          not null
#  subject_group_id :integer
#

class Subject < ActiveRecord::Base
  extend Enumerize

  scope :with_study_sources, -> { joins(:study_sources).distinct }
  scope :not_in_calendar, -> (calendar) { where('subjects.id not in (select calendar_event_sources.subject_id from calendar_event_sources where calendar_event_sources.calendar_id = ?)', calendar.id) }

  enumerize :difficulty, in: { one: 1, two: 2, three: 3, four: 4, five: 5}, predicates: { prefix: true }
  enumerize :importance, in: { one: 1, two: 2, three: 3, four: 4, five: 5}, predicates: { prefix: true }

  has_and_belongs_to_many :study_sources, join_table: :subjects_study_sources

  belongs_to :creator, class_name: "User"

  belongs_to :subject_group

  #Can be in many calendar event_sources
  has_many :calendar_event_sources

  validates :name, :difficulty, :importance, :creator, presence: true

end
