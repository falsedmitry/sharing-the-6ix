class AddPicturesToTools < ActiveRecord::Migration[5.1]
  def change
    add_column :tools, :owner_pictures, :json
  end
end
