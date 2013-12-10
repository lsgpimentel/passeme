class CalendarsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar

  def event_sources_from_study_times
    event_sources = EventsGenerator.new(@calendar.timetable.study_times).event_sources

    respond_to do |format|
      format.json { render json: event_sources }
    end
  end

  def event_sources

  end

  def event_resize

  end

  def select

  end

  def event_drop

  end

  def day_click
    @calendar_event = CalendarEvent.new
    @calendar_event.date = Date.strptime(params[:date], "%Q")
    @event_sources = @calendar.calendar_event_sources
    @study_sources = @calendar.study_sources

  end

  def event_click

  end

  private


  def check_user_is_owner_of_calendar
    id = params[:id] || params[:calendar_id]
    @calendar = Calendar.find_by_id(id)
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end

end
