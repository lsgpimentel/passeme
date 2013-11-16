# == Schema Information
#
# Table name: allocated_subjects
#
#  id            :integer          not null, primary key
#  subject_id    :integer          not null
#  study_time_id :integer          not null
#  from          :time             not null
#  to            :time             not null
#  interval      :integer          default(0)
#

class AllocatedSubject < ActiveRecord::Base

  belongs_to :subject
  belongs_to :study_time
end
