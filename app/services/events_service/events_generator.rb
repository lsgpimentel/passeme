module EventsService
  class EventsGenerator

    attr_accessor :chromosome

    def initialize(timetable)
      @timetable = timetable

      @chromosome = run
    end

    def event_sources
      sources = []
      colors = SimpleColorPickerInput::COLORS.values
      @chromosome.unique_subjects.each do |s|
        sources << CalendarEventSource.new(subject: s, color: colors[rand(colors.length)])
      end

      @chromosome.data.each do |at|
        source = sources.find { |s| s.subject == at.subject }
        source.calendar_events.build(date: next_day(@timetable.start_date, at.study_time.day.value-1),
                                     from_time: at.study_time.from,
                                     to_time: at.study_time.to,
                                     study_source: at.study_source,
                                     repeats: 'weekly',
                                     repeats_every_n_weeks: 1,
                                     #TODO tá repetindo só no dia em que foi criado.
                                     #Seria bom ver alguma forma de saber logo todos os dias
                                     #em que se repete pra não ter que criar um evento pra
                                     #cada dia
                                     repeats_weekly_each_days_of_the_week_mask: 2**(at.study_time.day.value-1),
                                     repeat_ends: 'on',
                                     repeat_ends_on: @timetable.end_date
                                    )

      end

      sources

    end

    def events
      event_sources.map(&:calendar_events)
    end

    def validate
      #TODO validar os study times

    end


    private
    def run
      search = EventsService::GeneticAlgorithm::GeneticSearch.new(StudyTimesNormalization.new(@timetable).get_normalized,
                                                                  @timetable.subjects,
                                                                  block_interval: @timetable.block_interval,
                                                                  block_size: @timetable.block_size,
                                                                  pomodoro_technique: @timetable.pomodoro_technique,
                                                                  spaced_repetition_time: @timetable.spaced_repetition_time)
      
      r = search.run
      r
    end

    #Return the next day in the week
    #The number of the day should be 0..6 (sunday..saturday)
    def next_day(date, number_of_day)
      date += 1 + (((number_of_day-1)-date.wday) % 7)
    end

  end
end
