module SettingsHelper
  def type_can_be_sent_to?(type, where_to_send)
    where_it_can_be_sent = NotificationSetting.types_and_where_they_can_be_sent.find { |k, v| k == type.to_sym }[1]
    return true if where_it_can_be_sent.include? where_to_send
  end
end
