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

  end

  def event_click

  end

  private


  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:id])
    if @calendar.present? && @calendar.timetable.syllabus.creator != current_user
      redirect_to root_path
    end
  end

end
