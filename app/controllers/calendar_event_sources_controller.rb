class CalendarEventSourcesController < AuthenticatedController
  before_filter :check_user_is_owner_of_calendar
  before_filter :check_user_is_owner_of_event_source, :only => [:edit, :update, :destroy, :get_study_sources ]

  add_breadcrumb "Event Sources", :calendar_event_sources_path

  def index
    @event_sources = @calendar.calendar_event_sources
  end

  def create
    @event_source = @calendar.calendar_event_sources.build(event_source_params)
    if @event_source.save!
    else
      #TODO error
      #render :index
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end

  def new
    @event_source = CalendarEventSource.new
    @subjects = current_user.subjects
    respond_to do |format|
      format.js
    end
  end

  def edit
    @subjects = current_user.subjects
    #just return the event_source
    respond_to do |format|
      format.js
    end
  end

  def update
    @event_source.update_attributes(event_source_params)
  end

  def destroy
    @event_source.destroy!
    respond_to do |format|
      format.js
    end
  end

  def get_study_sources
    respond_to do |format|
      format.js { render json: @event_source.subject.study_sources, only: [:id, :title] }
    end
  end


  private

  def event_source_params
    params.require(:calendar_event_source).permit(:subject_id, :color, :author)
  end

  def check_user_is_owner_of_calendar
    @calendar = Calendar.find_by_id(params[:calendar_id])
    if @calendar.blank? || @calendar.timetable.creator != current_user
      redirect_to root_path
    end
  end

  def check_user_is_owner_of_event_source
    @event_source = @calendar.calendar_event_sources.find_by_id(params[:id])
    if @event_source.nil?
      redirect_to calendar_event_sources_path
    end
  end
end
