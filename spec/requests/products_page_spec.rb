require 'spec_helper'

describe 'products page' do
  #it 'lets the user add a product', :js => true do
  #active scaffold does not use AJAX, but in reality it uses HTTP request and its animation simulates an Ajax web 2.0 site
  it 'lets the user add a product' do
    visit products_path
    click_on 'Create New'  # this be an Ajax button -- only works with Selenium
    fill_in 'Title', :with => 'Fool Mudamas'
    fill_in 'Description', :with => 'tasty fava beans'
    fill_in 'Price', :with => '9.99'
    #save_and_open_page
    click_on 'Create'  # this be an Ajax button -- only works with Selenium
    page.should have_content('Fool Mudamas')
    page.should have_content('tasty fava beans')
    page.should have_content('9.99')
    #save_and_open_page
    click_on 'Edit'  # this be an Ajax button -- only works with Selenium
    fill_in 'Price', :with => '9.77'
    click_on 'Update'  # this be an Ajax button -- only works with Selenium
    page.should have_content('9.77')
    #save_and_open_page
  end
end
