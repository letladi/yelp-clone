class RenameBusinessCategoriesTable < ActiveRecord::Migration[5.0]
  def change
  	rename_table :business_categories, :businesses_categories
  end
end
