class UsersController < ApplicationController
  before_action :user_authorized?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_authorized?
    if !logged_in?
      redirect_to login_path
    else
      @user = User.find(params[:id])
      if @user.id != current_user.id
        redirect_to user_path(current_user)
        flash[:alert] = "Sorry, you aren't authorized to view this page."
      end
    end
  end
end
