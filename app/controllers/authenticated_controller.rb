#
#Only authenticated users can access this controller or it's descendants.
#
class AuthenticatedController < ApplicationController
  before_filter :authenticate_user!

  add_breadcrumb I18n.t('authenticated.breadcrumb'), :root_path

end
