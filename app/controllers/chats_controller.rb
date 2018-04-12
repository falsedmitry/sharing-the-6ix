require "json"

class ChatsController < ApplicationController

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
    chat = Chat.find(params[:id])
    Chat.where("tool_id = ?", chat.tool_id).where("user_id = ?", chat.user.id).where("owner_reply = ?", false).update_all(unread: false)
    @chats = Chat.where("tool_id = ?", chat.tool_id).where("user_id = ?", chat.user.id).order(created_at: :asc)
    @chat = @chats[-1]
  end

  def update
    chat = Chat.find(params[:id])
    @chat = Chat.new
    @chat.content = params[:chat][:content]
    @chat.tool = chat.tool
    @chat.user = chat.user
    @chat.unread = true
    @chat.owner_reply = true
    if @chat.save
      UserMailer.requester_chat(@chat).deliver_now
      flash[:notice] = "The message is sent to the requester with email notification."
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
end
