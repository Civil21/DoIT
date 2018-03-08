class Category < ApplicationRecord
	has_many :categorings
	has_many :questions, through: :categorings
end
