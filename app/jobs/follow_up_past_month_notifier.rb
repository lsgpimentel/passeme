class FollowUpPastMonthNotifier
  
  NOTIFICATION_TYPE = :follow_up_past_month

  def perform
    active_calendars = Calendar.joins(:timetable).where(timetables: { active: true })
    active_calendars.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.current.at_beginning_of_month.prev_month, Date.current.prev_month.end_of_month)

      if event_instances.present?
        c.timetable.creator.notify(NOTIFICATION_TYPE, c, c.timetable.creator)
      end
    end
  end

end
