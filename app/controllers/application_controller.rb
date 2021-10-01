class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_user
    redirect_to login_path, alert: "You must be logged in to perform that action" if current_user.nil?
  end

  
end
