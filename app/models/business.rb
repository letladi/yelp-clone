class Business < ApplicationRecord
	has_and_belongs_to_many :category
	has_many :reviews

	validates_presence_of :name
end