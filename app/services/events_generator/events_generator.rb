module EventsService
  class EventsGenerator
    def initialize(study_times)
      @study_times = study_times

      run
    end


    def _event_sources
      #TODO calculo maluco para gerar a parada
      if @study_times.present?
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

    def validate

    end


    private
    def run
      search = EventsService::GeneticAlgorithm::GeneticSearch.new(study_times, subjects)
      result = search.run
      p result
    end

  end
end
