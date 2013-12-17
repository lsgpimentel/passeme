class FollowUpNextDayNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_day

  def perform
    Calendar.all.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.tomorrow, Date.tomorrow)

      if event_instances.present?
        c.timetable.creator.notify(NOTIFICATION_TYPE, c, c.timetable.creator)
      end
    end

  end

end
