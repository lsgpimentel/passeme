class SubjectGroupsController < AuthenticatedController

  add_breadcrumb "Subject Groups", :subject_groups_path

  #before_filter :check_user_is_owner_of_subject, :only => [:study_sources, :update_study_sources, :edit, :update, :destroy ]

  def index
    @subjects = current_user.subjects.where(subject_group_id: nil)
    @subject_groups = current_user.subject_groups
    @subject_group = SubjectGroup.new
  end

  def create

  end

  def update

  end

  private

  def subject_group_params
    params.require(:subject_group).permit(:name )
  end

  def check_user_is_owner_of_subject_group
    @subject = current_user.subjects.find_by_id(id)
    if @subject.nil?
      redirect_to subjects_path
    end
  end

end
