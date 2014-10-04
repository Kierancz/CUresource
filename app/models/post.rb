class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :postable, polymorphic: true	#http://guides.rubyonrails.org/association_basics.html#polymorphic-associations
	belongs_to :department
	belongs_to :course
	validates :department_id, :course_id, presence: true
end
