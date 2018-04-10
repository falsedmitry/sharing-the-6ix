class AddNbhdImageToNeighbourhoods < ActiveRecord::Migration[5.1]
  def change
    add_column :neighbourhoods, :nbhd_image, :string
  end
end
