class TimetablesController < AuthenticatedController

  before_filter :check_user_is_owner_of_timetable, :only => [:update, :destroy]
  before_filter :check_user_is_owner_of_syllabus

  add_breadcrumb "Timetables", :timetables_path

  def index
    @timetables = current_user.timetables
  end

  def show

  end


  def new
    @timetable = Timetable.new
    @study_sources = current_user.study_sources
    @subject_groups = SubjectGroup.includes(:subjects).where('subjects.subject_group_id is not null')
  end

  def create
    @timetable = @syllabus.timetables.build(timetable_params)
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

  private

  def timetable_params
    params.require(:timetable).permit(:name, :public, subject_group_ids: [], study_times_attributes: [:day, :from, :to, :productivity])
  end

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end

  def check_user_is_owner_of_syllabus
    @syllabus = current_user.syllabuses.find_by_id(params[:syllabus_id])
    if @syllabus.nil?
      redirect_to syllabuses_path
    end
  end
end
