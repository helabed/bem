require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../db/seeds')

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

Given /^the products database is seeded$/ do
  #pending # express the regexp above with the code you wish you had
  #SeedDatabase::seed_db
  include SeedDatabase
  seed_db
end


When /^(?:|I )press "([^"]*)" and skip alert window$/ do |button|
  page.evaluate_script('window.confirm = function() { return true; }')
  #page.click("#{button}")
  click_button(button)
end

Then /^I switch to alert window$/ do
  #pending # express the regexp above with the code you wish you had

  # code below not working, got it from stack overflow: 
  #
  #page.driver.browser.switch_to.alert
end

Given /^no (.*) in database$/ do |records|
  model_for(records).delete_all
end

Then /^there should be "([^\"]*)" (.*)$/ do |num_records, records|
  model_for(records).count.should == num_records.to_i
end


When /^I press "([^"]*)" for "([^"]*)"$/ do |button, product|
  #pending # express the regexp above with the code you wish you had
  the_product = Product.find_by_title(product)
  button_id = "button_for_product_id_#{the_product.id}"
  click_button(button_id)
end

