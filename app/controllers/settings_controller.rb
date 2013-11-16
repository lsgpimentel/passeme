class SettingsController < AuthenticatedController
  add_breadcrumb "Settings", :settings_path

  def index
    @setting = current_user.setting
    #TODO New por enquanto, deve pegar o que já está no BD
  end

  def update

  end

end
