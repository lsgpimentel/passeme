class UserNotificationMailer < ActionMailer::Base

  def task_before_overdue(task)
    @task = task
    mail(to: task.user.email, subject: "Tarefa expirando em #{I18n.l task.due_in}")
  end

  def follow_up_next_day(event_instances, user)
    @user = user
    @events = event_instances
    mail(to: @user.email, subject: "O que estudar amanhã (#{I18n.l Date.tomorrow})")
  end

  def follow_up_next_month(event_instances, user)
    @user = user
    @events = event_instances
    @month_formatted = Date.current.next_month.strftime('%m/%Y')
    mail(to: @user.email, subject: "O que estudar no próximo mês (#{@month_formatted})")
  end

  def follow_up_past_month(event_instances, user)
    @user = user
    @events = event_instances
    @month_formatted = Date.current.prev_month.strftime('%m/%Y')
    mail(to: @user.email, subject: "Estudado no mês passado (#{@month_formatted})")
  end

end
