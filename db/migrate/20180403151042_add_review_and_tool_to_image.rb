class AddReviewAndToolToImage < ActiveRecord::Migration[5.1]
  def change
      add_reference :images, :tool, foreign_key: true
      add_reference :images, :review, foreign_key: true
  end
end
