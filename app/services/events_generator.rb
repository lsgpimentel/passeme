class EventsGenerator 
  def initialize(timetable)
    @timetable = timetable
  end

  def event_sources
    #TODO calculo maluco para gerar a parada
    if @timetable.study_times.present?
      [
        CalendarEventSource.new(subject: @timetable.creator.subjects[0], color: "F4F4F4"),
        CalendarEventSource.new(subject: @timetable.creator.subjects[0], color: "F4F4F4")
      ]
    end
  end

  def events

  end


  private

end
