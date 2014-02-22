source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '~> 4.0.0'

group :development, :test do
  gem 'rspec-rails', '2.14.0'
  gem 'guard-rspec', '~> 4.0.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '~> 1.5.1'
  gem 'childprocess'
  gem "bullet", "~> 4.6.0"
  gem 'annotate', "~> 2.5.0"
  gem "better_errors", "~> 1.0.1"
  gem "lol_dba", "~> 1.6.0"
  gem "quiet_assets", "~> 1.0.2"
  gem "rails-footnotes", "~> 3.7.9"
  gem "rails_best_practices", "~> 1.14.0"
  gem "request-log-analyzer", "~> 1.12.9"
  gem "xray-rails", "~> 0.1.6"
  gem "traceroute", "~> 0.3.0"
  gem "reek", "~> 1.3.2"
  gem "rails-erd", "~> 1.1.0"
  gem "binding_of_caller", "~> 0.7.2"
  gem "rack-mini-profiler", "~> 0.1.31"
  #TODO review and generate foreign keys later
  gem 'immigrant',github: 'jenseng/immigrant' 
  gem "brakeman", "~> 2.1.2", :require => false
  gem 'railroady', github: 'preston/railroady'
end

group :test do
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'email_spec', github: 'bmabey/email-spec'
end

gem 'sass-rails', '4.0.0'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.0'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '~> 1.3.1'
gem "jquery-turbolinks", "~> 2.0.1"
gem 'jbuilder', '1.5.0'
gem "therubyracer", :require => 'v8'
gem 'bootstrap-sass', '2.3.2.0'
gem 'pg'
gem 'bcrypt-ruby', '3.0.1'
gem "ffaker", "~> 1.18.0"
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
gem "devise", "~> 3.0.2"
gem 'omniauth', '~> 1.1.4'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-google-oauth2', github: 'zquestz/omniauth-google-oauth2'
gem "cancan", "~> 1.6.10"
gem "prawn", "~> 0.12.0"
gem "breadcrumbs_on_rails", "~> 2.3.0"
gem "wicked", "~> 1.0.0"
gem "recaptcha", "~> 0.3.5"
#gem 'mailboxer', github: 'ging/mailboxer'
gem "state_machine", "~> 1.2.0"
#gem 'friendly_id', '5.0.0.beta1'
gem "icalendar", "~> 1.4.1"
gem "i18n-js", "~> 2.1.2"
#gem "public_activity", "~> 1.1.0"
gem "simple_form", "~> 3.0.0.rc"
gem "figaro", "~> 0.7.0"
gem "google-api-client", "~> 0.6.4"
gem "validates_timeliness", "~> 3.0.14"
gem 'gritter', github: 'lsgpimentel/gritter'
gem 'sprockets-urlrewriter',github: 'lsgpimentel/sprockets-urlrewriter' 
gem "enumerize", "~> 0.7.0"
gem "simple-navigation", "~> 3.11.0"
gem 'foreigner',github: 'matthuhiggins/foreigner' 
gem "clockwork", "~> 0.6.2"
gem "delayed_job_active_record", "~> 4.0.0"
gem 'merit',github: 'tute/merit' 
gem "ice_cube", "~> 0.11.1"
gem 'nested_form', github: 'ryanb/nested_form'
gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
gem 'jquery-simplecolorpicker-rails', github: 'tkrotoff/jquery-simplecolorpicker-rails'
gem "haml-rails", "~> 0.5.2"
gem "table_print", "~> 1.5.1"
gem "descriptive_statistics", github: 'thirtysixthspan/descriptive_statistics', require: 'descriptive_statistics/safe'

#gem 'responders', github: 'plataformatec/responders'
  



group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor', '0.0.2'
end
