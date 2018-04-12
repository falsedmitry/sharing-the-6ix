class RemoveDateFromImageAndReview < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :date
    remove_column :images, :date
  end
end
