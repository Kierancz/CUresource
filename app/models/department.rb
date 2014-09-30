class Department < ActiveRecord::Base
	has_many :courses
	has_many :posts
	has_and_belongs_to_many :users, -> {uniq}
end
