class UsersController < ApplicationController
  before_filter :authenticate, :except => [:new, :create]
  before_filter :correct_user, :only => [:edit_profile, :update_profile, :show_profile]
  before_filter :admin_user,   :only => [:destroy, :edit, :update, :show, :index]

  active_scaffold :user do |config|

    config.actions = [:list, :nested, :subform, :update, :delete, :show]

    config.list.columns.exclude :encrypted_password, :salt,
                                :followers, :following,
                                :relationships, :reverse_relationships,
                                :microposts,
                                :password_reset_sent_at,
                                :password_reset_token

    config.update.columns.exclude :encrypted_password, :salt, :orders,
                                :followers, :following,
                                :relationships, :reverse_relationships,
                                :microposts
  end

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
    # no need for @users or any instance vars, active scaffold will take care of views
    super
  end

  def show
    super
  end

  def show_profile
    @cart = current_cart
    @user = User.find(params[:id])
    @title = @user.name
    render 'show_profile', :layout => 'store'
  end

  def create
    @cart = current_cart

    if signed_in? and current_user?(@user)
      redirect_to root_path
    else
      exception_occured = false
      User.transaction do
        begin
          @user = User.new(params[:user])
          if @user.save
            @user.prepare_activation_token
            UserMailer.registration_confirmation(@user).deliver
            sign_in @user
            flash[:success] = "Welcome to Beyt el Mouneh"
            redirect_to home_path
          else
            @title = "Register"
            render 'new', :layout => 'store'
          end
        rescue Exception => e
          sign_out
          exception_occured = true
          flash.now[:error] = "an error occured while saving your info, please try again"
          logger.error "Exception while saving user or emailing confirmation: #{e.message}"
          logger.error "Exception backtrace: #{e.backtrace.join("\n")}"
          raise ActiveRecord::Rollback
        ensure
          if exception_occured
            @user = User.new(params[:user])
            @title = "Register"
            render 'new', :layout => 'store'
          end
        end
      end
    end
  end

  def edit
    @title = "Edit user"
    super
  end

  def update
    @title = "Updating user"
    the_user_to_update = User.find(params[:id])
    if current_user.admin and current_user?(the_user_to_update) and (params[:admin] == false or params[:record][:admin] == '0')
      # admin trying to demote himself or herself
      message = "You cannot demote yourself as an admin to a regular user, find another admin to do it for you."
      flash[:error] = message
      the_user_to_update.errors.add(:admin, message)
      params[:record][:admin] = '1' # reset to 'admin'
    end
    super
  end

  def edit_profile
    @cart = current_cart
    @title = "Edit user"
    render 'edit_profile', :layout => 'store'
  end

  def update_profile
    @cart = current_cart
    attr = nil
    if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      attr = {  :first_name => params[:user][:first_name],
                :last_name  => params[:user][:last_name ],
                :email      => params[:user][:email     ],
                :address    => params[:user][:address   ],
                :phone      => params[:user][:phone     ],
                :city       => params[:user][:city      ],
                :country    => params[:user][:country   ]
            }
    else
      attr = params[:user]
    end
    if @user.update_attributes(attr)
      flash[:success] = "Profile updated."
      redirect_to :action => :show_profile, :id => @user.id, :layout => 'store'
    else
      @title = "Edit user"
      render 'edit_profile', :layout => 'store'
    end
  end

  def destroy
    the_user_to_delete = User.find(params[:id])
    @record = the_user_to_delete   # used by active scaffold
    if current_user?(the_user_to_delete)
      message = "You cannot delete yourself as an admin, find another admin to do it for you."
      flash[:error] = message
      the_user_to_delete.errors.add(:user, message)
      return
    else
      super
    end
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
