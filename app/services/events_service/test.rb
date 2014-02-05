require File.expand_path('../../../../config/environment', __FILE__)

ActiveRecord::Base.establish_connection "algorithm"
ActiveRecord::Base.logger = Logger.new(STDOUT)


class TestAlgorithm

  def initialize
    @all_runs = []
    run_best_case
    p get_averages
    # @all_runs.clear
    # run_average_case
    # @all_runs.clear
    # run_worst_case
  end


  # pt = PomodoroTechnique.new
  # pt.time_long_break = Time.current.beginning_of_day + 30.minutes
  # pt.time_short_break = Time.current.beginning_of_day + 5.minutes
  # timetable.pomodoro_technique = pt
  # timetable.use_pomodoro_technique = true
  # timetable.block_size = Time.current.beginning_of_day + 25.minutes 
  # timetable.use_spaced_repetition = true
  # timetable.spaced_repetition_percent_block_size = 10


  #tp EventsService::StudyTimesNormalization.new(timetable).get_normalized

  def run_best_case
    user = User.find(1)
    timetable = user.timetables[2]
    timetable.subjects = user.subjects.ids.sample(5)

    5.times do
      Benchmark.bm do |bm|
        bm.report do
          generator = ::EventsService::EventsGenerator.new(timetable)
          @all_runs << generator.result
        end
      end

    end
    # tp @all_runs
     tp @all_runs.map { |x| x[:chromosomes] }
    #p @all_runs.map(&:fitness).inject(0, :+) / @all_runs.size
    #tp @all_runs[0].data.collect {|x| x.subject }
  end

  def run_average_case
    user = User.find(1)
    timetable = user.timetables[1]
    timetable.subjects = user.subjects.ids.sample(10)

    5.times do
      Benchmark.bm do |bm|
        bm.report do
          generator = ::EventsService::EventsGenerator.new(timetable)
          @all_runs << generator.result
        end
      end

    end
    tp @all_runs
    # tp @all_runs.map { |x| x[:chromosomes] }
    #p @all_runs.map(&:fitness).inject(0, :+) / @all_runs.size
    #tp @all_runs[0].data.collect {|x| x.subject }
  end

  def run_worst_case
    user = User.find(1)
    timetable = user.timetables[0]
    timetable.subjects = user.subjects.ids.sample(20)

    50.times do
      Benchmark.bm do |bm|
        bm.report do
          generator = ::EventsService::EventsGenerator.new(timetable)
          @all_runs << generator.result
        end
      end

    end
    tp @all_runs
    # tp @all_runs.map { |x| x[:chromosomes] }
    #p @all_runs.map(&:fitness).inject(0, :+) / @all_runs.size
    #tp @all_runs[0].data.collect {|x| x.subject }
  end

  private

  def get_averages
    chromosomes = @all_runs.map { |r| r[:chromosomes] }
    generations = chromosomes.size
    avgs = []
    generations.times do |i|
      avg = 0
      chromosomes.each do |crs|
        p crs[i].fitness
        avg += crs[i].fitness
      end
      avg /= generations
      avgs << avg
    end

    avgs
  end

end

TestAlgorithm.new
