class StudySourcesController < AuthenticatedController
  add_breadcrumb I18n.t('study_sources.breadcrumb'), :study_sources_path

  before_filter :check_user_is_owner_of_study_source, :only => [:edit, :update, :destroy ]

  def index
    @study_sources = current_user.study_sources
  end

  def create
    @study_source = current_user.study_sources.build(study_source_params)
    if @study_source.save
      flash[:notice] = t('.create_successful')
    else
      #TODO error
      #render :index
    end

    redirect_to action: :index
  end

  def new
    @study_source = StudySource.new
  end

  def edit
  end

  def update
    flash[:notice] = t('.update_successful') if @study_source.update_attributes(study_source_params)
    redirect_to action: :index
  end

  def destroy
    @study_source.destroy!
    render nothing: true
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
