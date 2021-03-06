module Notifiable extend ActiveSupport::Concern

  def get_setting(type, user)
    if user.present?
      type_enum = NotificationSetting.type.values.find { |i| i == type.to_s }
      user.setting.notification_settings.find_by_type(type_enum.value)
    else
      raise ArgumentError.new("The user is not set.")
    end
  end

  def notify(type, object, user)
    setting = get_setting(type, user)
    if setting

      if setting.send_to_site?
        Notification.create(user: user, type: type, object: object, sent_to: :site)
      end
      if setting.send_to_email?
        Notification.create(user: user, type: type, object: object, sent_to: :email)
      end
      if setting.send_to_phone?
        Notification.create(user: user, type: type, object: object, sent_to: :phone)
      end

    end
  end

end
