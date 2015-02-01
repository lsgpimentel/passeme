class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  #before_filter :set_locale

  protected

  def configure_permitted_parameters
    # TODO Customize the permitted parameters in the future
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    #    devise_parameter_sanitizer.for(:account_update) do |u|
    #      u.permit(:name,
    #               :email, :password, :password_confirmation, :current_password)
    #    end
  end

  #def default_url_options(options = {})
  #  { locale: I18n.locale }
  #end

  #TODO Redirect to default locale page if locale is not set in the url
  def set_locale
    # Logged in user locale takes precedence
    locale = current_user.locale unless current_user.nil? 
    # Otherwise use the locale specified in the parameter
    locale = locale || params[:locale]

    if locale && I18n::available_locales.map(&:to_s).include?(locale.to_s)
      I18n.locale = locale
    else
      I18n.locale = I18n.default_locale

      #redirect_to "/#{I18n.locale}"
    end
  end

end
