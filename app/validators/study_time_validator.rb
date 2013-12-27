class StudyTimeValidator < ActiveModel::Validator
  
  def validate(record)
    #TODO validation of the study time
    timetable = record.timetable
    
    options[:timetable]
    if record.duration <= timetable.interval
      record.errors[:base] << "The duration must be bigger than the interval of the Timetable"
    end
  end
  
  
end
