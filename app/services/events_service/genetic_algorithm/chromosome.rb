# A Chromosome is a representation of an individual solution for a specific 
# problem.
class EventsService::GeneticAlgorithm::Chromosome

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

    cost = EventsService::GeneticAlgorithm::Constraint.calculate(self)
    @fitness = -1 * cost
    #p @fitness

    return @fitness
  end

  def unique_subjects
    data.collect { |x| x.subject }.uniq
  end

  def grouped_by_days
    grouped = {}
    data.each do |at|
      grouped[at.study_time.day_value] = [] if grouped[at.study_time.day_value].nil?
      grouped[at.study_time.day_value].push(at)
    end

    grouped
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
      #p chromosome.normalized_fitness
      data = chromosome.data
      index = rand(data.length-1)
      index2 = rand(data.length-1)
      data[index].subject, data[index2].subject = data[index2].subject, data[index].subject
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
    point = rand(a.data.length) + 1

    child1 = a.data[0, point] + b.data[point, a.data.length]
    child2 = b.data[0, point] + a.data[point, a.data.length]


    #return EventsService::GeneticAlgorithm::Chromosome.new(child1)
    return [
      EventsService::GeneticAlgorithm::Chromosome.new(child1),
      EventsService::GeneticAlgorithm::Chromosome.new(child2)
    ]

  end

  # Initializes an individual solution (chromosome) for the initial 
  # population. Usually the chromosome is generated randomly, but you can 
  # use some problem domain knowledge, to generate a 
  # (probably) better initial solution.
  def self.seed(study_times, subjects, subject_distribution = nil)
    #TODO Para simplificar não tá considerando a importância e dificuldade
    #das matérias quando determina quantos tempos cada uma deve ganhar.
    #Isso não pode ser randômico do jeito que está.
    #
    #TODO Os study sources estão sendo selecionados aleatoriamente.
    #Seria bom ter uma etapa em que defino a importância dos study
    #sources, para que alguns possam ser mais usados do que outros.
    allocated_times = []
    study_times.each do |st|
      subject = subjects[rand(subjects.length)]
      study_source = subject.study_sources[rand(subject.study_sources.length)]
      allocated_times << EventsService::GeneticAlgorithm::AllocatedTime.new(st, subject, study_source)
    end
    return EventsService::GeneticAlgorithm::Chromosome.new(allocated_times)
  end

  def calculate
    
  end

end

