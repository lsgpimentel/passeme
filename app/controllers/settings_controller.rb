class SettingsController < AuthenticatedController
  add_breadcrumb I18n.t('settings.breadcrumb'), :settings_path

  before_filter :check_user_is_owner_of_setting, :only => [:update, :toggle_make_tour_on_login]

  def index
    @setting = current_user.setting
  end

  def update
    @setting.update_attributes(settings_params)
    respond_to do |format|
      format.html { redirect_to action: :index }
    end
  end

  def toggle_make_tour_on_login
    @setting.toggle_make_tour_on_login!

    render nothing: true
  end

  private

  def settings_params
    params.require(:setting).permit(
      :make_tour_on_login,
      notification_settings_attributes: [:id, :type, :send_to_site, :send_to_email, :send_to_phone]
    )
  end

  def check_user_is_owner_of_setting
    @setting = current_user.setting
    if @setting.id.to_s != params[:id]
      redirect_to root_path
    end
  end

end
