class CreateJoinTableCategoryTool < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :tools, table_name: :categorizations
  end
end
