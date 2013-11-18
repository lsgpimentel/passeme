class SubjectsController < AuthenticatedController
  add_breadcrumb "Subjects", :subjects_path

  before_filter :check_user_is_owner_of_subject, :only => [:study_sources, :update_study_sources, :edit, :update, :destroy ]

  def index
    @subjects = current_user.subjects
  end

  def create
    @subject = current_user.subjects.build(subject_params)
    if @subject.save!
    else
      #TODO error
      #render :index
    end

    respond_to do |format|
      format.html { redirect_to action: :index }
      format.js
    end
  end

  def study_sources
    #just return the subject
    respond_to do |format|
      format.js
    end
  end

  def new
    @subject = Subject.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    #just return the subject
    respond_to do |format|
      format.js
    end
  end

  def update
    @subject.update_attributes(subject_params)
  end

  def update_study_sources
    respond_to do |format|
      if @subject.update_attributes(subject_params)
        flash[:notice] = 'Study sources successfully updated.'
        format.html { redirect_to action: :index }
      end
    end

  end

  def destroy
    @subject.destroy!
    respond_to do |format|
      format.js
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :difficulty, :importance, study_source_ids: [])
  end

  def check_user_is_owner_of_subject
    id = params[:id] || params[:subject_id]
    @subject = current_user.subjects.find_by_id(id)
    if @subject.nil?
      redirect_to subjects_path
    end
  end


end
