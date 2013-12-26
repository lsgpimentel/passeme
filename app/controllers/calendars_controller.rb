class CalendarsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar
  before_filter :check_user_is_owner_of_calendar_event, only: [:event_click]

  def day_click
    date = Date.strptime(params[:date], "%Q").in_time_zone
    redirect_to new_calendar_calendar_event_path(@calendar, date: date)
  end

  def select
    date = Date.strptime(params[:startDate], "%Q").in_time_zone
    from_time = DateTime.strptime(params[:startDate], "%Q").in_time_zone
    to_time = DateTime.strptime(params[:endDate], "%Q").in_time_zone
    redirect_to new_calendar_calendar_event_path(@calendar, date: date, from_time: from_time, to_time: to_time)
  end

  def event_click
    redirect_to edit_calendar_calendar_event_path(@calendar, @calendar_event)
  end

  private


  def check_user_is_owner_of_calendar
    id = params[:id] || params[:calendar_id]
    @calendar = Calendar.find_by_id(id)
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end

  def check_user_is_owner_of_calendar_event
    @calendar_event = @calendar.calendar_events.find_by_id(params[:eventId])
    if @calendar_event.nil?
      redirect_to calendar_calendar_events_path
    end
  end

end
