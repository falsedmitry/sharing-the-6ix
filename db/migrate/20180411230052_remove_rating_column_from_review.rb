class RemoveRatingColumnFromReview < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :rating
  end
end
