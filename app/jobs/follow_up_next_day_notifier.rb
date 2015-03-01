class FollowUpNextDayNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_day

  def perform
    active_calendars = Calendar.joins(:timetable).where(timetables: { active: true })
    active_calendars.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.tomorrow, Date.tomorrow)

      if event_instances.present? && c.timetable.creator.can_receive_email_for(NOTIFICATION_TYPE)
        UserNotificationMailer.follow_up_next_day(event_instances, c.timetable.creator).deliver
      end
    end

  end

end
