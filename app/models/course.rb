class Course < ActiveRecord::Base
	belongs_to :department
	has_and_belongs_to_many :users -> { uniq }
	has_many :posts, dependent: :destroy
end
