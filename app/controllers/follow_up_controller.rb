class FollowUpController < AuthenticatedController

  before_filter :check_user_is_owner_of_timetable, except: [ :index_active_timetable ]

  add_breadcrumb "Follow Up", :follow_up_path

  def index
    @follow_up_items = @timetable.follow_up_items
  end

  def index_active_timetable
    @timetable = current_user.timetables.where(active: true)[0]
    @events = @timetable.calendar_events
    render :index
  end

  private

  def check_user_is_owner_of_timetable
    @timetable = current_user.timetables.find_by_id(params[:timetable_id])
    if @timetable.nil?
      redirect_to timetables_path
    end
  end
end
