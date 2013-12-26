class FollowUpNextDayNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_day

  def perform
    active_calendars = Calendar.joins(:timetable).where(timetables: { active: true })
    active_calendars.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.tomorrow, Date.tomorrow)

      if event_instances.present?
        c.timetable.creator.notify(NOTIFICATION_TYPE, c, c.timetable.creator)
      end
    end

  end

end
