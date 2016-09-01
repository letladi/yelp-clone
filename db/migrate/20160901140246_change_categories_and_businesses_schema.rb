class ChangeCategoriesAndBusinessesSchema < ActiveRecord::Migration[5.0]
  def change
  	drop_table :businesses_categories
  	add_column :businesses, :category_id, :integer
  end
end
