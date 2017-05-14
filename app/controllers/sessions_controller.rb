class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
