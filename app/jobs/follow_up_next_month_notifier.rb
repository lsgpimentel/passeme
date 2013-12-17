class FollowUpNextMonthNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_month

  def perform
    Calendar.all.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.today.at_beginning_of_month.next_month, Date.today.next_month.end_of_month)

      if event_instances.present?
        c.timetable.creator.notify(NOTIFICATION_TYPE, c, c.timetable.creator)
      end
    end
  end

end
