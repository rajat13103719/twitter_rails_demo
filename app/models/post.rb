class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	enum status: [:draft,:published,:deleted]
	include Likeable
end
