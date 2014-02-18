require File.expand_path('../../../../config/environment', __FILE__)

ActiveRecord::Base.establish_connection "algorithm"
ActiveRecord::Base.logger = Logger.new(STDOUT)


class TestAlgorithm

  def initialize
    $stdout = File.new('avg_case', 'w')
    $stdout.sync = true
    run_average_case
  end


  #10 Subjects
  #10 hours during 5 days = x blocks
  def run_average_case
    user = User.find(1)
    timetable = user.timetables[1]
    timetable.subjects = user.subjects.ids[0..9]

    p ">>>>>>> Running Average Case (2)"
    p ">>>>>>> Using Subjects >>>>>>>>>"
    tp timetable.subjects
    run_for_generations(timetable)

  end

  private

  def run_for_generations(timetable)
    all_runs = []
    50.times do
      Benchmark.bm do |bm|
        bm.report do
          generator = ::EventsService::EventsGenerator.new(timetable)
          result = generator.result
          all_runs << result

          p "Generations -> #{result[:generations]}"
          p "Population Size -> #{result[:population_size]}"
        end
      end

    end

    get_averages_for_evolutions(all_runs).each_with_index do |c, index|
      p "Generation = #{index+1} and Cost = #{c}"
    end

  end

  def get_averages_for_evolutions(all_runs)
    chromosomes = all_runs.map { |r| r[:chromosomes] }
    avgs = []
    generations = all_runs[0][:generations]

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


TestAlgorithm.new
