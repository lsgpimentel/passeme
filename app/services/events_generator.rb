class EventsGenerator 
  def initialize(timetable)
    @timetable = timetable
  end

  def event_sources
    #TODO calculo maluco para gerar a parada
    if @timetable.study_times.present?
      sources = []
      3.times do
        s =  CalendarEventSource.new(subject: @timetable.creator.subjects[0], color: "F4F4F4")
        3.times do
          s.calendar_events.build(date: Date.current, from_time: Time.current - 5.hours, to_time: Time.current, study_source: @timetable.creator.study_sources[0], repeats: 'never')
          sources << s
        end
      end
      sources
    end
  end

  def events

  end


  private

end
