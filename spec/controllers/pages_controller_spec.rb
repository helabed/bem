require 'spec_helper'

describe PagesController do
  render_views

  #before(:each) do
  #  Capybara.current_driver = :webrat
  #end

  #after(:all) do
  #  Capybara.use_default_driver  # switch back to default driver
  #end

  before(:each) do
    @base_title = "Beyt el Mouneh"
  end

  describe "GET 'home'" do
    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        get 'home'
        response.should be_success
      end

      it "should have the right title" do
        get 'home'
        #response.should have_selector("title",
        #  :content => "#{@base_title} | Home")
        response.body.should include("#{@base_title} | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        visit '/home'
        #get :home
        #response.should have_selector("a", :href => following_user_path(@user),
        #                                   :content => "0 following")
        #response.should have_selector("a", :href => followers_user_path(@user),
        #                                   :content => "1 follower")
        #save_and_open_page
        page.should have_content('0 following')
        page.should have_content('1 follower')
        #page.html.should match /'<span id="following" class="stat"> 0 following <\/span>'/
        #response.body.should include("0 following")
        #response.body.should include("1 follower")
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
