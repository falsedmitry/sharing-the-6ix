class ReferenceForChat < ActiveRecord::Migration[5.1]
  def change
    add_reference :chats, :tool, foreign_key: true
    add_reference :chats, :user, foreign_key: true
  end
end
