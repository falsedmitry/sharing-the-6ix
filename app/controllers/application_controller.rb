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

  def unread_message_count
    current_user.owned_chats.where("unread = ?", true).where("owner_reply = ?", false).count + current_user.chats.where("unread = ?", true).where("owner_reply = ?", true).count
  end

  helper_method :unread_message_count

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
