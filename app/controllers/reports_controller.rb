class ReportsController < AuthenticatedController
  before_filter :check_user_is_owner_of_timetable, except: [ :index_active_timetable ]

  add_breadcrumb I18n.t('reports.breadcrumb'), :reports_path

  def index
  end

  def index_active_timetable
    @timetable = current_user.timetables.where(active: true)[0]
    if @timetable.blank?
      render 'timetables/no_timetable'
    else
      render :index
    end
  end

  def change_timetable
    reports = Reports.new(@timetable).generate_all
    respond_to do |format|
      format.json { render json: reports.to_json }
    end
  end

  private

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:timetable_id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end
end
