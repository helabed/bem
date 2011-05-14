class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  #before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def new
    @cart = current_cart
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
      @title = 'Register with us'
      render :layout => 'store'
    end
  end

  def index
    @title = "All users"
    #@users = User.all
    @users = User.paginate(:page => params[:page])
  end


  def show
    @cart = current_cart
    @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
    render 'show', :layout => 'store'
  end

  def create
    @cart = current_cart
    # WHY did this fail on me
    #redirect_to root_path if signed_in?
    # AND I had to use the if..else..end statement below ??
    if signed_in?
      redirect_to root_path if signed_in?
    else
      @user = User.new(params[:user])
      if @user.save
        # Handle a successful save.
        sign_in @user
        flash[:success] = "Welcome to Beyt el Mouneh"
        redirect_to home_path
      else
        #flash[:error] = "Oh Ooh, something went wrong!!, please re-register"
        @title = "Register"
        @user.password = ''
        @user.password_confirmation = ''
        render 'new', :layout => 'store'
      end
    end
  end

  def edit
    @cart = current_cart
    #@user = User.find(params[:id]) # moved to correct_user
    @title = "Edit user"
    render 'edit', :layout => 'store'
  end

  def update
    @cart = current_cart
    #@user = User.find(params[:id]) # moved to correct_user
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user, :layout => 'store'
    else
      @title = "Edit user"
      render 'edit', :layout => 'store'
    end
  end

  def destroy
    the_user_to_delete = User.find(params[:id])
    if current_user?(the_user_to_delete)
      flash[:error] = "You cannot delete yourself as an admin."
    else
      the_user_to_delete.destroy
      flash[:success] = "User deleted."
    end
    #redirect_to users_path
    redirect_to home_path
  end

  def following
    show_follow(:following)
  end

  def followers
    show_follow(:followers)
  end

  def show_follow(action)
    @title = action.to_s.capitalize
    @user = User.find(params[:id])
    @users = @user.send(action).paginate(:page => params[:page])
    render 'show_follow'
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
