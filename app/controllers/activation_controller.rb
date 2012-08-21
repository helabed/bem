class ActivationController < ApplicationController
  layout 'store'

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.prepare_activation_token if user
    UserMailer.activation_instructions(user).deliver
    redirect_to :root, :notice => "Email sent with activation instructions."
  end

  def edit
    update
  end

  def update
    begin
      @user = User.find_by_activation_token!(params[:id])
        # if activation is older than 1 week ago.
      if @user and @user.activation_sent_at < 1.week.ago
        redirect_to new_activation_path, :alert => "Activation token has expired."
      elsif @user
        @user.active = true
        @user.save!
         @message = "Activation successful, enjoy our website!"
         render :update
      else
        redirect_to new_activation_path, :alert => "Please request a new Activation token via email."
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to new_activation_path, :alert => "Please request a new Activation token via email."
    end
  end

end
