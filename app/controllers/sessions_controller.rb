class SessionsController < ApplicationController
  before_action :already_logged_in?, only: [:new]

  # User Login form
  def new
    @user = User.new
  end

  # Submission of User Login form
  def create
    # Determine whether user is logging in through facebook or not
    if request.env['omniauth.auth'] != nil
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      normal_login
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

  private

  # Logging in without Facebook
  def normal_login
    if params[:user][:email].blank? || params[:user][:password].blank?
      redirect_to login_path, alert: "Log-in failed."
    else
      # Find user with matching email in database
      @user = User.find_by(email: params[:user][:email])
      # Use bcrypt to authenticate user password
      if !!@user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        redirect_to login_path, alert: "Log-in failed."
      end
    end
  end
end
