class UserNotificationMailer < ActionMailer::Base

  def task_before_overdue(task, user)
    @task = task
    @user = user
    mail(to: @user.email, subject: "Tarefa expirando em #{task.due_in}")
  end

  def follow_up_next_day()
    mail(to: @user.email, subject: "O que estudar amanhã (#{Date.tomorrow})")
  end

  def follow_up_next_month
    mail(to: @user.email, subject: "O que estudar no próximo mês (#{Date.tomorrow})")
  end

  def follow_up_past_month
    mail(to: @user.email, subject: "Estudado no mês passado (#{Date.tomorrow})")
  end

end
