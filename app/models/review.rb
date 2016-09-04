class Review < ApplicationRecord
	belongs_to :user
	belongs_to :business

	validates_presence_of :rating, :description
	MIN_RATING = 1
	MAX_RATING = 5
	validates_inclusion_of :rating, in: (MIN_RATING..MAX_RATING)
	validates_uniqueness_of :user_id, scope: :business_id

	LIMIT = 6
	OFFSET = 0

	def self.recent_reviews(given_limit=LIMIT, given_offset=OFFSET)
		order(created_at: :desc).offset(given_offset).limit(given_limit)
	end
end