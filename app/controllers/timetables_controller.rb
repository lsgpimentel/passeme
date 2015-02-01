class TimetablesController < AuthenticatedController

  before_filter :check_user_is_owner_of_timetable, :only => [:update, :destroy, :make_active]

  add_breadcrumb I18n.t('timetables.breadcrumb'), :timetables_path

  def index
    @timetables = current_user.timetables.includes(:calendar)
    @active_timetable = @timetables.where(active: true)[0]
    if @active_timetable.blank?
      render :no_timetable
    end
  end


  def show
  end

  def new
    @timetable = Timetable.new
    @study_sources = current_user.study_sources
    @subject_groups = current_user.subject_groups.joins(subjects: :study_sources).distinct

    @active_timetable = current_user.timetables.where(active: true)[0]
  end

  def create
    @timetable = current_user.timetables.build(timetable_params)
    @timetable.build_calendar

    if @timetable.study_times.present? && @timetable.subjects.present?
      @timetable.calendar.calendar_event_sources = ::EventsService::EventsGenerator.new(@timetable).event_sources
    end

    #If there's not any other timetable created, then this one must
    #be the active
    @active_timetable = current_user.timetables.where(active: true)[0]
    if @active_timetable.blank?
      @timetable.active = true
    end

    if @timetable.save
    else
      p @timetable.errors
      render :new
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
    params.require(:timetable).permit(:name, :goal, :specific, :active, :public, :use_pomodoro_technique, :use_spaced_repetition, :spaced_repetition_percent_block_size, :block_size, :block_interval, :start_date, :end_date, pomodoro_technique: [:time_short_break, :time_long_break], subjects: [], study_times_attributes: [:day, :from, :to, :productivity])
  end

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:id] || params[:timetable_id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end

end
