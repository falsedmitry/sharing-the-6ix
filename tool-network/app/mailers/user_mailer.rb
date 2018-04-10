class UserMailer < ApplicationMailer
  default from: "toolnetwork2018@gmail.com"

  def owner_chat(chat)
    @chat = chat
    mail to: @chat.tool.owner.email, subject: "New Chat Message in Sharing the 6ix"
  end

  def requester_chat(chat)
    @chat = chat
    mail to: chat.user.email, subject: "New Chat Message in Sharing the 6ix"
  end

end
