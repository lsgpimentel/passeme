module EventsService::GeneticAlgorithm::Constraint
  
  #n[:message].call(notification)
  TYPES = {
    subject_difficulty: {
      type: :soft,
      formula: -> {}
    },
    subject_importance: {
      type: :soft,
      formula: -> {}
    },
    subject_group_intercalation: {
      type: :soft,
      formula: -> {}
    }
  }
end
