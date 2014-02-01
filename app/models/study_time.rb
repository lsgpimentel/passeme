# == Schema Information
#
# Table name: study_times
#
#  id           :integer          not null, primary key
#  day          :integer          not null
#  from         :time             not null
#  to           :time             not null
#  productivity :integer          not null
#  timetable_id :integer          not null
#

class StudyTime < ActiveRecord::Base
  extend Enumerize

  default_scope -> { order(day: :asc, from: :asc) }

  belongs_to :timetable

  enumerize :day, in: { sunday: 1, monday: 2, tuesday: 3, wednesday: 4, thursday: 5, friday: 6, saturday: 7 }, predicates: true

  enumerize :productivity, in: { one: 1, two: 2, three: 3, four: 4, five: 5}, predicates: { prefix: true }

  validates :day, :from, :to, :productivity, :timetable, presence: true

  def duration
    to - from.to_i
  end
  def duration_in_seconds
    to - from
  end

  def arrange(study_times)

  end

end
