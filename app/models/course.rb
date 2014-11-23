class Course < ActiveRecord::Base
	belongs_to :department, inverse_of: :courses
	has_and_belongs_to_many :users, -> { uniq }
	has_many :posts, as: :postable	#allows polymorphic posts
	has_many :comments, as: :commentable
	has_many :favorites, as: :favoritable

  scope :num, lambda { order("courses.number ASC") }
	scope :recent, lambda { order("courses.updated_at DESC") }
end
