require "json"

class ChatsController < ApplicationController
  before_action :load_chat, only: [:edit, :update]
  before_action :require_login
  before_action :require_user_authority, only: [:edit, :update]

  def index
    @chats = Chat.all.select("max(id) as id", :user_id, :tool_id).group(:tool_id, :user_id).order(:tool_id, :user_id)
  end

  def create
    @chat = Chat.new
    @chat.content = params[:chat][:content]
    @chat.tool_id = params[:tool_id]
    @chat.user = current_user
    @chat.unread = true
    @chat.owner_reply = false
    if @chat.save
      UserMailer.owner_chat(@chat).deliver_now
      flash[:notice] = "The message is sent to the owner with email notification."
    else
      flash[:alert] = "The message is failed in sending to the owner."
    end
    if request.xhr?
      respond_to do |format|
        format.html do
          render partial: "chat", locals: {chat: @chat}
        end
        format.json do
          render json: {
            name: @chat.tool.owner.name,
            date: @chat.created_at.localtime,
            content: @chat.content
          }
        end
      end
    else
      redirect_to tool_url(params[:tool_id])
    end
  end

  def edit
    if current_user == @chat0.tool.owner
      Chat.where("tool_id = ?", @chat0.tool_id).where("user_id = ?", @chat0.user.id).where("owner_reply = ?", false).update_all(unread: false)
    else
      Chat.where("tool_id = ?", @chat0.tool_id).where("user_id = ?", @chat0.user.id).where("owner_reply = ?", true).update_all(unread: false)
    end
    @chats = Chat.where("tool_id = ?", @chat0.tool_id).where("user_id = ?", @chat0.user.id).order(created_at: :asc)
    @chat = @chats[-1]
  end

  def update
    @chat = Chat.new
    @chat.content = params[:chat][:content]
    @chat.tool = @chat0.tool
    @chat.user = @chat0.user
    @chat.unread = true
    if current_user == @chat0.tool.owner
      @chat.owner_reply = true
    else
      @chat.owner_reply = false
    end
    if @chat.save
      if current_user == @chat0.tool.owner
        UserMailer.requester_chat(@chat).deliver_now
        flash[:notice] = "The message is sent to the requester with email notification."
      else
        UserMailer.owner_chat(@chat).deliver_now
        flash[:notice] = "The message is sent to the owner with email notification."
      end
    else
      flash[:alert] = "The message is failed in sending to the requester."
    end
    if request.xhr?
      respond_to do |format|
        format.html do
          render partial: "chat", locals: {chat: @chat}
        end
        format.json do
          render json: {
            name: @chat.tool.owner.name,
            date: @chat.created_at.localtime,
            content: @chat.content
          }
        end
      end
    else
      redirect_to edit_chat_url(params[:id])
    end
  end

  def load_chat
    @chat0 = Chat.find(params[:id])
  end

  def require_user_authority
    unless current_user == @chat0.user || current_user == @chat0.tool.owner
      flash[:alert] = "You are not authorized to modify this chat."
      redirect_to login_url
    end
  end

  def ajax_update

  end

end
