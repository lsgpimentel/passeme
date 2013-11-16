class StudySourcesController < AuthenticatedController
  add_breadcrumb "Study Sources", :study_sources_path

  before_filter :check_user_is_owner_of_study_source, :only => [:edit, :update, :destroy ]

  def index
    @study_sources = current_user.study_sources
  end

  def create
    @study_source = current_user.study_sources.build(study_source_params)
    if @study_source.save!
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
    #just return the study_source
    respond_to do |format|
      format.js
    end
  end

  def new
    @study_source = StudySource.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    #just return the study_source
    respond_to do |format|
      format.js
    end
  end

  def update
    @study_source.update_attributes(study_source_params)
  end

  def destroy
    @study_source.destroy!
    respond_to do |format|
      format.js
    end
  end

  private

  def study_source_params
    params.require(:study_source).permit(:type, :title, :author)
  end

  def check_user_is_owner_of_study_source
    @study_source = current_user.study_sources.find_by_id(params[:id])
    if @study_source.nil?
      redirect_to study_sources_path
    end
  end
end
