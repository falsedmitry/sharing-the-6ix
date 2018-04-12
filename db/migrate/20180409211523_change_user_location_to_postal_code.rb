class ChangeUserLocationToPostalCode < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :location, :postal_code
  end
end
