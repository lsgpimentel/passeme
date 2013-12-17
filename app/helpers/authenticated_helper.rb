module AuthenticatedHelper

  NOTIFICATIONS = {
    task_before_overdue: {
      icon: "group",
      color: "warning",
      message: ->(notification){ I18n.t("notification.task.before_overdue", task: notification.object.name) }
    },
    follow_up_next_day: {
      icon: "calendar",
      color: "success",
      message: ->(notification){ I18n.t("notification.follow_up.next_day", timetable: notification.object.timetable.name) }
    },
    follow_up_next_month: {
      icon: "group",
      color: "warning",
      message: ->(notification){ I18n.t("notification.follow_up.next_month", timetable: notification.object.timetable.name) }
    },
    follow_up_past_month: {
      icon: "group",
      color: "warning",
      message: ->(notification){ I18n.t("notification.follow_up.past_month", timetable: notification.object.timetable.name) }
    }
  }

  def notification_icon(notification)
    n = NOTIFICATIONS.detect { |k, v| k.to_s == notification.type }[1]

    content_tag :span, class: "label label-#{n[:color]}" do
      content_tag :i, '', class: "icon-#{n[:icon]}"
    end
  end

  def notification_message(notification)
    n = NOTIFICATIONS.detect { |k, v| k.to_s == notification.type }[1]
    n[:message].call(notification)
  end

end
