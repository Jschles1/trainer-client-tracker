class SessionsController < ApplicationController
  def new
    @user = User.new
    @error = nil
  end

  def create
    if !params[:provider].nil?
      oauth_login
    elsif # If email and/or password are left blank:
      # redirect to login form with errors
    else
      normal_login
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

  def oauth_login
    @user = User.find_or_create_by(:uid => auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.provider = auth['provider']
      u.oauth_token = auth['credentials']['token']
      u.oauth_expires_at = auth['credentials']['expires_at']
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      # redirect to login form with errors
    end
  end

  def normal_login
    @user = User.find_by(email: params[:user][:email])
    if !!@user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      # redirect to login form with errors
    end
  end
end
