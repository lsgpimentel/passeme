class FollowUpNextMonthNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_month

  def perform
    active_calendars = Calendar.joins(:timetable).where(timetables: { active: true })
    active_calendars.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.current.at_beginning_of_month.next_month, Date.current.next_month.end_of_month)

      if event_instances.present? && c.timetable.creator.can_receive_email_for(NOTIFICATION_TYPE)
        UserNotificationMailer.follow_up_next_month(event_instances, c.timetable.creator)
      end
    end
  end

end
