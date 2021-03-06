require 'descriptive_statistics/safe'

module EventsService
  # The GeneticAlgorithm module implements the GeneticSearch and Chromosome 
  # classes. The GeneticSearch is a generic class, and can be used to solved 
  # any kind of problems. The GeneticSearch class performs a stochastic search 
  # of the solution of a given problem.
  # 
  # The Chromosome is "problem specific". Ai4r built-in Chromosome class was 
  # designed to model the Travelling salesman problem. If you want to solve other 
  # type of problem, you will have to modify the Chromosome class, by overwriting 
  # its fitness, reproduce, and mutate functions, to model your specific problem.
  module GeneticAlgorithm

    #   This class is used to automatically:
    #   
    #     1. Choose initial population
    #     2. Evaluate the fitness of each individual in the population
    #     3. Repeat
    #           1. Select best-ranking individuals to reproduce
    #           2. Breed new generation through crossover and mutation (genetic operations) and give birth to offspring
    #           3. Evaluate the individual fitnesses of the offspring
    #           4. Replace worst ranked part of population with offspring
    #     4. Until termination
    #
    #   If you want to customize the algorithm, you must modify any of the following classes:
    #     - Chromosome
    #     - Population
    class GeneticSearch

      attr_accessor :population
      attr_accessor :study_times
      attr_accessor :subjects

      def initialize(study_times, subjects, options = {})
        @study_times = study_times
        @subjects = subjects
        @population_size = options[:initial_population_size] || calculate_population_size
        @max_generation = options[:generations] || calculate_number_of_generations
      end

      #     1. Choose initial population
      #     2. Evaluate the fitness of each individual in the population
      #     3. Repeat
      #           1. Select best-ranking individuals to reproduce
      #           2. Breed new generation through crossover and mutation (genetic operations) and give birth to offspring
      #           3. Evaluate the individual fitnesses of the offspring
      #           4. Replace worst ranked part of population with offspring
      #     4. Until termination    
      #     5. Return the best chromosome
      def run
        calculate_ideal_subject_distribution

        #p "population size >>>>>> " + @population_size.to_s
        #p "max generations >>>>>> " + @max_generation.to_s

        result = {}
        best_chromosomes = []
        generate_initial_population                    #Generate initial population 
        @max_generation.times do |g|

          selected_to_breed = selection                #Evaluates current population 

          offsprings = reproduction selected_to_breed  #Generate the population for this new generation

          replace_worst_ranked offsprings

          #Sort the chromosomes again by fitness after offsprings
          #being merged
          @population.sort! { |a, b| b.fitness <=> a.fitness}

          # fs = @population.collect {|x| x.fitness }
          # File.open("fitnesses.txt", "a") do |f|
          #   f.puts "generation (#{fs.size})  #{g.to_s} = " + fs.join(", ")
          # end

          best_chromosomes << @population[0]
        end
        result[:chromosomes] = best_chromosomes
        result[:population_size] = @population_size
        result[:generations] = @max_generation
        return result
      end


      #Generate the initial population applying elitism
      #in the sequencial generations
      def generate_initial_population
        @population = []
        @population_size.times do
          population << Chromosome.seed(study_times, subjects)
        end
      end
      # def generate_initial_population
      #   p = @population_size

      #   #First generation
      #   if @population.empty?
      #     p.times do
      #       population << Chromosome.seed(study_times, subjects)
      #     end
      #   else
      #     #Generate only 95% of the total population, so the others 5%
      #     #come from the previous population
      #     p = (p * 0.95).truncate

      #     new_population = []
      #     p.times do
      #       new_population << Chromosome.seed(study_times, subjects)
      #     end

      #     #TODO
      #     @population = @population[0..((-1*new_population.size)-1)] + new_population
      #   end

      # end

      # Select best-ranking individuals to reproduce
      # 
      # Selection is the stage of a genetic algorithm in which individual 
      # genomes are chosen from a population for later breeding. 
      # There are several generic selection algorithms, such as 
      # tournament selection and roulette wheel selection. We implemented the
      # latest.
      # 
      # Steps:
      # 
      # 1. The fitness function is evaluated for each individual, providing fitness values
      # 2. The population is sorted by descending fitness values.
      # 3. The fitness values ar then normalized. (Highest fitness gets 1, lowest fitness gets 0). The normalized value is stored in the "normalized_fitness" attribute of the chromosomes.
      # 4. A random number R is chosen. R is between 0 and the accumulated normalized value (all the normalized fitness values added togheter).
      # 5. The selected individual is the first one whose accumulated normalized value (its is normalized value plus the normalized values of the chromosomes prior it) greater than R.
      # 6. We repeat steps 4 and 5, 2/3 times the population size.    
      def selection
        @population.sort! { |a, b| b.fitness <=> a.fitness}
        best_fitness = @population[0].fitness
        worst_fitness = @population.last.fitness
        acum_fitness = 0
        if best_fitness-worst_fitness > 0
          @population.each do |chromosome| 
            chromosome.normalized_fitness = (chromosome.fitness - worst_fitness)/(best_fitness-worst_fitness)
            acum_fitness += chromosome.normalized_fitness
          end
        else
          @population.each { |chromosome| chromosome.normalized_fitness = 1}  
        end
        selected_to_breed = []
        ((2*@population_size)/3).times do
          selected_to_breed << select_random_individual(acum_fitness)
        end

        selected_to_breed
      end

      # We combine each pair of selected chromosome using the method 
      # Chromosome.reproduce
      #
      # The reproduction will also call the Chromosome.mutate method with 
      # each member of the population. You should implement Chromosome.mutate
      # to only change (mutate) randomly. E.g. You could effectivly change the
      # chromosome only if 
      #     rand < ((1 - chromosome.normalized_fitness) * 0.4)
      def reproduction(selected_to_breed)
        offsprings = []
        0.upto(selected_to_breed.length/2-1) do |i|
          offsprings << Chromosome.reproduce(selected_to_breed[2*i], selected_to_breed[2*i+1])
        end
        offsprings.flatten! #reproduce is returning an array with 2 children
        @population.each do |individual|
          Chromosome.mutate(individual)
        end
        return offsprings
      end

      # Replace worst ranked part of population with offspring
      def replace_worst_ranked(offsprings)
        size = offsprings.length
        @population = @population [0..((-1*size)-1)] + offsprings
      end

      # Select the best chromosome in the population
      def best_chromosome
        the_best = @population[0]
        @population.each do |chromosome|
          the_best = chromosome if chromosome.fitness > the_best.fitness
        end
        return the_best
      end

      private
      def select_random_individual(acum_fitness)
        select_random_target = acum_fitness * rand
        local_acum = 0
        @population.each do |chromosome|
          local_acum += chromosome.normalized_fitness
          return chromosome if local_acum >= select_random_target
        end
      end

      def calculate_population_size
        ((study_times.size * subjects.size) / 2).truncate
      end

      def calculate_number_of_generations

        d = subjects.map(&:difficulty_value).extend(DescriptiveStatistics)
        i = subjects.map(&:importance_value).extend(DescriptiveStatistics)
        p = study_times.map(&:productivity_value).extend(DescriptiveStatistics)

        diffulty_deviation = d.standard_deviation
        importance_deviation = i.standard_deviation
        productivity_deviation = p.standard_deviation

        diffulty_deviation = 1 if diffulty_deviation.zero?
        importance_deviation = 1 if importance_deviation.zero?
        productivity_deviation = 1 if productivity_deviation.zero?


        Math.sqrt(((study_times.size + subjects.size) * diffulty_deviation * importance_deviation * productivity_deviation)).round

      end

      #TODO Tá distribuindo somente conforme a importância.
      #No futuro considerar também a dificuldade da matéria
      def calculate_ideal_subject_distribution
        distribution = {}
        total_time = study_times.map(&:duration_in_seconds).inject(0, :+)
        total_importance = subjects.map(&:importance_value).inject(0, :+)

        subjects.each_with_index do |subject, i|
          percent = subject.importance_value.to_f / total_importance
          distribution[subject] = percent * total_time
        end

        #Set the ideal subject distribution in the Constraint Module
        EventsService::GeneticAlgorithm::Constraint.ideal_subject_distribution = distribution
      end

    end


  end

end
