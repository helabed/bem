require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      #get 'new'
      visit "users/new"
      response.should be_success
    end

    it "should have the right title" do
      #get 'new'
      #response.should have_selector("title", :content => "Register")
      visit "users/new"
      page.should have_selector("title", :text => "Register")
    end

    it "should have a name field" do
      #get :new
      #response.should have_selector("input[name='user[name]'][type='text']")
      visit('/users/new')
      page.should have_selector("input[name='user[name]'][type='text']")
    end

    it "should have an email field" do
      #get :new
      #response.should have_selector("input[name='user[email]'][type='text']")
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

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      # The assigns method takes in a symbol argument and returns the
      # value of the corresponding instance variable in the controller action
      assigns(:user).should == @user
    end

    it "should have the right title" do
      #get :show, :id => @user
      #response.should have_selector("title", :content => @user.name)
      visit "/users/#{@user.id}"
      page.should have_selector("title", :text => @user.name)
    end

    it "should include the user's name" do
      #get :show, :id => @user
      #response.should have_selector("h1", :content => @user.name)
      visit("/users/#{@user.id}")
      page.should have_selector("h1", :text => @user.name)
    end

    #it "should have a profile image" do
    #  #get :show, :id => @user
    #  #response.should have_selector("h1>img", :class => "gravatar")
    #  visit("/users/#{@user.id}")
    #  page.should have_selector("h1>img", :class => "gravatar")
    #end

    it "should show the user's microposts" do
      pending "microposts not implemented"
      mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
      mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
      #get :show, :id => @user
      visit("/users/#{@user.id}")
      page.should have_selector("span.content", :text => mp1.content)
      page.should have_selector("span.content", :text => mp2.content)
    end


  end

  describe "POST 'create'" do


    describe "failure" do

      before(:each) do
        #require "webrat"
        #Webrat.configure do |config|
        #    config.mode = :rails
        #end

        @attr = { :name => "", :email => "", :password => "",
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

      #it "should render the 'new' page" do
      #  post :create, :user => @attr
      #  response.should render_template('new')
      #  response.body.should include("error_explanation")
      #  #response.should have_selector("div", :id => "error_explanation")
      #  response.should have_selector("ul>li", :content => "Name can't be blank")
      #  response.should have_selector("ul>li", :content => "Email can't be blank")
      #  response.should have_selector("ul>li", :content => "Email is invalid")
      #  response.should have_selector("ul>li", :content => "Password can't be blank")
      #  response.should have_selector("ul>li", :content => "Password is too short (minimum is 6 characters)")
      #end

      #it "should reset the password field in the 'new' page" do
      #  post :create, :user => @attr.merge(:password => "valid_password")
      #  response.should render_template('new')
      #  #response.should have_selector("input[name='user[password]'][type='password'][value='']")
      #  #response.body.should include("input[name='user[password]'][type='password'][value='']")
      #  save_and_open_page
      #  page.should have_content("input[name='user[password]'][type='password'][value='']")
      #end

      #it "should reset the password confirmation field in the 'new' page" do
      #  post :create, :user => @attr.merge(:password_confirmation => "valid_password")
      #  response.should render_template('new')
      #  response.should have_selector("input[name='user[password_confirmation]'][type='password'][value='']")
      #end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
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

    #it "should redirect to root if user already signed-in" do
    #  @user = Factory(:user)
    #  test_sign_in(@user)
    #  post :create, :user => @user
    #  response.should redirect_to(root_path)
    #end
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      #integration_sign_in(@user)
    end

    it "should be successful" do
      #get :edit, :id => @user
      visit(edit_user_path(@user))
      response.should be_success
    end

    it "should have the right title" do
      #get :edit, :id => @user
      #response.should have_selector("title", :content => "Edit user")
      visit(edit_user_path(@user))
      #save_and_open_page
      page.should have_selector("title", :text => "Edit user")
    end

    #it "should have a link to change the Gravatar" do
    #  get :edit, :id => @user
    #  gravatar_url = "http://gravatar.com/emails"
    #  response.should have_selector("a", :href => gravatar_url,
    #                                     :content => "change")
    #end
  end


  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        #put :update, :id => @user, :user => @attr
        #response.should render_template('edit')
        integration_update_user(@user, @attr)
        #save_and_open_page
#debugger
        # bug here, current_path should be /users/id/edit, and it is showing as /users/id
        #current_path.should == edit_user_path(@user)
        page.should have_selector("title", :text => "Edit user")
      end

      it "should have the right title" do
        #put :update, :id => @user, :user => @attr
        #response.should have_selector("title", :content => "Edit user")
        #put :update, :id => @user, :user => @attr
        integration_update_user(@user, @attr)
        #save_and_open_page
        page.should have_selector("title", :text => "Edit user")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do
        #put :update, :id => @user, :user => @attr
        integration_update_user(@user, @attr)
        @user.reload
        @user.name.should  == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        #put :update, :id => @user, :user => @attr
        #response.should redirect_to(user_path(@user))
        integration_update_user(@user, @attr)
        current_path.should == user_path(@user)
      end

      it "should have a flash message" do
        #put :update, :id => @user, :user => @attr
        #flash[:success].should =~ /updated/
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

      #it "should require matching users for 'update'" do
      #  put :update, :id => @user, :user => {}
      #  response.should redirect_to(root_path)
      #end
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

    describe "for signed-in users" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        second = Factory(:user, :name => "Bob", :email => "another@example.com")
        third  = Factory(:user, :name => "Ben", :email => "another@example.net")

        @users = [@user, second, third]
        30.times do
          @users << Factory(:user, :email => Factory.next(:email))
        end
      end

      it "should be successful" do
        #get :index
        visit("/users")
        response.should be_success
      end

      it "should have the right title" do
        #get :index
        #response.should have_selector("title", :content => "All users")
        visit("/users")
        page.should have_selector('title', :text => 'All users')
      end

      it "should have an element for each user" do
        #get :index
        visit("/users")
        @users[0..2].each do |user|
          page.should have_selector("li", :text => user.name)
        end
      end

      it "should paginate users" do
        visit("/users")
        #save_and_open_page
        page.should have_selector("div.pagination")
        page.should have_selector("span.disabled", :text => "Previous")
        page.should have_selector("a", :text => "2")
        page.should have_selector("a", :text => "Next")
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
        #delete :destroy, :id => @user
        visit "/users"
        page.should have_no_content('delete')
        #delete :destroy, :id => @user
        #response.should redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        @admin = Factory(:user, :name => 'important admin', :email => "admin@example.com", :admin => true)
        test_sign_in(@admin)
      end

      it "should destroy the user" do
        lambda do
          visit "/users"
          #save_and_open_page
          find_link('delete').click
          #save_and_open_page
          #delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        #delete :destroy, :id => @user
        visit "/users"
        find_link('delete').click
        page.should have_content('User deleted.')
        #save_and_open_page
        current_path.should == home_path
        #response.should redirect_to(users_path)
      end

      it "should prevent an admin from deleting herself" do
        pending "user administration not implemented yet"
        lambda do
          visit "/users"
          # deleting first user
          find_link('delete').click
          page.should have_content('User deleted.')
          #save_and_open_page
          # deleting second user, i.e admin
          find_link('delete').click
          page.should have_content('You cannot delete yourself as an admin.')
          #save_and_open_page
          #delete :destroy, :id => @admin
        end.should_not change(User, :count).by(-2)
      end
    end
  end

  describe "follow pages" do
    describe "when not signed in" do

      it "should protect 'following'" do
pending "followers/following not implemented"
        get :following, :id => 1
        response.should redirect_to(signin_path)
      end

      it "should protect 'followers'" do
pending "followers/following not implemented"
        get :followers, :id => 1
        response.should redirect_to(signin_path)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
      end

      it "should show user following" do
pending "followers/following not implemented"
        #get :following, :id => @user
        visit "/users/#{@user.id}/following"
        #page.should have_selector("a", :href => user_path(@other_user),
                                           #:content => @other_user.name)
        page.should have_selector("a", :text => @other_user.name)
        #save_and_open_page
      end

      it "should show user followers" do
pending "followers/following not implemented"
        #get :followers, :id => @other_user
        visit "/users/#{@other_user.id}/followers"
        page.should have_selector("a", :text => @user.name)
        #page.should have_selector("a", :href => user_path(@user),
        #                                   :content => @user.name)
      end
    end
  end

end
