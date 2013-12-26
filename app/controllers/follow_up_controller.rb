class FollowUpController < AuthenticatedController

  DEFAULT_START_DATE = Date.current
  DEFAULT_END_DATE = Date.current + 1.month

  before_filter :check_user_is_owner_of_timetable, except: [ :index_active_timetable ]

  add_breadcrumb "Follow Up", :follow_up_path

  def index
    fill_items
  end

  def index_active_timetable
    @timetable = current_user.timetables.where(active: true)[0]
    if @timetable.blank?
      render 'timetables/_no_timetable'
    else
      fill_items
      render :index
    end

  end

  private

  def fill_items
    start_date = Date.strptime(params[:start], "%s").in_time_zone if params[:start].present?
    end_date = Date.strptime(params[:end], "%s").in_time_zone if params[:end].present?
    @items_to_study = EventInstance.follow_up_occurrences_between(@timetable.calendar, (start_date || DEFAULT_START_DATE), (end_date || DEFAULT_END_DATE))
    @items_studied = @timetable.follow_up_items.studied
    @items_studied_debt = @timetable.follow_up_items.studied_debt
  end

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:timetable_id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end
end
