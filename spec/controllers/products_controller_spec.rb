require 'spec_helper'

describe ProductsController do
  render_views

  before(:each) do
    @base_title = "Beyt el Mouneh"
  end

  describe "GET 'index'" do
  #describe "GET 'index'", :type => :request do
    it "should require login for restricted areas" do
      visit '/products/index'
      #save_and_open_page
      page.should have_content("Please login to access this page")
    end

    it "should have the right title" do
      visit '/products/index'
      #response.should contain("#{@base_title}")
      #save_and_open_page
      page.should have_content("#{@base_title}")
      #response.should have_selector("title",
      #  :content => "#{@base_title}")
    end
  end

  describe 'home page', :type => :request do
    it 'should describe the site' do
      visit '/'
      page.should have_content("Beyt el Mouneh's products")
    end

    it 'should allow user to enter the site' do
      visit '/'
      #save_and_open_page
      #click_on 'enter_the_store'
      #response.should have_selector("title",
      #  :content => "#{@base_title} | Home")
      page.should have_content('Beyt el Mouneh Online Store')
    end
  end

end
