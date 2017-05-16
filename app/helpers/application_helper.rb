module ApplicationHelper
  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  ef user_authorized?
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
