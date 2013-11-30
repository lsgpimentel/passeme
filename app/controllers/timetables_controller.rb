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

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

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
