require File.expand_path('../../../../config/environment', __FILE__)

ActiveRecord::Base.establish_connection "algorithm"
ActiveRecord::Base.logger = Logger.new(STDOUT)


class TestAlgorithm

  CHROMOSOME_NUMBERS = [ 100, 200, 300, 450, 600, 800, 1000, 1200, 1500, 1800, 2500 ]
  MAX_GENERATIONS = 25

  def initialize
    run_average_case
  end

  #10 Subjects
  #10 hours during 5 days = x blocks
  def run_average_case
    user = User.find(1)
    timetable = user.timetables[1]
    timetable.subjects = user.subjects.ids[0..10]

    Benchmark.bm do |bm|
      bm.report do
        generator = ::EventsService::EventsGenerator.new(timetable)
        tp generator.result[:chromosomes]
      end
    end

    # tp all_runs.map { |x| x[:chromosomes] }
    #p all_runs.map(&:fitness).inject(0, :+) / all_runs.size
    #tp all_runs[0].data.collect {|x| x.subject }
  end


end





TestAlgorithm.new
