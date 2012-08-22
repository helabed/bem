require 'spec_helper'

describe "Users" do
  
  describe "signup" do

    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "First name",   :with => "Example"
          fill_in "Last name",    :with => "User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Address",      :with => "101 main st"
          fill_in "Phone",        :with => "608-888-9990"
          select  "Beirut",       :from => "City"
          select  "Lebanon",      :from => "Country"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button "Register"
          page.should have_selector("div.flash.success",
                                        :text => "Welcome")
          current_path.should == home_path
          current_path.should == '/home'
        end.should change(User, :count).by(1)
      end
    end
    
    describe "failure" do
    
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "First name",   :with => ""
          fill_in "Last name",    :with => ""
          fill_in "Email",        :with => ""
          fill_in "Address",      :with => ""
          fill_in "Phone",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Register"
          page.should have_selector("div#error_explanation")
          page.should have_selector("title", :text => "Register")
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
        current_path.should == home_path
        click_link "Logout"
        current_path.should == root_path
      end
    end
  end
end
