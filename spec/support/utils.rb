include ApplicationHelper

def sign_in(user, options={})
  if options[:no_capybara]
    #Devise built-in sign_in method
    #Only works in controller specs
    sign_in FactoryGirl.create(:user)
  else
    visit new_user_session_path
    fill_in "E-Mail", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end
