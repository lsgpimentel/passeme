module EventsService
  module GeneticAlgorithm

    class AllocatedTime

      attr_accessor :study_time
      attr_accessor :subject

      def initialize(study_time, subject) #,study_source
        @study_time = study_time
        @subject = subject
      end

      #TODO Para simplificar, não tá considerando os study sources atualmente,
      #somente os subjects, o que é errado, já que o que é estudado
      #é a fonte de estudo em si.
      attr_accessor :study_source
    end

    # A Chromosome is a representation of an individual solution for a specific 
    # problem.
    class Chromosome

      attr_accessor :data #Allocated Times
      attr_accessor :normalized_fitness

      def initialize(data)
        @data = data
      end

      # The fitness method quantifies the optimality of a solution 
      # (that is, a chromosome) in a genetic algorithm so that that particular 
      # chromosome may be ranked against all the other chromosomes. 
      # 
      # Optimal chromosomes, or at least chromosomes which are more optimal, 
      # are allowed to breed and mix their datasets by any of several techniques, 
      # producing a new generation that will (hopefully) be even better.
      def fitness
        return @fitness if @fitness

        @fitness = Constraint.calculate(self)
        return @fitness
      end

      # mutation method is used to maintain genetic diversity from one 
      # generation of a population of chromosomes to the next. It is analogous 
      # to biological mutation. 
      # 
      # The purpose of mutation in GAs is to allow the 
      # algorithm to avoid local minima by preventing the population of 
      # chromosomes from becoming too similar to each other, thus slowing or even 
      # stopping evolution.
      # 
      # Calling the mutate function will "probably" slightly change a chromosome
      # randomly. 
      #
      # This implementation of "mutation" will (probably) reverse the 
      # order of 2 consecutive randome nodes 
      # (e.g. from [ 0, 1, 2, 4] to [0, 2, 1, 4]) if:
      #     ((1 - chromosome.normalized_fitness) * 0.4)
      #TODO atualmente na mutação está sendo invertido 2 nós consecutivos
      #aleatoriamente, o que pra mim não serve de nada. O ideal seria obter
      #um nó com fitness baixo e realizar mutação pegando o subject dele
      #e alocar em outro nó (talvez com fitness baixo também)
      def self.mutate(chromosome)
        if chromosome.normalized_fitness && rand < ((1 - chromosome.normalized_fitness) * 0.3)
          data = chromosome.data
          index = rand(data.length-1)
          data[index], data[index+1] = data[index+1], data[index]
          chromosome.data = data
          @fitness = nil
        end
      end

      # Reproduction method is used to combine two chromosomes (solutions) into 
      # a single new chromosome. There are several ways to
      # combine two chromosomes: One-point crossover, Two-point crossover,
      # "Cut and splice", edge recombination, and more. 
      # 
      # The method is usually dependant of the problem domain.
      # In this case, we have implemented edge recombination, wich is the 
      # most used reproduction algorithm for the Travelling salesman problem.
      def self.reproduce(a, b)
        data_size = @@costs[0].length
        available = []
        0.upto(data_size-1) { |n| available << n }
        token = a.data[0]
        spawn = [token]
        available.delete(token)
        while available.length > 0 do 
          #Select next
          if token != b.data.last && available.include?(b.data[b.data.index(token)+1])
            next_token = b.data[b.data.index(token)+1]
          elsif token != a.data.last && available.include?(a.data[a.data.index(token)+1])
            next_token = a.data[a.data.index(token)+1] 
          else
            next_token = available[rand(available.length)]
          end
          #Add to spawn
          token = next_token
          available.delete(token)
          spawn << next_token
          a, b = b, a if rand < 0.4
        end
        return Chromosome.new(spawn)
      end

      # Initializes an individual solution (chromosome) for the initial 
      # population. Usually the chromosome is generated randomly, but you can 
      # use some problem domain knowledge, to generate a 
      # (probably) better initial solution.
      def self.seed(study_times, subjects)
        #TODO Para simplificar não tá considerando a importância e dificuldade
        #das matérias quando determina quantos tempos cada uma deve ganhar.
        #Isso não pode ser randômico do jeito que está.
        allocated_times = []
        study_times.each do |st|
          allocated_times << AllocatedTime.new(st, subjects[rand(subjects.length)])
        end
        return Chromosome.new(allocated_times)
      end

    end
  end
end


