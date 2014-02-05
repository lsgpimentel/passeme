module EventsService
  class EventsGenerator

    attr_accessor :chromosome
    attr_accessor :result

    def initialize(timetable)
      @timetable = timetable

      @result = run
      @chromosome = @result[:chromosomes].last
    end

    def event_sources
      sources = []
      colors = SimpleColorPickerInput::COLORS.values
      @chromosome.unique_subjects.each do |s|
        sources << CalendarEventSource.new(subject: s, color: colors[rand(colors.length)])
      end

      @chromosome.data.each do |at|
        source = sources.find { |s| s.subject == at.subject }
        event = source.calendar_events.build(date: next_day(@timetable.start_date, at.study_time.day.value-1),
                                             from_time: at.study_time.from,
                                             to_time: at.study_time.to,
                                             study_source: at.study_source,
                                             repeats: 'weekly',
                                             repeats_every_n_weeks: 1,
                                             repeats_weekly_each_days_of_the_week_mask: 2**(at.study_time.day.value-1),
                                             repeat_ends: 'on',
                                             repeat_ends_on: @timetable.end_date
                                            )


        # create_revision_event_for(event) if @timetable.use_spaced_repetition

      end

      # @chromosome.grouped_by_days.each do |day, alloc_times|
      #   total_day_revision_time = @timetable.spaced_repetition_block_size_in_seconds * alloc_times.size
      #   RevisionsGenerator::DEFAULT_REVISIONS_INTERVAL.each do

      #   end
      # end


      # time_revision_events = {}
      # sources.each do |s|
      #   time_revision_events[s.subject] = @timetable.spaced_repetition_block_size_in_seconds * s.calendar_events.size
      # end

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
      normalized_study_times = StudyTimesNormalization.new(@timetable).get_normalized
      # mark_revision_events(normalized_study_times)

      search = EventsService::GeneticAlgorithm::GeneticSearch.new(normalized_study_times, @timetable.subjects)
      search.run
    end

    #Return the next day in the week
    #The number of the day should be 0..6 (sunday..saturday)
    def next_day(date, number_of_day)
      date += 1 + (((number_of_day-1)-date.wday) % 7)
    end

    # def mark_revision_events(study_times)
    #   RevisionsGenerator::DEFAULT_REVISIONS_INTERVAL.each do

    #   end

    #   total_revision = @timetable.spaced_repetition_block_size_in_seconds * study_times.size
    #   study_times.each do |st|

    #   end
    #   total_revision
    # end

    #Create a revision event for an event
    # def create_revision_event_for(event)

    # end

  end
end
