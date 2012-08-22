require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Beyt el Mouneh"
  end

  describe "GET 'home'" do
    describe "when not signed in" do

      before(:each) do
        visit '/home'
      end

      it "should be successful" do
        visit 'home'
        response.should be_success
      end

      it "should have the right title" do
        visit 'home'
        #save_and_open_page
        #response.should have_selector("title",
        #  :content => "#{@base_title} | Home")
        page.should have_content("#{@base_title} | Home")
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.body.should include("#{@base_title}" + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.body.should include("#{@base_title}" + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.body.should include("#{@base_title}" + " | Help")
    end
  end
end
