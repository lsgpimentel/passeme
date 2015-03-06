module TasksHelper
  def load_tasks_count
    @all_tasks_count = current_user.tasks.count
    @pending_tasks_count = current_user.pending_tasks.count
    @done_tasks_count = current_user.done_tasks.count
    @overdue_tasks_count = current_user.overdue_tasks.count
  end

  def formatted(due_in)
    if due_in.nil?
      I18n.t ('tasks.no_due_in')
    else
      I18n.l due_in
    end
  end

end
