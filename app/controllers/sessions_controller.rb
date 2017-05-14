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
end
