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
      search = EventsService::GeneticAlgorithm::GeneticSearch.new(get_normalize_study_times,
                                                                  @timetable.subjects,
                                                                  block_interval: @timetable.block_interval,
                                                                  block_size: @timetable.block_size,
                                                                  pomodoro_technique: @timetable.pomodoro_technique,
                                                                  spaced_repetition_time: @timetable.spaced_repetition_time)
      
      r = search.run
      r
    end

    def get_normalize_study_times
      grouped_sts = []
      #If the next block of availability is right after this,
      #we group the blocks to later divide then according the
      #block interval specified.
      @timetable.study_times.each_with_index do |st, i|
        last = grouped_sts.last
        if last.present? && st.day == last.day && (st.to + 1.minute) >= last.from
          #Merge the blocks
          last.to = st.to
          
        else
          grouped_sts << st

        end

      end

      new_sts = []
      grouped_sts.each do |st|
        blocks = st.duration_in_seconds / @timetable.block_size_in_seconds

        #We truncate the number of blocks, so we only create complete blocks here
        blocks.truncate.times do |i|
          new_st = st.dup
          #In case it's the first block we use the original from's time
          #of the grouped (not normalized) study time
          if i != 0
            new_st.from = new_sts.last.to + 1.minute
          end
          new_st.to = new_st.from + @timetable.block_size_in_seconds
          new_sts << new_st
        end

        #If any incomplete block is left, we create it anyway
        #with what is left
        if blocks % 1 > 0
          new_st = st.dup

          #If this incomplete block is not the only one that we have
          if blocks.truncate != 0
            new_st.from = new_sts.last.to + 1.minute
          end

          #We subtract some minutes because of the 1.minute that we
          #add to separate the blocks
          new_st.to = new_st.from + (@timetable.block_size_in_seconds * (blocks % 1)) - blocks.truncate.minutes
          new_sts << new_st
        end

      end

      new_sts

    end

    #Return the next day in the week
    #The number of the day should be 0..6 (sunday..saturday)
    def next_day(date, number_of_day)
      date += 1 + (((number_of_day-1)-date.wday) % 7)
    end

  end
end
