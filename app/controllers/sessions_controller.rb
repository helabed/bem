class SessionsController < ApplicationController
  layout 'store'

  def new
    @title = "Login"
    @cart = current_cart
  end

  def create
    @cart = current_cart
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Login"
      render :new
    else
      sign_in user
      flash[:success] = "Welcome back to Beyt el Mouneh"
      redirect_to home_path
    end
  end

  def destroy
    sign_out
    flash[:success] = "Thank you for shopping at Beyt el Mouneh"
    redirect_to root_path
  end
end
