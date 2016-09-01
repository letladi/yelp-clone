class Business < ApplicationRecord
	belongs_to :category
	has_many :reviews

	validates_presence_of :name
end