module AuthenticatedHelper

  NOTIFICATIONS = {
    group_blabla: {
      icon: "group",
      color: "warning",
      message: ->(notification){ I18n.t("notification.blabla", group: notification.object.name) }
    },
    syllabus_blabla: {
      icon: "calendar",
      color: "success",
      message: ->(notification){ I18n.t("notification.blabla", group: notification.object.name) }
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
