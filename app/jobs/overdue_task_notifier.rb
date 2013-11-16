class OverdueTaskNotifier
  
  #NOTIFICATION_TYPE = :overdue_task
  NOTIFICATION_TYPE = :group_blabla

  def perform
    tasks = Task.where("due_in = ? AND done = ?", Date.tomorrow, false)

    tasks.each do |t|
      t.user.notify(NOTIFICATION_TYPE, t)
    end
  end

end
