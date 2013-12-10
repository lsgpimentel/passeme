class CalendarEventsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar
  before_filter :check_user_is_owner_of_calendar_event, only: [:edit_complete, :complete, :info_net_hours]

  def new
    @calendar_event = CalendarEvent.new
    @event_sources = @calendar.calendar_event_sources
    @study_sources = @calendar.study_sources
    respond_to do |format|
      format.js
    end
  end

  def create
    @calendar_event = @calendar.calendar_events.build(event_params)
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

  def edit_complete
    respond_to do |format|
      format.js
    end
  end

  def complete
    if params["studied-all"] == "1"
      @calendar_event.update_attributes(studied_time: @calendar_event.meta)
    else
      @calendar_event.update_attributes(event_follow_up_params)
    end
  end

  def info_net_hours

  end

  private

  def event_params
    params.require(:calendar_event).permit(
      :date,
      :to_time,
      :from_time,
      :repeat_ends,
      :repeat_ends_on,
      :repeats,
      :repeats_every_n_days,
      :repeats_every_n_weeks,
      :repeats_weekly_each_days_of_the_week,
      :repeats_every_n_months,
      :repeats_monthly,
      :repeats_monthly_each_days_of_the_month,
      :repeats_monthly_on_days_of_the_week,
      :repeats_monthly_on_ordinals,
      :repeats_every_n_years,
      :repeats_yearly_each_months_of_the_year,
      :repeats_yearly_on,
      :repeats_yearly_on_days_of_the_week,
      :repeats_yearly_on_ordinals,
      :time_zone)
  end

  def event_follow_up_params
    params.require(:calendar_event).permit(:studied_time, :debt_reason)
  end

  def check_user_is_owner_of_calendar_event
    @calendar_event = @calendar.calendar_events.find_by_id(params[:id] || params[:event_id])
    if @calendar_event.nil?
      redirect_to calendar_events_path
    end
  end

  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:calendar_id])
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end
end
