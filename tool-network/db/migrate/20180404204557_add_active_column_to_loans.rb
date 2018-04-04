class AddActiveColumnToLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :active, :boolean
  end
end
