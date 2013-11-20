class SubjectGroup < ActiveRecord::Base

  has_many :subjects, dependent: :nullify

end
