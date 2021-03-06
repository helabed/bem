require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../db/seeds')

And /^(?:|I )sleep for (.+) seconds$/ do |seconds|
  sleep seconds.to_i
end

Given /^I am logged in as the user "([^"]*)" "([^"]*)" with email "([^"]*)"$/ do |first, last, email|
  user = Factory(:user, :admin => false, :email => email, :first_name => first, :last_name => last)
  visit signin_path
  fill_in 'Email',    :with => user.email
  fill_in 'Password', :with => user.password
  click_button "Login"
end

Given /^I am logged in as a user$/ do
  steps %{
    Given I am logged in as the user "Jane" "Shmoe" with email "jane@shmoe.com"
  }
end

Given /^I am logged in as the admin "([^"]*)" "([^"]*)" with email "([^"]*)"$/ do |first, last, email|
  user = Factory(:user, :admin => true, :email => email, :first_name => first, :last_name => last)
  visit signin_path
  fill_in 'Email',    :with => user.email
  fill_in 'Password', :with => user.password
  click_button "Login"
end

Given /^I am logged in as an admin$/ do
  steps %{
    Given I am logged in as the admin "hani" "mani" with email "hani@mani.com"
  }
end

Given /^the products database is seeded$/ do
  include SeedDatabase
  seed_db
end


When /^(?:|I )follow "([^"]*)" and skip alert window$/ do |link|
  page.evaluate_script('window.confirm = function() { return true; }')
  click_link(link)
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
    if button =~ /_one_item/i # tag with class minus_one_item or plus_one_item
      find(".#{button}").click
    else
      find_button(button).click
    end
  end
end

When /^I press "([^"]*)" for store item "([^"]*)"$/ do |button, product|
  the_product = Product.find_by_title(product)
  if button == 'minus_one_item'
    button_id = "minus_one_id_for_prod_#{the_product.id}"
  elsif button == 'plus_one_item'
    button_id = "plus_one_id_for_prod_#{the_product.id}"
  end
  find("##{button_id}").click
  #click_link(button_id)
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


And /I edit table row containing "(.*)"/ do |unique_text_to_help_locate_table_row|
  # Use capybara to find row based on 'unique_text_to_help_locate_table_row' text...
  # then find 'Edit' link in row
  within(:xpath, "//tr[.//*[contains(text(), '#{unique_text_to_help_locate_table_row}')]]") do
    find_link('Edit').click
  end
end


And /I Delete table row containing "(.*)" and skip alert window/ do |unique_text_to_help_locate_table_row|
  # Use capybara to find row based on 'unique_text_to_help_locate_table_row' text...
  # then find 'Delete' link in row
  page.evaluate_script('window.confirm = function() { return true; }')
  within(:xpath, "//tr[.//*[contains(text(), '#{unique_text_to_help_locate_table_row}')]]") do
    find_link('Delete').click
  end
end

Given /^PENDING/ do
  pending
end

Then /^(?:|I )should see \/([^\/]*)\/ in the cart$/ do |regexp|
  regexp = Regexp.new(regexp)
  if page.respond_to? :should
    page.should have_xpath("//div[@id='cart']", :text => regexp)
  else
    assert page.has_xpath?("//div[@id='cart']", :text => regexp)
  end
end
