class SubjectGroupsController < AuthenticatedController

  add_breadcrumb "Subject Groups", :subject_groups_path
  
  #before_filter :check_user_is_owner_of_subject, :only => [:study_sources, :update_study_sources, :edit, :update, :destroy ]
  
  def index
    @subjects = current_user.subjects.where(subject_group_id: nil)
    @subject_groups = current_user.subject_groups
    @subject_group = SubjectGroup.new
  end

  def create
    @subject_group = current_user.subject_groups.build(subject_group_params)
    if @subject_group.save!
      update_subjects(params[:subject_ids], @subject_group)

    else
    #TODO error
    #render :index
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end

  def update
    @subject_group.update_attributes(subject_group_params)
    update_subjects(params[:subject_ids], @subject_group)
  end
  
  def update_subject
    subject = Subject.find_by_id(params[:subject_id])
    subject.update_attribute(:subject_group, params[:subject_group_id])
  end


  private

  def update_subjects(ids, subject_group)
    ids.each do |i|
      #TODO only the subjects he owns
      Subject.find_by_id(i).update_attribute(:subject_group, subject_group)
    end
  end

  def subject_group_params
    params.require(:subject_group).permit(:name, subject_ids: [])
  end

  def check_user_is_owner_of_subject_group
    @subject = current_user.subjects.find_by_id(id)
    if @subject.nil?
      redirect_to subjects_path
    end
  end

end
