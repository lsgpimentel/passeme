module Notifiable extend ActiveSupport::Concern

  def get_setting(object, type)
    if object.respond_to?(:user)
      type_enum = NotificationSetting.type.values.find { |i| i == type.to_s }
      object.user.setting.notification_settings.find_by_type(type_enum.value)
    else
      raise ArgumentError.new("The object doesn't have a user.")
    end
  end

  def notify(type, object)
    setting = get_setting(object, type)
    if setting

      if setting.send_to_site?
        Notification.create(user: object.user, type: type, object: object, sent_to: :site)
      end
      if setting.send_to_email?
        Notification.create(user: object.user, type: type, object: object, sent_to: :email)
      end
      if setting.send_to_phone?
        Notification.create(user: object.user, type: type, object: object, sent_to: :phone)
      end

    end
    
  end

end
