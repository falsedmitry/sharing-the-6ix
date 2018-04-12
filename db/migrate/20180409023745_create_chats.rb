class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.text :content
      t.boolean :unread
      t.boolean :owner_reply
      t.timestamps
    end
  end
end
