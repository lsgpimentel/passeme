#!/usr/bin/env ruby

require File.expand_path('../../../../config/environment', __FILE__)

ActiveRecord::Base.establish_connection "algorithm"
ActiveRecord::Base.logger = Logger.new(STDOUT)

all_runs = []

user = User.find(1)
timetable = user.timetables.first
study_times = timetable.study_times
subjects = user.subjects.includes(:study_sources, :subject_group)

pt = PomodoroTechnique.new
pt.time_long_break = Time.current.beginning_of_day + 30.minutes
pt.time_short_break = Time.current.beginning_of_day + 5.minutes
timetable.pomodoro_technique = pt



# def initialize(study_times, subjects, options = {})
#   @population_size = options[:initial_population_size] || DEFAULT_INITIAL_POPULATION_SIZE
#   @max_generation = options[:generations] || DEFAULT_GENERATIONS
#   @block_interval = options[:block_interval]
#   @block_size = options[:block_size]
#   @pomodoro_technique = options[:pomodoro_technique]
#   @spaced_repetition_time = options[:spaced_repetition_time]
#   @generation = 0
#   @study_times = study_times
#   @subjects = subjects
# end

search = EventsService::GeneticAlgorithm::GeneticSearch.new(study_times, subjects,
                                                            block_interval: timetable.block_interval,
                                                            block_size: timetable.block_size,
                                                            pomodoro_technique: timetable.pomodoro_technique,
                                                            spaced_repetition_time: timetable.spaced_repetition_time #TODO
                                                           )

1.times do
  Benchmark.bm do |bm|
    bm.report do
      all_runs << search.run
    end
  end

  #tp all_runs
end
tp all_runs[0].data.collect {|x| x.study_time}


