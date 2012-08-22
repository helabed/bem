require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    #get '/'
    visit '/home'
    page.should have_content("Home")
    page.should have_selector('title', :text => "Home")
  end

  it "should have a Contact page at '/contact'" do
    visit '/contact'
    page.should have_selector('title', :text => "Contact")
  end

  it "should have an About page at '/about'" do
    visit '/about'
    page.should have_selector('title', :text => "About")
  end
  
  it "should have a signup page at '/signup'" do
    visit '/signup'
    page.should have_selector('title', :text => "Register")
  end

  it "should have the right links on the layout" do
    visit home_path
    click_link "About"
    page.should have_selector('title', :text => "About")
    click_link "Contact"
    page.should have_selector('title', :text => "Contact")
    click_link "Home"
    page.should have_selector('title', :text => "Home")
    visit '/'
    click_link 'Login'
    page.should have_selector('title', :text => "Login")
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      click_link 'Login'
      page.should have_selector("a", :href => signin_path,
                                         :text => "Login")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should have a signout link" do
      visit home_path
      page.should have_selector("a", :href => signout_path,
                                         :text => "Logout")
    end

    it "should have a profile link" do
      visit home_path
      page.should have_selector("a", :href => user_path(@user),
                                         :text => "Profile")
    end
  end
end

