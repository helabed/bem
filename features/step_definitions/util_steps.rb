require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../db/seeds')

And /^(?:|I )sleep for (.+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Given /^I am logged in as an admin$/ do
  user = Factory(:user, :admin => true)
  visit signin_path
  #save_and_open_page
  fill_in 'Email',    :with => user.email
  fill_in 'Password', :with => user.password
  #save_and_open_page
  click_button "Login"
end

Given /^the products database is seeded$/ do
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
  the_product = Product.find_by_title(product)
  button_id = "button_for_product_id_#{the_product.id}"
  click_button(button_id)
end

Then /^I fill in the update field of "([^"]*)" with "([^"]*)"$/ do |product, quantity|
    # I had problem nailing this XPath because of presence of 2 different tables that contained
    # the product names, so I had to pre-qualify my xpath with //div[@id='ordered_items']
  within(:xpath, "//div[@id='ordered_items']//tr[.//*[contains(text(), '#{product}')]]") do
    fill_in('line_item[quantity]', :with => quantity)
  end

end

When /^I press "([^"]*)" for cart item "([^"]*)"$/ do |button, product|
  within(:xpath, "//div[@id='ordered_items']//tr[.//*[contains(text(), '#{product}')]]") do
      # the commented out line below was searching the whole document, it was not abiding by
      # the within clause. As described by jnicklas, https://github.com/jnicklas/capybara,
      # 'Beware of the XPath // trap... '//' means anywere in document.
    #find(:xpath, "//input[starts-with(@id,'ordered_item_update_button_id')]").click
    if button =~ /delete/i
      page.evaluate_script('window.confirm = function() { return true; }')
    end
    find_button(button).click
  end

end


And /I delete table row containing "(.*)"/ do |unique_text_to_help_locate_table_row|
  # Use capybara to find row based on 'unique_text_to_help_locate_table_row' text...
  # then find 'Delete' link in row
  page.evaluate_script('window.confirm = function() { return true; }')
  within(:xpath, "//tr[.//*[contains(text(), '#{unique_text_to_help_locate_table_row}')]]") do
    find_link('Delete').click
  end
end


And /I show table row containing "(.*)"/ do |unique_text_to_help_locate_table_row|
  # Use capybara to find row based on 'unique_text_to_help_locate_table_row' text...
  # then find 'Show' link in row
  within(:xpath, "//tr[.//*[contains(text(), '#{unique_text_to_help_locate_table_row}')]]") do
    find_link('Show').click
  end
end

Given /^PENDING/ do
  pending
end

