class StaticController < ApplicationController
  # Welcome page
  def home
  end

  # Main page where index resources can be retrieved via AJAX
  def dashboard
    @clients = current_user.clients
  end
end
