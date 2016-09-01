class Business < ApplicationRecord
	belongs_to :category
	has_many :reviews

	validates_presence_of :name

	def rating
		if reviews.empty?
			rating = 0.0
		else
			rating = reviews.map(&:rating).inject(&:+) / review_count.to_f
		end
		rating.round(1)
	end

	def review_count
		reviews.size
	end
end