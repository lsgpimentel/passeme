source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails', '~> 4.0.0'

group :development, :test do
  gem 'childprocess'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
end

group :development do
  gem "bullet", github: 'flyerhzm/bullet'
  gem 'annotate', github: 'ctran/annotate_models'
  gem "better_errors", github: 'charliesome/better_errors'
  gem "lol_dba", github: 'plentz/lol_dba'
  gem "quiet_assets", github: 'evrone/quiet_assets'
  gem "rails-footnotes", github: 'josevalim/rails-footnotes'
  #gem "rails_best_practices", github: 'railsbp/rails_best_practices'
  gem "request-log-analyzer", github: 'wvanbergen/request-log-analyzer'
  gem "xray-rails", github: 'brentd/xray-rails'
  gem "traceroute", github: 'amatsuda/traceroute'
  gem "reek", github: 'troessner/reek'
  #gem "rails-erd", "~> 1.1.0"
  gem "binding_of_caller", github: 'banister/binding_of_caller'
  gem "rack-mini-profiler", github: 'MiniProfiler/rack-mini-profiler', require: false
  #TODO review and generate foreign keys later
  gem 'immigrant',github: 'jenseng/immigrant' 
  gem "brakeman", "~> 2.1.2", :require => false
  gem 'railroady', github: 'preston/railroady'
  gem 'pry-byebug', github: 'deivid-rodriguez/pry-byebug'
end

group :test do
  gem 'rspec-rails', '2.14.0'
  gem 'guard-rspec', '~> 4.0.0'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'guard-spork', '~> 1.5.1'
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails'
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
gem "devise", "~> 3.4.1"
gem "devise-async", github: 'mhfs/devise-async'
gem 'omniauth'
gem 'omniauth-facebook', github: 'mkdynamic/omniauth-facebook'
gem 'omniauth-google-oauth2', github: 'zquestz/omniauth-google-oauth2'
gem "cancan", "~> 1.6.10"
#gem "prawn", "~> 0.12.0"
gem "breadcrumbs_on_rails", "~> 2.3.0"
#gem "wicked", "~> 1.0.0"
gem "recaptcha", "~> 0.3.5"
#gem 'mailboxer', github: 'ging/mailboxer'
#gem "state_machine", "~> 1.2.0"
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
gem 'jquery-datatables-rails',"~> 1.12.2"
gem 'jquery-simplecolorpicker-rails', github: 'tkrotoff/jquery-simplecolorpicker-rails'
gem "haml-rails", "~> 0.5.2"
gem "table_print", "~> 1.5.1"
gem "descriptive_statistics", github: 'thirtysixthspan/descriptive_statistics', require: 'descriptive_statistics/safe'
gem 'rb-readline'
gem 'nokogiri'
gem 'premailer-rails', '~> 1.8.0'
#gem 'responders', github: 'plataformatec/responders'
  



group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor', '0.0.2'
  gem 'thin'
end
