class PasswordResetsController < ApplicationController

  before_filter :require_no_user

  def new
    render
  end

  def create
    @user = User.new
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "To get your password back, please check the instructions that we've sent to your " + @user.email + " email address."
      redirect_to new_user_session_url
    else
      flash[:notice] = "No user was found with that email address."
      render :action => :new
      #redirect_to new_password_reset_url
    end
  end


    before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "Password successfully updated."
      redirect_to new_user_session_url
    else
      flash[:notice] = "There was a problem updating your password."
      render :action => :edit
      #redirect_to edit_password_reset_url
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
      unless @user
      flash[:notice] = "We're sorry, but we could not locate your account.
      If you are having issues try copying and pasting the URL
      from your email into your browser or restarting the
      reset password process."
      redirect_to new_user_session_url
    end
  end
end