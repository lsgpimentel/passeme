class FollowUpNextMonthNotifier
  
  NOTIFICATION_TYPE = :follow_up_next_month

  def perform
    tasks = Task.where("due_in = ? AND done = ?", Date.tomorrow, false)

    tasks.each do |t|
      t.user.notify(NOTIFICATION_TYPE, t)
    end
  end

end