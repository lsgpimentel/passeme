class FollowUpPastMonthNotifier
  
  NOTIFICATION_TYPE = :follow_up_past_month

  def perform
    Calendar.all.each do |c|

      event_instances = EventInstance.calendar_occurrences_between(c, Date.today.at_beginning_of_month.prev_month, Date.today.prev_month.end_of_month)

      if event_instances.present?
        c.timetable.creator.notify(NOTIFICATION_TYPE, c, c.timetable.creator)
      end
    end
  end

end
