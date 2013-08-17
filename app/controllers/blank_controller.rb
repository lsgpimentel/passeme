class BlankController < ApplicationController

  add_breadcrumb "Home", :root_path

  def index

    add_breadcrumb "Index", :index_path
  end

end
