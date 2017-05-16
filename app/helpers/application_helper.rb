module ApplicationHelper
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def login_required
    redirect_to login_path if !logged_in?
  end

  def already_logged_in?
    redirect_to clients_path if logged_in?
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
