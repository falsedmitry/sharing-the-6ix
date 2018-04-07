class AddNeighbourhoodReferenceToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :neighbourhood, foreign_key: true
  end
end
