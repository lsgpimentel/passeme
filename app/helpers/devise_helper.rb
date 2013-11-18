module DeviseHelper

  # merge the devise messages with the normal flash messages
  def devise_flash
    if controller.devise_controller? && resource.errors.any?
      flash.now[:error] = flash[:error].to_a.concat resource.errors.full_messages
      flash.now[:error].uniq!
    end
  end

  def back_button
    content_tag :button, id: "back-btn", type: "button", class: "btn" do
      concat content_tag :i, '', class: "m-icon-swapleft"
      concat " " + t("buttons.back")
    end
  end

  def submit_button text, options = {}
    options[:class] = "m-icon-swapright m-icon-white"
    content_tag :button, type: "submit", class: "btn green pull-right" do
      concat text + " "
      concat content_tag :i, '', options
    end
  end

end
