class AddReviewToRating < ActiveRecord::Migration[5.1]
  def change
    add_reference :ratings, :review, foreign_key: true
  end
end
