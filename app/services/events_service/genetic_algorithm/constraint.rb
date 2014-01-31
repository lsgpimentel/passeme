module EventsService::GeneticAlgorithm::Constraint

  MAX_IMPORTANCE_DIFFICULTY_VALUE = 5

  #Tipos de constraints usadas pelo sistema
  TYPES = {
    subject_importance_difficulty: {
      type: :soft,
      weight: 1,
      fitness: -> (alloc_time) { subject_importance_difficulty(alloc_time) }
    },
    subject_difficulty_intercalation: {
      type: :soft,
      weight: 1,
      fitness: -> (alloc_time_1, alloc_time_2) { subject_difficulty_intercalation(alloc_time_1, alloc_time_2) }
    },
    subject_group_intercalation: {
      type: :soft,
      weight: 1,
      fitness: -> (alloc_time_1, alloc_time_2) { subject_group_intercalation(alloc_time_1, alloc_time_2) }
    },
    subject_distribution_probability: {
      type: :soft,
      weight: 1,
      fitness: -> (distribution, ideal_subject_distribution) { subject_distribution_probability(distribution, ideal_subject_distribution) }
    }
  }


  def self.calculate(chromosome)
    subject_distribution = {}

    fitness = 0
    chromosome.data.each_with_index do |alloc_time, i|

      #fitness += TYPES[:subject_importance_difficulty][:fitness].call(alloc_time)

      #Chama para os tempos de alocação imediatamente posterior
      next_time = chromosome.data[i+1]
      fitness += TYPES[:subject_group_intercalation][:fitness].call(alloc_time, next_time) unless next_time.nil?
      fitness += TYPES[:subject_difficulty_intercalation][:fitness].call(alloc_time, next_time) unless next_time.nil?

      if subject_distribution[alloc_time.subject].nil?
        subject_distribution[alloc_time.subject] = alloc_time.study_time.duration_in_seconds
      else
        subject_distribution[alloc_time.subject] += alloc_time.study_time.duration_in_seconds
      end

    end

    fitness += TYPES[:subject_distribution_probability][:fitness].call(subject_distribution, @ideal_subject_distribution)

    fitness

  end

  #Setter for the ideal distribution, so we can calculate it only
  #one time in the GeneticSearch class and use it here to define
  #the fitness
  def self.ideal_subject_distribution=(distribution)
    @ideal_subject_distribution = distribution
  end


  private

  #Relação entre a dificuldade da matéria e a produtividade do horário
  #Matérias de maior dificuldade devem ficar em horários mais produtivos
  def self.subject_difficulty(alloc_time)

  end

  #Relação entre a importância da matéria e a produtividade do horário
  #Matérias de maior importância devem ficar em horários mais produtivos
  def self.subject_importance(alloc_time)

  end

  def self.subject_importance_difficulty(alloc_time)
    importance = alloc_time.subject.importance.value
    difficulty = alloc_time.subject.difficulty.value
    prod = alloc_time.study_time.productivity.value

    diff = (importance - difficulty).abs

    #Diferença > 50%
    if diff > (MAX_IMPORTANCE_DIFFICULTY_VALUE / 2)
      #TODO considerar a importancia na dificuldade e vice-versa
      if importance > difficulty
        ((importance / MAX_IMPORTANCE_DIFFICULTY_VALUE) * (prod / 2))
      else
        difficulty / prod
      end

    else
      #Se a diferença não for tão grande
      ((importance / MAX_IMPORTANCE_DIFFICULTY_VALUE) * prod) + ((difficulty / MAX_IMPORTANCE_DIFFICULTY_VALUE) * prod)
    end

  end


  def self.subject_difficulty_intercalation(alloc_time_1, alloc_time_2)
    if alloc_time_1.subject.difficulty == alloc_time_2.subject.difficulty
      1
    else
      0
    end
  end


  #Os grupos das matérias devem ser intercalados.
  #Se o grupo da matéria anterior ou posterior for igual
  #aumenta em 1 o fitness
  def self.subject_group_intercalation(alloc_time_1, alloc_time_2)
    if alloc_time_1.subject.subject_group == alloc_time_2.subject.subject_group
      1
    else
      0
    end
  end

  #As matérias possuem uma porcentagem que determina a proporção em
  #que devem aparecer na grade. Esta constraint verifica o grau de
  #variabilidade entre a porcentagem ideal e a que foi usada no cromossomo
  def self.subject_distribution_probability(distribution, ideal_subject_distribution)
    cost = 0
    distribution.each do |subject, duration|
      #DIferença em minutos entre o ideal e o que foi usado
      diff = (ideal_subject_distribution[subject] - duration).abs / 60

      #Soma ao custo somente em caso de diferença maior que 5 minutos,
      #por considerar diferenças menores do que isso irrelevantes.
      if diff > 5
        cost += diff
      end
    end

    cost
    
  end

end
