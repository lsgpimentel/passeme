class TimetablesController < AuthenticatedController

  before_filter :check_user_is_owner_of_timetable, :only => [:update, :destroy]
  before_filter :check_user_is_owner_of_syllabus

  add_breadcrumb "Timetables", :timetables_path

  def index
    @timetables = current_user.timetables
  end

  def show

  end

  def event_sources_from_study_times
    @timetable = @syllabus.timetables.build(timetable_params)
    event_sources = EventsGenerator.new(@timetable.study_times).event_sources

    respond_to do |format|
      format.json { render json: event_sources }
    end
  end

  def new
    @timetable = Timetable.new
    @study_sources = current_user.study_sources
    @subject_groups = SubjectGroup.includes(:subjects).where('subjects.subject_group_id is not null')
  end

  def create
    @timetable = @syllabus.timetables.build(timetable_params)
    if @timetable.save!
      #TODO error
    else
      #render :index
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
    params.require(:timetable).permit(:name, subject_group_ids: [], study_times_attributes: [:day, :from, :to, :productivity])
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
