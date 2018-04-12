class RemoveToolIdColumnFromOwnerImageAndAddToolReference < ActiveRecord::Migration[5.1]
  def change
    remove_column :owner_images, :tool_id
    add_reference :owner_images, :tool, foreign_key: true
  end
end
