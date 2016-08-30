class User < ApplicationRecord
	validates_presence_of :first_name, :last_name, :email, :password

	has_secure_password
end