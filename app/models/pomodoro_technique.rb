class PomodoroTechnique
  attr_accessor :time_short_break, :time_long_break


  def short_break_in_seconds
    time_short_break - time_short_break.at_beginning_of_day
  end

  def long_break_in_seconds
    time_long_break - time_long_break.at_beginning_of_day
  end

end
