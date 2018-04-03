class AddUserReferenceToTool < ActiveRecord::Migration[5.1]
  def change
    add_reference :tools, :user, foreign_key: true
  end
end
