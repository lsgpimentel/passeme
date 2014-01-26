#!/usr/bin/env ruby

require File.expand_path('../../../../config/environment', __FILE__)

ActiveRecord::Base.establish_connection "algorithm"
ActiveRecord::Base.logger = Logger.new(STDOUT)

all_runs = []

user = User.find(1)
timetable = user.timetables.first
timetable.subjects = user.subjects.ids #virtual attr

pt = PomodoroTechnique.new
pt.time_long_break = Time.current.beginning_of_day + 30.minutes
pt.time_short_break = Time.current.beginning_of_day + 5.minutes
timetable.pomodoro_technique = pt



p timetable

5.times do
  Benchmark.bm do |bm|
    bm.report do
      generator = ::EventsService::EventsGenerator.new(timetable)
      all_runs << generator.chromosome
    end
  end

end
tp all_runs
#tp all_runs[0].data.collect {|x| x.subject }


