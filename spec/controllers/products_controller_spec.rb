require 'spec_helper'

describe ProductsController do
  render_views

  before(:each) do
    @base_title = "Beyt el Mouneh"
  end

  describe "GET 'index'", :type => :request do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      visit '/index'
      #response.should contain("#{@base_title}")
      page.should have_content("#{@base_title}")
      #response.should have_selector("title",
      #  :content => "#{@base_title}")
    end
  end

  describe 'home page', :type => :request do
    it 'should describe the site' do
      visit '/'
      page.should have_content('A Supermarket with a twist!!')
    end

    it 'should allow user to enter the site' do
      visit '/'
      click_on 'enter_the_store'
      page.should have_content('Products')
    end
  end

end
