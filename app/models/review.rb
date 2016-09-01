class Review < ApplicationRecord
	belongs_to :user
	belongs_to :business

	validates_presence_of :rating, :description
	validates_inclusion_of :rating, in: (1..5)
end