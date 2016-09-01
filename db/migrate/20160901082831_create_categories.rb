class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
    	t.string :name
    	t.timestamps
    end

    create_table :businesses do |t|
    	t.string :name
    	t.timestamps
    end

    create_table :business_categories do |t| 
    	t.belongs_to :category 
    	t.belongs_to :business
    end

    create_table :reviews do |t|
    	t.belongs_to :business
    	t.belongs_to :user
    	t.timestamps
    end
  end
end
