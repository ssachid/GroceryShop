class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  # returns the currently logged in user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # checks if the user is logged_in?
  def logged_in?
    !!current_user
  end

  # sets the flash and redirects to root path if user not logged in
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
