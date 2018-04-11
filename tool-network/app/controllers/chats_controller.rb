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
      UserMailer.owner_chat(@chat).deliver_later
      flash[:notice] = "The message is sent to the owner with email notification."
    else
      flash[:alert] = "The message is failed in sending to the owner."
    end
    redirect_to tool_url(params[:tool_id])
  end

  def edit
    chat = Chat.find(params[:id])
    @chats = Chat.where("tool_id = ?", chat.tool_id).where("user_id = ?", chat.user.id)
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
      UserMailer.requester_chat(@chat).deliver_later
      flash[:notice] = "The message is sent to the requester with email notification."
    else
      flash[:alert] = "The message is failed in sending to the requester."
    end
    redirect_to edit_chat_url(params[:id])
  end
end
