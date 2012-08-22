require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      visit "/users/new"
      response.should be_success
    end

    it "should have the right title" do
      visit "/users/new"
      page.should have_selector("title", :text => "Register")
    end

    it "should have a name fields" do
      visit('/users/new')
      page.should have_selector("input[name='user[first_name]'][type='text']")
      page.should have_selector("input[name='user[last_name]'][type='text']")
    end

    it "should have an email field" do
      visit('/users/new')
      page.should have_selector("input[name='user[email]'][type='text']")
    end

    it "should have a password field" do
      visit('/users/new')
      page.should have_selector("input[name='user[password]'][type='password']")
    end

    it "should have a password confirmation field" do
      visit('/users/new')
      page.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end

    it "should redirect to root if user already signed-in" do
      @user = Factory(:user)
      test_sign_in(@user)
      visit('/users/new')
      #page.should redirect_to(root_path)
      current_path.should == (root_path)
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        #require "webrat"
        #Webrat.configure do |config|
        #    config.mode = :rails
        #end

        @attr = { :first_name => "",
                  :last_name => "",
                  :email => "",
                  :address => "",
                  :phone => "",
                  :city => "",
                  :country => "",
                  :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        #post :create, :user => @attr
        #response.should have_selector("title", :content => "Register")
        visit(users_path(@attr))
        #save_and_open_page
        page.should have_selector("title", :text => "Login")
      end

      it "should not allow a user to be created as an admin" do
        attr = {  :first_name => "New",
                  :last_name  => "User",
                  :email => "user@example.com",
                  :address    => "13 rue edisson",
                  :phone      => "011-111-2222",
                  :city       => "Beirut",
                  :country    => "Lebanon",
                  :admin => true,
                  :password => "foobar",
                  :password_confirmation => "foobar" }

        lambda do
          post :create, :user => attr
        end.should change(User, :count).by(1)
        the_new_user = User.last
        the_new_user.name.should == "New User"
        the_new_user.admin.should == false
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :first_name => "New",
                  :last_name  => "User",
                  :email => "user@example.com",
                  :address    => "13 rue edisson",
                  :phone      => "011-111-2222",
                  :city       => "Beirut",
                  :country    => "Lebanon",
                  :password => "foobar",
                  :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :user => @attr
        response.should redirect_to(home_path)
      end

      it "should have a welcome message" do
        #lambda do
        #  post :create, :user => @attr
        #  flash[:success].should =~ /welcome to the sample app/i
        #end.should have_selector("div", :class => "flash success", :content => "Welcome to the Sample App!")
        post :create, :user => @attr
        #puts response.inspect
        #response.should have_selector("div", :class => "flash success", :content => "Welcome to the Sample App!")
        flash[:success].should =~ /welcome to beyt el mouneh/i
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      #integration_sign_in(@user)
    end

    it "should be successful" do
      #get :edit, :id => @user
      visit("/users/edit_profile?id=#{@user.id}")
      #visit(edit_user_path(@user))
      response.should be_success
    end

    it "should have the right title" do
      #get :edit, :id => @user
      #response.should have_selector("title", :content => "Edit user")
      visit("/users/edit_profile?id=#{@user.id}")
      #visit(edit_user_path(@user))
      #save_and_open_page
      page.should have_selector("title", :text => "Beyt el Mouneh | Edit user")
    end
  end


  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        #@attr = { :email => "", :name => "", :password => "",
        #          :password_confirmation => "" }
        @attr = { :first_name => "",
                  :last_name => "",
                  :email => "",
                  :address => "",
                  :phone => "",
                  :city => "",
                  :country => "",
                  :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        integration_update_user(@user, @attr)
        page.should have_selector("title", :text => "Beyt el Mouneh | Edit user")
      end

      it "should have the right title" do
        integration_update_user(@user, @attr)
        page.should have_selector("title", :text => "Beyt el Mouneh | Edit user")
      end

      it "should not allow a user to be updated to an admin" do
        attr = {  :first_name => "New",
                  :last_name  => "User",
                  :email => "user@example.com",
                  :address    => "13 rue edisson",
                  :phone      => "011-111-2222",
                  :city       => "Beirut",
                  :country    => "Lebanon",
                  :password => "foobar",
                  :password_confirmation => "foobar" }

        lambda do
          post :create, :user => attr

          the_new_user = User.last
          the_new_user.reload
          the_new_user.name.should == "New User"
          the_new_user.admin.should == false

          the_new_user.first_name = "new_First"
          the_new_user.last_name  = "new_Last"
          the_new_user.address    = "new_13 rue edisson"
          the_new_user.admin      = true
          the_new_user.admin.should == true

          put :update_profile, :id => the_new_user.id.to_s, :user => the_new_user

          the_new_user.reload
          the_new_user.name.should == "new_First new_Last"
          the_new_user.admin.should == false
        end.call.should == true
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :first_name => "New",
                  :last_name  => "Name",
                  :email => "user@example.com",
                  :address    => "13 rue edisson",
                  :phone      => "011-111-2222",
                  :city       => "Beirut",
                  :country    => "Lebanon",
                  :password => "barbaz",
                  :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do
        integration_update_user(@user, @attr)
        @user.reload
        @user.first_name.should  == @attr[:first_name]
        @user.last_name.should  == @attr[:last_name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        integration_update_user(@user, @attr)
        #save_and_open_page
        current_path.should == "/users/show_profile"
      end

      it "should have a flash message" do
        integration_update_user(@user, @attr)
        #save_and_open_page
        page.should have_selector('div.flash', :text => 'updated.')
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        #get :edit, :id => @user
        visit("/users/#{@user.id}/edit")
        #response.should redirect_to(root_path)
        current_path.should == root_path
      end
    end
  end

  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /login/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        visit "/users"
        current_path.should == signin_path
        #find_link('delete').click
        #delete :destroy, :id => @user
        #response.should redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        visit "/users"
        page.should have_no_content('delete')
      end
    end
  end

  describe "follow pages" do
    describe "when not signed in" do

    end

    describe "when signed in" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
      end
    end
  end

end
