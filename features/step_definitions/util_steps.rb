require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')

And /^(?:|I )sleep for (.+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Given /^I am logged in as an admin$/ do
  #pending # express the regexp above with the code you wish you had
  user = Factory(:user, :admin => true)
  visit signin_path
  #save_and_open_page
  fill_in 'Email',    :with => user.email
  fill_in 'Password', :with => user.password
  #save_and_open_page
  click_button "Login"
end

