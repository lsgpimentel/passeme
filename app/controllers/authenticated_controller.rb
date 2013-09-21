#
#Only authenticated users can access this controller or it's descendants.
#
class AuthenticatedController < ApplicationController
  before_filter :authenticate_user!

  add_breadcrumb "Home", :root_path

end
