require 'spec_helper'

describe MicropostsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a micropost" do
        lambda do
          integration_create_micropost @attr
          #post :create, :micropost => @attr
        end.should_not change(Micropost, :count)
      end

      it "should render the home page" do
        pending
        integration_create_micropost @attr
        #post :create, :micropost => @attr
        #response.should render_template('pages/home')
        #save_and_open_page
        current_path.should == '/home'
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a micropost" do
        lambda do
          #post :create, :micropost => @attr
          integration_create_micropost @attr
        end.should change(Micropost, :count).by(1)
      end

      it "should redirect to the home page" do
        pending
        integration_create_micropost @attr
        #post :create, :micropost => @attr
        #response.should redirect_to(root_path)
        # bug here
        current_path.should == home_path
      end

      it "should have a flash message" do
        integration_create_micropost @attr
        #post :create, :micropost => @attr
        #flash[:success].should =~ /micropost created/i
        #flash[:success].should =~ /micropost created/i
        page.should have_selector("div.flash", :text => 'Micropost created')
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @micropost = Factory(:micropost, :user => @user)
      end

      it "should deny access" do
        pending
        delete :destroy, :id => @micropost
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @micropost = Factory(:micropost, :user => @user)
      end

      it "should destroy the micropost" do
        pending
        lambda do
          delete :destroy, :id => @micropost
        end.should change(Micropost, :count).by(-1)
      end
    end
  end

end
