require File.expand_path('../../../../config/environment', __FILE__)

#ActiveRecord::Base.establish_connection "algorithm"
#ActiveRecord::Base.logger = Logger.new(STDOUT)


class TestAlgorithm

  CHROMOSOME_NUMBERS = [ 100, 200, 300, 450, 600, 800, 1000, 1200, 1500, 1800, 2500 ]
  MAX_GENERATIONS = 25

  def initialize
    $stdout = File.new('population_size', 'w')
    $stdout.sync = true
    run_best_case
    run_average_case
    run_worst_case
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

  #
  #5 Subjects
  #6 hours during 4 days = x blocks
  def run_best_case
    user = User.find(1)
    timetable = user.timetables[2]
    timetable.subjects = user.subjects.ids.sample(5)

    p ">>>>>>> Running Best Case for Population Size"
    run_for_population_size(timetable)
    # p ">>>>>>> Running Best Case for Generations"
    # run_for_generations(timetable)

    # tp all_runs
    #tp all_runs.map { |x| x[:chromosomes] }
    #p all_runs.map(&:fitness).inject(0, :+) / all_runs.size
    #tp all_runs[0].data.collect {|x| x.subject }
  end

  #10 Subjects
  #10 hours during 5 days = x blocks
  def run_average_case
    user = User.find(1)
    timetable = user.timetables[1]
    timetable.subjects = user.subjects.ids.sample(10)

    p ">>>>>>> Running Average Case for Population Size"
    run_for_population_size(timetable)
    # p ">>>>>>> Running Average Case for Generations"
    # run_for_generations(timetable)

    # tp all_runs.map { |x| x[:chromosomes] }
    #p all_runs.map(&:fitness).inject(0, :+) / all_runs.size
    #tp all_runs[0].data.collect {|x| x.subject }
  end

  #20 Subjects
  #14 hours during 7 days = x blocks
  def run_worst_case
    user = User.find(1)
    timetable = user.timetables[0]
    timetable.subjects = user.subjects.ids.sample(20)

    p ">>>>>>> Running Worst Case for Population Size"
    run_for_population_size(timetable)
    # p ">>>>>>> Running Worst Case for Generations"
    # run_for_generations(timetable)

    # tp all_runs.map { |x| x[:chromosomes] }
    #p all_runs.map(&:fitness).inject(0, :+) / all_runs.size
    #tp all_runs[0].data.collect {|x| x.subject }
  end

  private

  def run_for_population_size(timetable)
    CHROMOSOME_NUMBERS.each do |population_size|
      all_runs = []
      50.times do
        # Benchmark.bm do |bm|
        # bm.report do
        generator = ::EventsService::EventsGenerator.new(timetable, initial_population_size: population_size, generations: MAX_GENERATIONS)
        all_runs << generator.result
        # end
        # end

      end

      p "Population Size = #{population_size} and Cost = #{get_average_for_best_chromosomes(all_runs)}"
    end
  end

  def run_for_generations(timetable)
    all_runs = []
    50.times do
      # Benchmark.bm do |bm|
      # bm.report do
      generator = ::EventsService::EventsGenerator.new(timetable, initial_population_size: CHROMOSOME_NUMBERS.last, generations: MAX_GENERATIONS)
      all_runs << generator.result
      # end
      # end

    end

    get_averages_for_evolutions(all_runs, MAX_GENERATIONS).each_with_index do |c, index|
      p "Generation = #{index+1} and Cost = #{c}"
    end

  end

  def get_average_for_best_chromosomes(all_runs)
    chromosomes = all_runs.map { |r| r[:chromosomes].last }
    runs = chromosomes.size
    total = 0
    chromosomes.each {|c| total += c.fitness }

    total / runs
  end

  def get_averages_for_evolutions(all_runs, generations)
    chromosomes = all_runs.map { |r| r[:chromosomes] }
    avgs = []

    generations.times do |i|
      avg = 0
      chromosomes.each do |crs|
        avg += crs[i].fitness
      end
      avg /= chromosomes.size
      avgs << avg
    end

    avgs
  end

end





#TestAlgorithm.new
