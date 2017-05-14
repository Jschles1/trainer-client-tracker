class SessionsController < ApplicationController
  def new
  end

  def create
    if !params[:provider].nil?
      oauth_login
    elsif # If email and/or password are left blank:
      # ...
    else
      normal_login
    end
  end

  def destroy
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
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end
end
