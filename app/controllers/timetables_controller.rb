class TimetablesController < AuthenticatedController

  before_filter :check_user_is_owner_of_timetable, :only => [:update, :destroy, :make_active]

  add_breadcrumb "Timetables", :timetables_path

  def index
    @timetables = current_user.timetables
    @active_timetable = @timetables.where(active: true)[0]
  end

  def show

  end

  def new
    @timetable = Timetable.new
    @study_sources = current_user.study_sources
    @subject_groups = current_user.subject_groups.includes(:subjects).where('subjects.subject_group_id is not null')
  end

  def create
    @timetable = current_user.timetables.build(timetable_params)
    @timetable.build_calendar
    @timetable.calendar.calendar_event_sources = EventsGenerator.new(@timetable).event_sources
    if @timetable.save!
    else
      #render :index
      #TODO error
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def make_active
    @timetable.make_active
    render nothing: true
  end

  private

  def timetable_params
    params.require(:timetable).permit(:name, :goal, :specific, :active, :public, subject_group_ids: [], study_times_attributes: [:day, :from, :to, :productivity])
  end

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:id] || params[:timetable_id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end

end
