class Post < ActiveRecord::Base
	belongs_to :user, touch: true #updates the updated_at timestamp whenever post is saved
	belongs_to :postable, polymorphic: true	#http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
	belongs_to :department, counter_cache: true	#for counting number of posts in department
	belongs_to :course, counter_cache: true
	has_many :favorites, as: :favoritable

	validates :title, presence: true, uniqueness: true
	validates :content, presence: true
	acts_as_commentable

	scope :recent, lambda { order("posts.updated_at DESC") }
	#scope :fav, 
	#	lambda { 
	#	select("posts.*, count(favorites.id) AS favorite_post_count").
	#	joins(:favorite_posts).
	#	group("posts.id").
	#	order("favorite_post_count DESC")
	#	}
end
