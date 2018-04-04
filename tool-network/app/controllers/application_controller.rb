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

  def get_loan(user, tool)
    Loan.find_by(user_id: user.id, tool_id: tool.id)
  end

  helper_method :current_user, :get_loan

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
