class CalendarEventsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar

  def new
    @calendar_event = CalendarEvent.new
    respond_to do |format|
      format.js
    end
  end



  private

  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:calendar_id])
    if @calendar.present? && @calendar.timetable.syllabus.creator != current_user
      redirect_to root_path
    end
  end
end
