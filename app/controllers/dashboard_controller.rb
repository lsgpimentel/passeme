class DashboardController < AuthenticatedController
  include TasksHelper
  add_breadcrumb "Dashboard", :index_path

  def index
    @tasks = current_user.tasks

    load_tasks_count

  end
end
