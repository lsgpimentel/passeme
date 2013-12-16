class EventInstancesController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar

  def index
    @event_instances = EventInstance.calendar_occurrences_between(@calendar, Date.strptime(params[:start], "%s"), Date.strptime(params[:end], "%s"))
    respond_to do |format|
      format.html
      format.json { render json: @event_instances.to_json(:methods => [:color]) }
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
