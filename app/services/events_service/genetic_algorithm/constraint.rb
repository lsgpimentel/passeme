module EventsService::GeneticAlgorithm::Constraint

  MAX_IMPORTANCE_DIFFICULTY_VALUE = 5

  #Tipos de constraints usadas pelo sistema
  TYPES = {
    subject_importance_difficulty: {
      type: :soft,
      fitness: -> (alloc_time) { subject_importance_difficulty(alloc_time) }
    },
    subject_difficulty_intercalation: {
      type: :soft,
      fitness: -> (alloc_time_1, alloc_time_2) { subject_difficulty_intercalation(alloc_time_1, alloc_time_2) }
    },
    subject_group_intercalation: {
      type: :soft,
      fitness: -> (alloc_time_1, alloc_time_2) { subject_group_intercalation(alloc_time_1, alloc_time_2) }
    }
  }

  def self.calculate(chromosome)
    fitness = 0
    chromosome.data.each_with_index do |alloc_time, i|

      #fitness += TYPES[:subject_importance_difficulty][:fitness].call(alloc_time)

      #Chama para os tempos de alocação imediatamente anterior e posterior
      prev_time = chromosome.data[i-1]
      next_time = chromosome.data[i+1]
      fitness += TYPES[:subject_group_intercalation][:fitness].call(alloc_time, prev_time) unless prev_time.nil?
      fitness += TYPES[:subject_group_intercalation][:fitness].call(alloc_time, next_time) unless next_time.nil?

    end

    fitness

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

  end


  #Os grupos das matérias devem ser intercalados.
  #Se o grupo da matéria anterior ou posterior for diferente
  #aumenta em 1 o fitness
  def self.subject_group_intercalation(alloc_time_1, alloc_time_2)
    if alloc_time_1.subject.subject_group == alloc_time_2.subject.subject_group
      1
    else
      0
    end
  end

end
