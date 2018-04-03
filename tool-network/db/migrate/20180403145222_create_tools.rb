class CreateTools < ActiveRecord::Migration[5.1]
  def change
    create_table :tools do |t|
      t.string :name
      t.boolean :on_loan
      t.integer :condition
      t.text :description
      t.integer :loan_length
      t.timestamps
    end
  end
end
