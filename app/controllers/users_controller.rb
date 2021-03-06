class UsersController < ApplicationController
  before_action :already_logged_in?

  # User Signup form
  def new
    @user = User.new
  end

  # Submission of User Signup Form
  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
