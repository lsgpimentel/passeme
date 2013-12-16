class TaskBeforeOverdueNotifier
  
  NOTIFICATION_TYPE = :task_before_overdue

  def perform
    tasks = Task.where("due_in = ? AND done = ?", Date.tomorrow, false)

    tasks.each do |t|
      t.user.notify(NOTIFICATION_TYPE, t)
    end
  end

end
