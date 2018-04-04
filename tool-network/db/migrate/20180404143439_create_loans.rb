class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.date :due_date
      t.date :start_date
      t.timestamps
    end
  end
end
