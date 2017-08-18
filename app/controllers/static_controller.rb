class StaticController < ApplicationController
  def home
  end

  def dashboard
    @clients = current_user.clients
  end
end
