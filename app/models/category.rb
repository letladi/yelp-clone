class Category < ApplicationRecord
	has_and_belongs_to_many(:businesses)
	has_many(:reviews)

	validates_presence_of :name
end