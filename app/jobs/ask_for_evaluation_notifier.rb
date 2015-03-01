class AskForEvaluationNotifier

  def perform
    User.to_ask_for_evaluation.each do |user|
      UserNotificationMailer.ask_for_evaluation(user).deliver
    end
  end

end
