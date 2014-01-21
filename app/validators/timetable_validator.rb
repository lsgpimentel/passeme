class TimetableValidator < ActiveModel::Validator

  def validate(record)
    study_times(record)

  end

  private

  def study_times(timetable)
    interval = timetable.block_interval - timetable.block_interval.beginning_of_day
    timetable.study_times.each do |st|
      if st.duration <= interval
        st.errors[:base] << "The duration must be bigger than the interval of the Timetable"
      end
    end
  end


end
