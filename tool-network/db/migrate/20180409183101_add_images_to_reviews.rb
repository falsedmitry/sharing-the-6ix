class AddImagesToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :images, :json
  end
end
