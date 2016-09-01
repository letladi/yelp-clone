class Business < ApplicationRecord
	has_and_belongs_to_many :category

	validates_presence_of :name
end