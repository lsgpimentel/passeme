class CalendarEventsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar

  def new
    @calendar_event = CalendarEvent.new
    @event_sources = @calendar.calendar_event_sources
    respond_to do |format|
      format.js
    end
  end

  def create
    @calendar_event = @calendar.build(subject_params)
    if @subject.save!
      #TODO error
    else
      #render :index
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end



  private

  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:calendar_id])
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end
end
