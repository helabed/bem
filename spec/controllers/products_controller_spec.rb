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
end
