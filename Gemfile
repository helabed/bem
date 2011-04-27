# A sample Gemfile
source "http://rubygems.org"

gem "rails", "3.0.3"

gem 'haml', '3.0.25'

gem 'will_paginate', '3.0.pre2'

gem 'capistrano'
gem 'capistrano-ext'

group :production do
  gem 'mysql2'
end

hostname = `hostname`
HOSTNAME = hostname.chomp if hostname

# see hack here: http://bendyworks.com/news/excluding-dev-and-test-gems-from-heroku
if false
group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails'
  gem 'annotate-models'
  gem 'faker'
  gem 'web-app-theme'
  gem 'heroku'
  gem 'looksee'
  gem 'wirble'
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  if HOSTNAME == 'maple.site5.com'  # eventhough cap deploy should exclude :development and :test, it is not for some reason.
    gem 'capybara'
  else
    gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git' # for testing javascript
  end
  gem 'pickle'
  gem 'pickler'
  gem 'launchy'
end
end


#group :test do
#  gem 'mysql2'
#  gem 'rspec', '2.0.0'
#  gem 'rspec-core', '2.0.0'
#  gem 'rspec-expectations', '2.0.0'
#  gem 'rspec-mocks', '2.0.0'
#  gem 'rspec-rails', '2.0.0'
#  
#  gem 'cucumber', '0.9.2'
#  gem 'cucumber-rails', '0.3.2'
#  gem 'database_cleaner', '0.5.2'
#  
#  gem 'selenium-client', '1.2.18'
#  gem 'term-ansicolor', '1.0.5'
#  gem 'webrat', '0.7.2'
#end
#
#group :development do
#  gem 'mysql2'
#end
