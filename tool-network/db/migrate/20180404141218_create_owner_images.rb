class CreateOwnerImages < ActiveRecord::Migration[5.1]
  def change
    create_table :owner_images do |t|
      t.string :file_name
      t.integer :tool_id
      t.timestamps
    end
  end
end
