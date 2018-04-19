class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  def unread_owner_message_count
    self.user.chats.where("tool_id = ?", tool.id).where("unread = ?", true).where("owner_reply = ?", false).count
  end

  def unread_borrower_message_count
    self.user.chats.where("tool_id = ?", tool.id).where("unread = ?", true).where("owner_reply = ?", true).count
  end
end
