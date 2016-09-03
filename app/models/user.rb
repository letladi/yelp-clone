class User < ApplicationRecord
	validates_presence_of :first_name, :last_name, :email, :password
	has_many :reviews

	has_secure_password

	def review_count
		reviews.count
	end
end