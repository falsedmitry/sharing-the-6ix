class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      not_authenticated
    end
  end

  helper_method :current_user

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
