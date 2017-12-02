module ApplicationHelper
  # If @user isn't already set, find user in db with id matching session[:user_id] and assign to @user
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  # User redirected if not logged in
  def login_required
    redirect_to login_path if !logged_in?
  end

  # User redirected if already logged in
  def already_logged_in?
    redirect_to clients_path if logged_in?
  end
end
