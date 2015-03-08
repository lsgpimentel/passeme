class SubjectsController < AuthenticatedController
  add_breadcrumb I18n.t('subjects.breadcrumb'), :subjects_path

  before_filter :check_user_is_owner_of_subject, :only => [:study_sources, :update_study_sources, :edit, :update, :destroy, :update_subject_group ]


  def index
    @subjects = current_user.subjects.includes(:study_sources)
  end

  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save
      flash[:notice] = t('.create_successful')
    else
      #render :index
    end

    redirect_to action: :index
  end

  def study_sources
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def update
    flash[:notice] = t('.update_successful') if @subject.update_attributes(subject_params)
    redirect_to action: :index
  end

  def update_study_sources
    flash[:notice] = t('.update_successful') if @subject.update_attributes(subject_params)
    redirect_to action: :index
  end

  #Update subject group
  #Used in the subject group x subject association page
  def update_subject_group
    if params.has_key?(:subject_group_id)
      @subject.update_attribute(:subject_group_id, params[:subject_group_id])
    else
      @subject.update_attribute(:subject_group, nil)
    end

    render nothing: true
  end

  def destroy
    @subject.destroy!

    render nothing: true
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :difficulty, :importance, :subject_group_id, study_source_ids: [])
  end

  def check_user_is_owner_of_subject
    id = params[:id] || params[:subject_id]
    @subject = current_user.subjects.find_by_id(id)
    if @subject.nil?
      redirect_to subjects_path
    end
  end


end
