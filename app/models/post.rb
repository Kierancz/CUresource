class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :department
	belongs_to :course
	validates :department_id, :course_id, presence: true
end
