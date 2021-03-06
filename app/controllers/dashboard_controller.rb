class DashboardController < AuthenticatedController
  include TasksHelper
  add_breadcrumb I18n.t('dashboard.breadcrumb'), :index_path

  def index
    @tasks = current_user.tasks
    @active_timetable = current_user.timetables.where(active: true)[0]
    @show_dashboard_tour = current_user.setting.make_tour_on_login?

    load_tasks_count

  end
end
