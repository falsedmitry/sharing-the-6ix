class RemoveDateFromImageAndReview < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :date
  end
end
