class Review < ApplicationRecord
	belongs_to :user
	belongs_to :business

	validates_presence_of :rating, :description
	validates_inclusion_of :rating, in: (1..5)
	validates_uniqueness_of :user_id, scope: :business_id

	def self.recent_reviews
		limit(6).order(created_at: :desc)
	end
end