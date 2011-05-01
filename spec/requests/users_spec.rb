require 'spec_helper'

describe "Users" do
  
  describe "signup" do

    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button "Sign up"
          page.should have_selector("div.flash.success",
                                        :text => "Welcome")
          #response.should render_template('users/show')
          current_path.should == user_path(1)
          current_path.should == '/users/1'
        end.should change(User, :count).by(1)
      end
    end
    
    describe "failure" do
    
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          #response.should render_template('users/new')
          page.should have_selector("div#error_explanation")
          #save_and_open_page
          # bug in here
          #current_path.should == new_user_path
          page.should have_selector("title", :text => "Sign up")
        end.should_not change(User, :count)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        user = Factory(:user)
        user.email, user.password = '', ''
        integration_sign_in user
        page.should have_selector("div.flash.error", :text => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in user
        #controller.should be_signed_in
        current_path.should == user_path(user)
        click_link "Sign out"
        current_path.should == root_path
        #controller.should_not be_signed_in
      end
    end
  end

  describe "delete link" do
    it "should show 'delete' link for admins" do
      user = Factory(:user, :admin => true)
      integration_sign_in user
      visit users_path
      page.should have_selector("a", :text => "delete")
    end

    it "should not show 'delete' link for non-admins" do
      user = Factory(:user, :admin => false)
      integration_sign_in user
      visit users_path
      page.should_not have_selector("a", :text => "delete")
    end
  end
end
