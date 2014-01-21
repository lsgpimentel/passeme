class EventsService::GeneticAlgorithm::AllocatedTime

  attr_accessor :study_time
  attr_accessor :subject
  attr_accessor :study_source

  def initialize(study_time, subject, study_source)
    @study_time = study_time
    @subject = subject
    @study_source = study_source
  end

end

