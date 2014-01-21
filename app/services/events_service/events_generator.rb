module EventsService
  class EventsGenerator
    def initialize(timetable)
      @timetable = timetable

      @chromosome = run
    end


    # def event_sources
    #   #TODO calculo maluco para gerar a parada
    #   if @timetable.study_times.present?
    #     sources = []
    #     3.times do
    #       s =  CalendarEventSource.new(subject: Subject.first, color: "F4F4F4")
    #       3.times do
    #         s.calendar_events.build(date: Date.current, from_time: Time.current - 5.hours, to_time: Time.current, study_source: StudySource.first, repeats: 'never')
    #         sources << s
    #       end
    #     end
    #     sources
    #   end
    # end

    def event_sources
      dfgdfg
      sources = []
      colors = SimpleColorPicker::COLORS.values
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
                                     repeats_weekly_each_days_of_the_week_mask: '', #TODO
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
      p normalize_study_times
      search = EventsService::GeneticAlgorithm::GeneticSearch.new(@timetable.study_times,
                                                                  @timetable.subjects,
                                                                  block_interval: @timetable.block_interval,
                                                                  block_size: @timetable.block_size,
                                                                  pomodoro_technique: @timetable.pomodoro_technique,
                                                                  spaced_repetition_time: @timetable.spaced_repetition_time)
      search.run
    end

    def normalize_study_times
      sts = @timetable.study_times
      #If the next block of availability is right after this,
      #we group the blocks to later divide then according the
      #block interval specified.
      sts.each_with_index do |st, i|
        if sts[i+1].present? && (st.to + 1.minute) >= sts[i+1].from
          #Merge the blocks
          st.to = sts[i+1].to
          sts.delete_at(i+1)
        end

      end

      sts.each do |st|
        diff = st.duration - @timetable.block_size
        if diff > 0


        end
      end

      sts

    end

    #Return the next day in the week
    #The number of the day should be 0..6 (sunday..saturday)
    def next_day(date, number_of_day)
      date += 1 + (((number_of_day-1)-date.wday) % 7)
    end

  end
end
