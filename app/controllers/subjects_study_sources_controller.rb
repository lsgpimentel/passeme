class SubjectsStudySourcesController < AuthenticatedController
  add_breadcrumb "Subjects", :subjects_path

  before_filter :check_user_is_owner_of_subject

  def index
    add_breadcrumb @subject.name, subject_path(@subject)
    add_breadcrumb "Study Sources"
    @all_sources = current_user.study_sources
    @selected_sources = @subject.study_sources
  end

  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save!
    else
      #TODO error
      #render :index
    end
  end

  def update

  end

  private

  def subject_params
    params.require(:subject).permit(:type, :title, :author)
  end

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end

  def check_user_is_owner_of_subject
    @subject = current_user.subjects.find_by_id(params[:subject_id])
    if @subject.nil?
      redirect_to subjects_path
    end
  end


end
