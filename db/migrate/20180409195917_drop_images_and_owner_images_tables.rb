class DropImagesAndOwnerImagesTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :images
    drop_table :owner_images
  end
end
