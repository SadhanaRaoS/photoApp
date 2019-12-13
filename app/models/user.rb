class User < ApplicationRecord
	has_secure_password
	validates :username, :password, presence: true
	validates :username, uniqueness: true
	# def authenticate(password)
	# 	return if password == self.password
	# end
end
