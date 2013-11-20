class SubjectGroupsController < AuthenticatedController

  add_breadcrumb "Subject Groups", :subject_groups_path

  before_filter :check_user_is_owner_of_subject_group, :only => [:update, :destroy ]
  
  def index
    @subjects = current_user.subjects.where(subject_group_id: nil)
    @subject_groups = current_user.subject_groups
    @subject_group = SubjectGroup.new
  end

  def create
    @subject_group = current_user.subject_groups.build(subject_group_params)
    if @subject_group
      update_subjects(params[:subject_ids], @subject_group)
      @subject_group.save!

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

  def destroy
    @subject_group.destroy!
    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end
  
  private

  def update_subjects(ids, subject_group)
    if ids.present?
      ids.each do |i|
        #TODO only the subjects he owns
        #Subject.find_by_id(i).update_attribute(:subject_group, subject_group)
        subject_group.subjects << Subject.find_by_id(i)
      end
    end
  end

  def subject_group_params
    params.require(:subject_group).permit(:name, subject_ids: [])
  end

  def check_user_is_owner_of_subject_group
    @subject_group = current_user.subject_groups.find_by_id(params[:id])
    if @subject_group.nil?
      redirect_to subject_groups_path
    end
  end

end
