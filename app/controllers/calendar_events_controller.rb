class CalendarEventsController < AuthenticatedController

  before_filter :check_user_is_owner_of_calendar
  before_filter :check_user_is_owner_of_calendar_event, only: [:edit_complete, :complete, :info_net_hours, :edit, :update, :destroy]

  def new
    @calendar_event = CalendarEvent.new(date: params[:date], from_time: params[:from_time], to_time: params[:to_time])
    @calendar_event.repeats = 'never'
    @calendar_event.revision_events << RevisionsGenerator.new(@calendar_event).default_revisions
    @event_sources = @calendar.calendar_event_sources
    @study_sources = @calendar.study_sources
    respond_to do |format|
      format.js
    end
  end

  def create
    @calendar_event = @calendar.calendar_events.build(event_params)
    RevisionsGenerator.new(@calendar_event).fill_revision_events_attrs
    if @calendar_event.save!
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
    @follow_up_item = @calendar_event.follow_up_items.build(date: params[:start], from_time: params[:start], to_time: params[:end])
    respond_to do |format|
      format.js
    end
  end

  def complete
    follow_up_item = @calendar_event.follow_up_items.build(follow_up_params)
    if params["studied-all"] == "1"
      follow_up_item.studied_time = @calendar_event.meta
      follow_up_item.debt_reason = nil
    end

    follow_up_item.save!
  end


  def edit
    @event_sources = @calendar.calendar_event_sources
    @study_sources = @calendar.study_sources
    #Just redirect the event
    respond_to do |format|
      format.js
    end
  end

  def update
    @calendar_event.attributes = event_params
    #
    #If the user is editing the event and said that there's no revision events,
    #then we just make sure that the possible previous revision events get destroyed.
    if have_revision_events?
      RevisionsGenerator.new(@calendar_event).fill_revision_events_attrs
    else
      @calendar_event.revision_events.destroy_all
    end

    p @calendar_event

    @calendar_event.save!
  end

  def info_net_hours

  end

  def destroy
    @calendar_event.revision_events.destroy_all
    @calendar_event.destroy!
  end

  private

  def event_params
    event_permitted = [
      :date,
      :to_time,
      :from_time,
      :calendar_event_source_id,
      :study_source_id,
      :repeat_ends,
      :repeat_ends_on,
      :repeat_ends_count,
      :repeats,
      :repeats_every_n_days,
      :repeats_every_n_weeks,
      :repeats_every_n_months,
      :repeats_monthly,
      :repeats_every_n_years,
      :repeats_yearly_on,
      :time_zone,
      :interval,
      repeats_weekly_each_days_of_the_week: [],
      repeats_monthly_each_days_of_the_month: [],
      repeats_monthly_on_days_of_the_week: [],
      repeats_monthly_on_ordinals: [],
      repeats_yearly_each_months_of_the_year: [],
      repeats_yearly_on_days_of_the_week: [],
      repeats_yearly_on_ordinals: []
    ]
    if(have_revision_events?)
      event_permitted.push(revision_events_attributes: [:id, :date, :from_time, :to_time, :repeats, :_destroy])
    end

    params.require(:calendar_event).permit(event_permitted)
  end

  def have_revision_events?
    params[:calendar_event]["spaced_revision"].present?
  end

  def follow_up_params
    params.require(:follow_up_item).permit(:studied_time, :debt_reason, :date, :from_time, :to_time)
  end

  def check_user_is_owner_of_calendar_event
    @calendar_event = @calendar.calendar_events.find_by_id(params[:id] || params[:calendar_event_id])
    if @calendar_event.nil?
      redirect_to calendar_calendar_events_path
    end
  end

  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:calendar_id])
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end
end
