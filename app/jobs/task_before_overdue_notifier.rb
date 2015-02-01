class TaskBeforeOverdueNotifier
  
  NOTIFICATION_TYPE = :task_before_overdue

  def perform
    tasks = Task.where("due_in = ? AND done = ?", Date.tomorrow, false)

    tasks.each do |t|
      if t.user.can_receive_email_for(NOTIFICATION_TYPE)
        UserNotificationMailer.task_before_overdue(t)
      end
    end
  end

end
