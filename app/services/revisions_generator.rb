class RevisionsGenerator

  DEFAULT_REVISIONS_INTERVAL = [1.day, 7.days, 30.days]


  def initialize(calendar_event)
    @calendar_event = calendar_event
  end

  #Just fill the other attributes of the revision event that are required
  def fill_revision_events_attrs
    @calendar_event.revision_events.each do |r|
      r.study_source = @calendar_event.study_source
      r.calendar_event_source = @calendar_event.calendar_event_source 
    end
  end

  def default_revisions
    revision_events = []

    DEFAULT_REVISIONS_INTERVAL.each do |i|
      revision_events << CalendarEvent.new(
        date: Date.current + i,
        from_time: @calendar_event.from_time,
        to_time: @calendar_event.to_time,
        calendar_event_source: @calendar_event.calendar_event_source,
        study_source: @calendar_event.study_source,
      )
    end
    p revision_events
    revision_events

  end

end
