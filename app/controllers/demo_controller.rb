class DemoController < ApplicationController

  def login
    if current_user
      sign_out current_user
    end
    demo_user = User.find_by_email 'demo@passeme.com'
    sign_in demo_user

    redirect_to subdomain: ''
  end

end
