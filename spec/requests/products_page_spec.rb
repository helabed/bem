require 'spec_helper'

describe 'products page' do

  before(:each) do
    @user = Factory(:user, :admin => true)
    integration_sign_in(@user)
  end

  it "supports js", :js => true do
    #save_and_open_page
    #sleep 5
    visit products_path
    sleep 5
    click_link "test js"
    sleep 5
    page.should have_content("js works")
    visit products_path
    click_on "test button js"
    sleep 5
    page.should have_content("js button works")
  end

  #it 'lets the user add a product', :js => true do
  #active scaffold does not use AJAX, but in reality it uses HTTP request and its animation simulates an Ajax web 2.0 site
  it 'lets the user add a product', :js => true  do
    visit products_path
    click_on 'Create New'  # this be an Ajax button -- only works with Selenium
    fill_in 'Title', :with => 'Foule Mudammas'
    fill_in 'Description', :with => 'tasty fava beans'
    fill_in 'Price', :with => '9.99'
    attach_file 'Image', (File.dirname(__FILE__)+'/../../public/images/foule_mudammas.jpg')
    click_on 'Create'  # this be an Ajax button -- only works with Selenium
    page.should have_content('Foule Mudammas')
    page.should have_content('tasty fava beans')
    page.should have_content('9.99')
    click_on 'Edit'  # this be an Ajax button -- only works with Selenium
    fill_in 'Price', :with => '9.77'
    click_on 'Update'  # this be an Ajax button -- only works with Selenium
    page.should have_content('9.77')
  end
end
