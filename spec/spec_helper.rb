# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# these are needed to load capybara integration
require 'capybara/rspec'
require 'capybara/rails'

unless @cucumber_running #don't require autorun for cucumber
  # following line added after upgrade of rspec from 2.5 to 2.8
  require 'rspec/autorun'
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true
  config.use_transactional_fixtures = false

  config.include(MailerMacros)
  config.before(:each) { reset_email }

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before :each do
    DatabaseCleaner.start
  end
  config.after :each do
    DatabaseCleaner.clean
  end

  # same as in login
  def test_sign_in(user)
    #controller.sign_in(user)
    integration_sign_in(user)
  end

  # same as in login
  def integration_sign_in(user)
    visit signin_path
#debugger
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    #save_and_open_page
    #sleep 10
    click_button "Login"
    #sleep 10
  end

  # same as in register
  def integration_sign_up(user)
    visit signup_path
    fill_in "First name",   :with => user.first_name
    fill_in "Last name",    :with => user.last_name
    fill_in "Email",        :with => user.email
    fill_in "Address",      :with => user.address
    fill_in "Phone",        :with => user.phone
    select  user.city,      :from => "City"
    select  user.country,   :from => "Country"
    fill_in "Password",     :with => user.password
    fill_in "Confirmation", :with => user.password_confirmation
    click_button "Register"
  end

  def integration_update_user(user, attr)
    visit("/users/edit_profile?id=#{user.id}")
    #visit edit_user_path(user)
    fill_in "First name",   :with => attr[:first_name]
    fill_in "Last name",    :with => attr[:last_name]
    fill_in "Email",        :with => attr[:email]
    fill_in "Address",      :with => attr[:address]
    fill_in "Phone",        :with => attr[:phone]
    select  attr[:city],    :from => "City"
    select  attr[:country], :from => "Country"
    fill_in "Password",     :with => attr[:password]
    fill_in "Confirmation", :with => attr[:password_confirmation]
#    save_and_open_page
#debugger
    click_button "Update"
#    save_and_open_page
  end

  def integration_create_micropost(attr)
    visit home_path
    fill_in "micropost_content",         :with => attr[:content]
#    save_and_open_page
#debugger
    click_button "Submit"
#    save_and_open_page
  end

end
